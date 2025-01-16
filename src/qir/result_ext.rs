use anyhow::{bail, Result, anyhow};
use hugr::{extension::{prelude::ConstString, simple_op::MakeExtensionOp as _}, ops::ExtensionOp, HugrView};
use hugr_llvm::{emit::{emit_value, EmitFuncContext, EmitOpArgs}, inkwell::types::BasicType as _, sum::LLVMSumValue, types::HugrSumType};
use tket2_hseries::extension::result::{ResultOp, ResultOpDef};

use super::QirCodegenExtension;
impl QirCodegenExtension {
    pub fn emit_result_op<'c,H: HugrView>(&self, context: &mut EmitFuncContext<'c,'_,H>, args: EmitOpArgs<'c,'_,ExtensionOp,H>, op: ResultOpDef) -> Result<()> {
        let result_op = ResultOp::from_extension_op(&args.node())?;
        let tag_str = result_op.tag;
        if tag_str.is_empty() {
            bail!("Empty result tag received")
        }

        let tag_ptr = emit_value(context, &ConstString::new(tag_str).into())?;
        let i8_ptr_ty = context
            .iw_context()
            .i8_type()
            .ptr_type(Default::default())
            .as_basic_type_enum();

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
                let print_fn = context.get_extern_func(
                    "__quantum__rt__bool_record_output",
                    print_fn_ty,
                )?;
                context.builder().build_call(
                    print_fn,
                    &[trunc_val.into(), tag_ptr.into()],
                    "print_bool",
                )?;
                args.outputs.finish(context.builder(), [])
            }
            ResultOpDef::Int | ResultOpDef::UInt => {
                let [val] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("result_bool expects one input"))?;
                let i64_ty = context.iw_context().i64_type();
                let print_fn_ty = context
                    .iw_context()
                    .void_type()
                    .fn_type(&[i64_ty.into(), i8_ptr_ty.into()], false);
                let print_fn = context
                    .get_extern_func("__quantum__rt__int_record_output", print_fn_ty)?;
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
                let print_fn = context.get_extern_func(
                    "__quantum__rt__double_record_output",
                    print_fn_ty,
                )?;
                context.builder().build_call(
                    print_fn,
                    &[val.into(), tag_ptr.into()],
                    "print_bool",
                )?;
                args.outputs.finish(context.builder(), [])
            }
            ResultOpDef::ArrBool => todo!(),
            ResultOpDef::ArrInt => todo!(),
            ResultOpDef::ArrUInt => todo!(),
            ResultOpDef::ArrF64 => todo!(),
            _ => todo!(),
        }

    }

}
            // .simple_extension_op::<tket2_hseries::extension::result::ResultOpDef>(
            //     |context, args, op| {
            //         let result_op = ResultOp::from_extension_op(&args.node())?;
            //         let tag_str = result_op.tag;
            //         if tag_str.is_empty() {
            //             return Err(anyhow!("Empty result tag received"));
            //         }

            //         let tag_ptr = emit_value(context, &ConstString::new(tag_str).into())?;
            //         let i8_ptr_ty = context
            //             .iw_context()
            //             .i8_type()
            //             .ptr_type(Default::default())
            //             .as_basic_type_enum();

            //         match op {
            //             ResultOpDef::Bool => {
            //                 let [val] = args
            //                     .inputs
            //                     .try_into()
            //                     .map_err(|_| anyhow!("result_bool expects one input"))?;
            //                 let bool_type = context.llvm_sum_type(HugrSumType::new_unary(2))?;
            //                 let val = LLVMSumValue::try_new(val, bool_type)
            //                     .map_err(|_| anyhow!("bool_type expects a value"))?
            //                     .build_get_tag(context.builder())?;
            //                 let i1_ty = context.iw_context().bool_type();
            //                 let trunc_val = context.builder().build_int_truncate(val, i1_ty, "")?;
            //                 let print_fn_ty = context
            //                     .iw_context()
            //                     .void_type()
            //                     .fn_type(&[i1_ty.into(), i8_ptr_ty.into()], false);
            //                 let print_fn = context.get_extern_func(
            //                     "__quantum__rt__bool_record_output",
            //                     print_fn_ty,
            //                 )?;
            //                 context.builder().build_call(
            //                     print_fn,
            //                     &[trunc_val.into(), tag_ptr.into()],
            //                     "print_bool",
            //                 )?;
            //                 args.outputs.finish(context.builder(), [])
            //             }
            //             ResultOpDef::Int | ResultOpDef::UInt => {
            //                 let [val] = args
            //                     .inputs
            //                     .try_into()
            //                     .map_err(|_| anyhow!("result_bool expects one input"))?;
            //                 let i64_ty = context.iw_context().i64_type();
            //                 let print_fn_ty = context
            //                     .iw_context()
            //                     .void_type()
            //                     .fn_type(&[i64_ty.into(), i8_ptr_ty.into()], false);
            //                 let print_fn = context
            //                     .get_extern_func("__quantum__rt__int_record_output", print_fn_ty)?;
            //                 context.builder().build_call(
            //                     print_fn,
            //                     &[val.into(), tag_ptr.into()],
            //                     "print_bool",
            //                 )?;
            //                 args.outputs.finish(context.builder(), [])
            //             }
            //             ResultOpDef::F64 => {
            //                 let [val] = args
            //                     .inputs
            //                     .try_into()
            //                     .map_err(|_| anyhow!("result_bool expects one input"))?;
            //                 let f64_ty = context.iw_context().f64_type();
            //                 let print_fn_ty = context
            //                     .iw_context()
            //                     .void_type()
            //                     .fn_type(&[f64_ty.into(), i8_ptr_ty.into()], false);
            //                 let print_fn = context.get_extern_func(
            //                     "__quantum__rt__double_record_output",
            //                     print_fn_ty,
            //                 )?;
            //                 context.builder().build_call(
            //                     print_fn,
            //                     &[val.into(), tag_ptr.into()],
            //                     "print_bool",
            //                 )?;
            //                 args.outputs.finish(context.builder(), [])
            //             }
            //             ResultOpDef::ArrBool => todo!(),
            //             ResultOpDef::ArrInt => todo!(),
            //             ResultOpDef::ArrUInt => todo!(),
            //             ResultOpDef::ArrF64 => todo!(),
            //             _ => todo!(),
            //         }
            //     },
            // )
