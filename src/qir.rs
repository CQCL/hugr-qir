pub mod futures_ext;
pub mod qsystem_ext;
pub mod result_ext;
pub mod tket2_ext;

use anyhow::{bail, ensure, Result};
use hugr::{
    extension::prelude::qb_t,
    llvm::{extension::PreludeCodegen, CodegenExtension, CodegenExtsBuilder},
    ops::Value,
    HugrView,
};
use hugr::{llvm as hugr_llvm, Node};
use hugr_llvm::emit::libc::emit_libc_abort;
use hugr_llvm::emit::RowPromise;
use hugr_llvm::inkwell;
use hugr_llvm::inkwell::values::BasicValueEnum;
use inkwell::{context::Context, types::BasicType};
use itertools::Itertools;
use tket2_hseries::extension::futures;

use hugr_llvm::{
    emit::{emit_value, EmitFuncContext},
    types::TypingSession,
};

#[derive(Clone, Debug)]
/// Customises how we lower prelude ops, types, and constants.
pub struct QirPreludeCodegen;

impl PreludeCodegen for QirPreludeCodegen {
    fn qubit_type<'c>(&self, session: &TypingSession<'c, '_>) -> impl BasicType<'c> {
        let iw_ctx = session.iw_context();
        iw_ctx
            .get_struct_type("Qubit")
            .unwrap_or_else(|| iw_ctx.opaque_struct_type("Qubit"))
            .ptr_type(Default::default())
    }

    fn emit_panic<H: HugrView<Node = Node>>(
        &self,
        ctx: &mut EmitFuncContext<H>,
        _err: BasicValueEnum,
    ) -> Result<()> {
        emit_libc_abort(ctx)
    }

    fn emit_print<H: HugrView<Node = Node>>(
        &self,
        _ctx: &mut EmitFuncContext<H>,
        _text: inkwell::values::BasicValueEnum,
    ) -> Result<()> {
        Ok(()) // we don't want to convert print, just do nothing
    }
}

/// Returns the qir "Result" type.
fn result_type(ctx: &Context) -> impl BasicType<'_> {
    ctx.get_struct_type("Result")
        .unwrap_or_else(|| ctx.opaque_struct_type("Result"))
        .ptr_type(Default::default())
}

/// Emits a call to a qir gate fuction.
/// This function takes some number of angles as doubles, followed by some
/// number of qubits as Qubit pointers.
fn emit_qis_gate<'c, H: HugrView<Node = Node>>(
    context: &mut EmitFuncContext<'c, '_, H>,
    func: impl AsRef<str>,
    angles: impl AsRef<[BasicValueEnum<'c>]>,
    qbs: impl AsRef<[BasicValueEnum<'c>]>,
) -> Result<Vec<BasicValueEnum<'c>>> {
    let (func, angles, qbs) = (func.as_ref(), angles.as_ref(), qbs.as_ref());
    let iw_ctx = context.iw_context();
    let qb_ty = context.llvm_type(&qb_t())?;
    let f64_ty = iw_ctx.f64_type();
    ensure!(
        angles.iter().all(|v| v.get_type() == f64_ty.into()),
        "angles must be of type f64"
    );
    ensure!(
        qbs.iter().all(|v| v.get_type() == qb_ty),
        "qbs must be of type Qubit"
    );

    let args_tys = angles
        .iter()
        .chain(qbs)
        .copied()
        .map(|x| x.get_type().into())
        .collect_vec();
    let func_ty = iw_ctx.void_type().fn_type(&args_tys, false);
    let func = context.get_extern_func(func, func_ty)?;

    let func_inputs = angles.iter().chain(qbs).copied().map_into().collect_vec();
    context.builder().build_call(func, &func_inputs, "")?;
    Ok(qbs.iter().copied().collect_vec())
}

/// A helper to emit a qir gate function as [emit_qis_gate], and then finish a
/// [RowPromise] with the qubit inputs.
fn emit_qis_gate_finish<'c, H: HugrView<Node = Node>>(
    context: &mut EmitFuncContext<'c, '_, H>,
    func: impl AsRef<str>,
    angles: impl AsRef<[BasicValueEnum<'c>]>,
    qbs: impl AsRef<[BasicValueEnum<'c>]>,
    outputs: RowPromise<'c>,
) -> Result<()> {
    let outs = emit_qis_gate(context, func, angles, qbs)?;
    outputs.finish(context.builder(), outs)
}

/// A helper to emit a qir measure function and return the result as a Result
/// pointer.
fn emit_qis_measure_to_result<'c, H: HugrView<Node = Node>>(
    context: &mut EmitFuncContext<'c, '_, H>,
    qb: BasicValueEnum<'c>,
) -> Result<BasicValueEnum<'c>> {
    let iw_ctx = context.iw_context();
    let res_t = result_type(iw_ctx);
    let conv_t = res_t.fn_type(&[qb.get_type().into()], false);
    let conv_func = context.get_extern_func("__QIR__CONV_Qubit_TO_Result", conv_t)?;

    let Some(result) = context
        .builder()
        .build_call(conv_func, &[qb.into()], "")?
        .try_as_basic_value()
        .left()
    else {
        bail!("expected a result from measure")
    };

    let measure_t = iw_ctx
        .void_type()
        .fn_type(&[qb.get_type().into(), result.get_type().into()], false);
    let measure_func = context.get_extern_func("__quantum__qis__mz__body", measure_t)?;

    context
        .builder()
        .build_call(measure_func, &[qb.into(), result.into()], "")?
        .try_as_basic_value()
        .left();

    Ok(result)
}

