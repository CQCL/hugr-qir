pub mod tket2_ext;
pub mod result_ext;
pub mod qsystem_ext;

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
                move |context, args, op| s.emit_resultop(context, args, op)
            })
    }
}
