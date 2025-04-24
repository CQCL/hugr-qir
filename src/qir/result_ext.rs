use anyhow::{anyhow, bail, Result};
use hugr::{
    extension::{prelude::ConstString, simple_op::MakeExtensionOp as _},
    ops::ExtensionOp,
    HugrView, Node,
};
use hugr_llvm::{
    emit::{emit_value, EmitFuncContext, EmitOpArgs},
    inkwell::types::BasicType as _,
    sum::LLVMSumValue,
    types::HugrSumType,
};
use tket2_hseries::extension::result::{ResultOp, ResultOpDef};

use super::QirCodegenExtension;
impl QirCodegenExtension {
    pub fn emit_result_op<'c, H: HugrView<Node = Node>>(
        &self,
        context: &mut EmitFuncContext<'c, '_, H>,
        args: EmitOpArgs<'c, '_, ExtensionOp, H>,
        op: ResultOpDef,
    ) -> Result<()> {
        let result_op = ResultOp::from_extension_op(&args.node())?;
        let tag_str = result_op.tag;
        if tag_str.is_empty() {
            bail!("Empty result tag received")
        }

        let i8_ptr_ty = context
            .iw_context()
            .i8_type()
            .ptr_type(Default::default())
            .as_basic_type_enum();
        let tag_ptr = {
            let x = emit_value(context, &ConstString::new(tag_str).into())?;
            if x.get_type() == i8_ptr_ty {
                x
            } else {
                context.builder().build_bit_cast(x, i8_ptr_ty, "tag_ptr")?
            }
        };

        match op {
            ResultOpDef::Bool => {
                let [val] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("result_bool expects one input"))?;
                let bool_type = context.llvm_sum_type(HugrSumType::new_unary(2))?;
                let val = LLVMSumValue::try_new(val, bool_type)
                    .map_err(|_| anyhow!("bool_type expects a value"))?
                    .build_get_tag(context.builder())?;
                let i1_ty = context.iw_context().bool_type();
                let trunc_val = context.builder().build_int_truncate(val, i1_ty, "")?;
                let print_fn_ty = context
                    .iw_context()
                    .void_type()
                    .fn_type(&[i1_ty.into(), i8_ptr_ty.into()], false);
                let print_fn =
                    context.get_extern_func("__quantum__rt__bool_record_output", print_fn_ty)?;
                context.builder().build_call(
                    print_fn,
                    &[trunc_val.into(), tag_ptr.into()],
                    "print_bool",
                )?;
                args.outputs.finish(context.builder(), [])
            }
            ResultOpDef::Int | ResultOpDef::UInt => {
                let [mut val] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("result_bool expects one input"))?;
                let i64_ty = context.iw_context().i64_type();
                if val.get_type() != i64_ty.into() {
                    val = if op == ResultOpDef::Int {
                        context
                            .builder()
                            .build_int_s_extend(val.into_int_value(), i64_ty, "")
                    } else {
                        context
                            .builder()
                            .build_int_z_extend(val.into_int_value(), i64_ty, "")
                    }?
                    .into();
                }
                let print_fn_ty = context
                    .iw_context()
                    .void_type()
                    .fn_type(&[i64_ty.into(), i8_ptr_ty.into()], false);
                let print_fn =
                    context.get_extern_func("__quantum__rt__int_record_output", print_fn_ty)?;
                context.builder().build_call(
                    print_fn,
                    &[val.into(), tag_ptr.into()],
                    "print_bool",
                )?;
                args.outputs.finish(context.builder(), [])
            }
            ResultOpDef::F64 => {
                let [val] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("result_bool expects one input"))?;
                let f64_ty = context.iw_context().f64_type();
                let print_fn_ty = context
                    .iw_context()
                    .void_type()
                    .fn_type(&[f64_ty.into(), i8_ptr_ty.into()], false);
                let print_fn =
                    context.get_extern_func("__quantum__rt__double_record_output", print_fn_ty)?;
                context.builder().build_call(
                    print_fn,
                    &[val.into(), tag_ptr.into()],
                    "print_bool",
                )?;
                args.outputs.finish(context.builder(), [])
            }
            // these ops are not supported yet
            ResultOpDef::ArrBool
            | ResultOpDef::ArrInt
            | ResultOpDef::ArrUInt
            | ResultOpDef::ArrF64
            | _ => bail!("Unknown op: {op:?}"),
        }
    }
}

#[cfg(test)]
mod test {
    use hugr::ops::{NamedOp, OpType};
    use hugr_llvm::{
        check_emission,
        test::{llvm_ctx, TestContext},
    };
    use rstest::rstest;

    use tket2_hseries::extension::result::ResultOpDef;

    use crate::qir::{QirCodegenExtension, QirPreludeCodegen};
    use crate::test::single_op_hugr;

    #[rstest::fixture]
    fn ctx(mut llvm_ctx: TestContext) -> TestContext {
        llvm_ctx.add_extensions(|builder| {
            builder
                .add_extension(QirCodegenExtension)
                .add_prelude_extensions(QirPreludeCodegen)
                .add_default_int_extensions()
                .add_float_extensions()
        });
        llvm_ctx
    }

    #[rstest]
    #[case(ResultOpDef::F64.instantiate(&["foo_f64".into()]).unwrap())]
    #[case(ResultOpDef::UInt.instantiate(&["foo_uint".into(), 3.into()]).unwrap())]
    #[case(ResultOpDef::Int.instantiate(&["foo_int".into(), 4.into()]).unwrap())]
    #[case(ResultOpDef::Bool.instantiate(&["bool_int".into()]).unwrap())]
    fn emit(ctx: TestContext, #[case] op: impl Into<OpType>) {
        let op = op.into();
        let mut insta = insta::Settings::clone_current();
        insta.set_snapshot_suffix(format!(
            "{}_{}",
            insta.snapshot_suffix().unwrap_or(""),
            op.name()
        ));
        insta.bind(|| {
            let hugr = single_op_hugr(op);
            check_emission!(hugr, ctx);
        })
    }
}