/// A helper to convert a Result pointer to a (representation of) a hugr bool.
fn emit_qis_read_result<'c, H: HugrView<Node = Node>>(
    context: &mut EmitFuncContext<'c, '_, H>,
    result: BasicValueEnum<'c>,
) -> Result<BasicValueEnum<'c>> {
    let iw_ctx = context.iw_context();
    let read_result_t = iw_ctx
        .bool_type()
        .fn_type(&[result.get_type().into()], false);
    let read_result_func =
        context.get_extern_func("__quantum__qis__read_result__body", read_result_t)?;
    let Some(result_i1) = context
        .builder()
        .build_call(read_result_func, &[result.into()], "")?
        .try_as_basic_value()
        .left()
    else {
        bail!("expected a bool from read_result")
    };
    let true_val = emit_value(context, &Value::true_val())?;
    let false_val = emit_value(context, &Value::false_val())?;
    Ok(context
        .builder()
        .build_select(result_i1.into_int_value(), true_val, false_val, "")?)
}

/// A helper to emit a qir __quantum__rt__qubit_release call.
fn emit_qis_qfree<'c, H: HugrView<Node = Node>>(
    context: &mut EmitFuncContext<'c, '_, H>,
    qb: BasicValueEnum<'c>,
) -> Result<()> {
    let iw_ctx = context.iw_context();
    let qfree_t = iw_ctx.void_type().fn_type(&[qb.get_type().into()], false);
    let qfree_func = context.get_extern_func("__quantum__rt__qubit_release", qfree_t)?;
    context.builder().build_call(qfree_func, &[qb.into()], "")?;
    Ok(())
}

/// A helper to emit a qir __quantum__rt__qubit_allocate call.
/// Returns a qir Qubit pointer.
fn emit_qis_qalloc<'c, H: HugrView<Node = Node>>(
    context: &mut EmitFuncContext<'c, '_, H>,
) -> Result<BasicValueEnum<'c>> {
    let qb_ty = context.llvm_type(&qb_t())?;
    let qalloc_t = qb_ty.fn_type(&[], false);
    let qalloc_func = context.get_extern_func("__quantum__rt__qubit_allocate", qalloc_t)?;
    let Some(qb) = context
        .builder()
        .build_call(qalloc_func, &[], "")?
        .try_as_basic_value()
        .left()
    else {
        bail!("expected a qubit from qalloc")
    };
    Ok(qb)
}

#[derive(Clone, Debug)]
pub struct QirCodegenExtension;

impl CodegenExtension for QirCodegenExtension {
    fn add_extension<'a, H: HugrView<Node = Node> + 'a>(
        self,
        builder: CodegenExtsBuilder<'a, H>,
    ) -> CodegenExtsBuilder<'a, H>
    where
        Self: 'a,
    {
        builder
            .simple_extension_op::<tket2::Tk2Op>({
                let s = self.clone();
                move |context, args, op| s.emit_tk2op(context, args, op)
            })
            .simple_extension_op::<tket2_hseries::extension::result::ResultOpDef>({
                let s = self.clone();
                move |context, args, op| s.emit_result_op(context, args, op)
            })
            .simple_extension_op::<tket2_hseries::extension::qsystem::QSystemOp>({
                let s = self.clone();
                move |context, args, op| s.emit_qsystem_op(context, args, op)
            })
            .simple_extension_op::<tket2_hseries::extension::futures::FutureOpDef>({
                let s = self.clone();
                move |context, args, op| s.emit_futures_op(context, args, op)
            })
            .custom_type(
                (
                    futures::EXTENSION_ID,
                    futures::FUTURE_TYPE_NAME.to_string().into(),
                ),
                {
                    let s = self.clone();
                    move |session, custom_type| s.convert_future_type(session, custom_type)
                },
            )
    }
}
