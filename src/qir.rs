pub mod tket2_ext;
pub mod result_ext;
// pub mod qsystem_ext;

use anyhow::{anyhow, bail, ensure, Result};
use hugr::llvm as hugr_llvm;
use hugr::std_extensions::arithmetic::float_types::float64_type;
use hugr::{
    extension::{
        prelude::{qb_t, ConstString},
        simple_op::MakeExtensionOp as _,
    },
    llvm::{extension::PreludeCodegen, CodegenExtension, CodegenExtsBuilder},
    ops::{ExtensionOp, Value},
    HugrView,
};
use hugr_llvm::emit::RowPromise;
use hugr_llvm::inkwell;
use hugr_llvm::inkwell::values::BasicValueEnum;
use inkwell::{
    context::Context,
    types::{BasicMetadataTypeEnum, BasicType, FloatType},
    values::BasicMetadataValueEnum,
};
use itertools::Itertools;
use ::tket2::extension::rotation::rotation_type;
use tket2_hseries::extension::result::{ResultOp, ResultOpDef};

use hugr_llvm::{
    emit::{emit_value, EmitFuncContext, EmitOpArgs},
    sum::LLVMSumValue,
    types::{HugrSumType, TypingSession},
};

#[derive(Clone, Debug)]
pub struct QirPreludeCodegen;

impl PreludeCodegen for QirPreludeCodegen {
    fn qubit_type<'c>(&self, session: &TypingSession<'c, '_>) -> impl BasicType<'c> {
        let iw_ctx = session.iw_context();
        iw_ctx
            .get_struct_type("QUBIT")
            .unwrap_or_else(|| iw_ctx.opaque_struct_type("QUBIT"))
            .ptr_type(Default::default())
    }
}

fn result_type(ctx: &Context) -> impl BasicType<'_> {
    ctx.get_struct_type("RESULT")
        .unwrap_or_else(|| ctx.opaque_struct_type("RESULT"))
        .ptr_type(Default::default())
}

// fn emit_rotation_to_angle<'c,H>(context: &mut EmitFuncContext<'c, '_, H>,
//                           rotation: BasicValueEnum<'c>,
// ) -> Result<BasicValueEnum<'c>> {

// }

fn emit_qir_qis_call<'c, H: HugrView>(
    context: &mut EmitFuncContext<'c, '_, H>,
    func: impl AsRef<str>,
    angles: impl AsRef<[BasicValueEnum<'c>]>,
    qbs: impl AsRef<[BasicValueEnum<'c>]>,
    outputs: RowPromise<'c>
) -> Result<()> {
    let (func, angles, qbs) = (func.as_ref(), angles.as_ref(), qbs.as_ref());
    let iw_ctx = context.iw_context();
    let qb_ty = context.llvm_type(&qb_t())?;
    let f64_ty = iw_ctx.f64_type();
    ensure!(outputs.len() == qbs.len(), "outputs and qbs must have the same length");
    ensure!(angles.iter().all(|v| v.get_type() == f64_ty.into()), "angles must be of type f64");
    ensure!(qbs.iter().all(|v| v.get_type() == qb_ty), "qbs must be of type Qubit");
    ensure!(outputs.get_types().all(|v| v == qb_ty), "outputs must be of type Qubit");

    let args_tys = angles.into_iter().chain(qbs).copied().map(|x| x.get_type().into()).collect_vec();
    let func_ty = iw_ctx.void_type().fn_type(&args_tys, false);
    let func = context.get_extern_func(func, func_ty)?;

    let func_inputs = angles.into_iter().chain(qbs).copied().map_into().collect_vec();
    context.builder().build_call(func, &func_inputs, "")?;
    outputs.finish(context.builder(), qbs.into_iter().copied())
}

fn emit_qis_measure_to_result<'c, H: HugrView>(
    context: &mut EmitFuncContext<'c, '_, H>,
    qb: BasicValueEnum<'c>,
) -> Result<BasicValueEnum<'c>> {
    let iw_ctx = context.iw_context();
    let res_t = result_type(iw_ctx);
    let measure_t = res_t.fn_type(&[qb.get_type().into()], false);
    let measure_func = context.get_extern_func("__quantum__qis__m__body", measure_t)?;
    let Some(result) = context
        .builder()
        .build_call(measure_func, &[qb.into()], "")?
        .try_as_basic_value()
        .left() else {
            bail!("expected a result from measure")
    };
    Ok(result)
}

fn emit_qis_read_result<'c,H: HugrView>(
    context: &mut EmitFuncContext<'c, '_, H>,
    result: BasicValueEnum<'c>,
) -> Result<BasicValueEnum<'c>> {
    let iw_ctx = context.iw_context();
    let read_result_t = iw_ctx
        .bool_type()
        .fn_type(&[result.get_type().into()], false);
    let read_result_func = context
        .get_extern_func("__quantum__qis__read_result__body", read_result_t)?;
    let Some(result_i1) = context
        .builder()
        .build_call(read_result_func, &[result.into()], "")?
        .try_as_basic_value()
        .left() else {
            bail!("expected a bool from read_result")
    };
    let true_val = emit_value(context, &Value::true_val())?;
    let false_val = emit_value(context, &Value::false_val())?;
    Ok(context
        .builder()
        .build_select(result_i1.into_int_value(), true_val, false_val, "")?)
}

fn emit_qis_qfree<'c,H: HugrView>(
    context: &mut EmitFuncContext<'c, '_, H>,
    qb: BasicValueEnum<'c>,
) -> Result<()> {
    let iw_ctx = context.iw_context();
    let qfree_t = iw_ctx.void_type().fn_type(&[qb.get_type().into()], false);
    let qfree_func =
        context.get_extern_func("__quantum__rt__qubit_release", qfree_t)?;
    context.builder().build_call(qfree_func, &[qb.into()], "")?;
    Ok(())
}

fn emit_qis_qalloc<'c,H: HugrView>(
    context: &mut EmitFuncContext<'c, '_, H>,
) -> Result<BasicValueEnum<'c>> {
    let qb_ty = context.llvm_type(&qb_t())?;
    let qalloc_t = qb_ty.fn_type(&[], false);
    let qalloc_func =
        context.get_extern_func("__quantum__rt__qubit_allocate", qalloc_t)?;
    let Some(qb) = context
        .builder()
        .build_call(qalloc_func, &[], "")?
        .try_as_basic_value()
        .left() else {
            bail!("expected a qubit from qalloc")
    };
    Ok(qb)
}

#[derive(Clone,Debug)]
pub struct QirCodegenExtension;



impl CodegenExtension for QirCodegenExtension {
    fn add_extension<'a, H: HugrView + 'a>(
        self,
        builder: CodegenExtsBuilder<'a, H>,
    ) -> CodegenExtsBuilder<'a, H>
    where
        Self: 'a,
    {
        builder
            .simple_extension_op::<tket2::Tk2Op>( {
                let s = self.clone();
                move |context, args, op| s.emit_tk2op(context, args, op)
            })
            .simple_extension_op::<tket2_hseries::extension::result::ResultOpDef>({
                let s = self.clone();
                move |context, args, op| s.emit_result_op(context, args, op)
            })
    }
}
