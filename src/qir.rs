use hugr::{extension::{prelude::{qb_t, ConstString}, simple_op::MakeExtensionOp as _}, llvm::{extension::PreludeCodegen, CodegenExtension, CodegenExtsBuilder}, ops::{ExtensionOp, Value}, HugrView};
use anyhow::{anyhow, bail, Result};
use hugr::llvm as hugr_llvm;
use hugr_llvm::inkwell;
use inkwell::{context::Context, types::{BasicMetadataTypeEnum, BasicType, FloatType, PointerType}, values::BasicMetadataValueEnum};
use itertools::Itertools;
use tket2::extension::rotation::rotation_type;
use tket2_hseries::extension::result::{ResultOp, ResultOpDef};

use hugr_llvm::{emit::{emit_value, EmitFuncContext, EmitOpArgs}, sum::LLVMSumValue, types::{HugrSumType, TypingSession}};


#[derive(Clone,Debug)]
pub struct QirPreludeCodegen;

impl PreludeCodegen for QirPreludeCodegen {
    fn qubit_type<'c,'d>(&self, session: &TypingSession<'c,'d>) -> impl BasicType<'c> {
        let iw_ctx = session.iw_context();
        iw_ctx.get_struct_type("QUBIT").unwrap_or_else(|| iw_ctx.opaque_struct_type("QUBIT")).ptr_type(Default::default())
    }
}

fn result_type<'c>(ctx: &'c Context) -> impl BasicType<'c> {
    ctx.get_struct_type("RESULT").unwrap_or_else(|| ctx.opaque_struct_type("RESULT")).ptr_type(Default::default())
}

fn emit_qir_1f_xqb<'c,'d,H: HugrView>(context: &mut EmitFuncContext<'c,'d,H>, args: EmitOpArgs<'c, '_, ExtensionOp, H>, func: impl AsRef<str>) -> Result<()> {
    let iw_ctx = context.iw_context();
    let qb_t = context.llvm_type(&qb_t())?;
    let half_turns_t: FloatType = context.llvm_type(&rotation_type())?.try_into().map_err(|_| anyhow!("hugr type 'rotation' does not map to an LLVM float type"))?;
    let args_tys = {
        let mut x = vec![BasicMetadataTypeEnum::from(half_turns_t)];
        x.extend((0..args.inputs.len() - 1).map(|_| BasicMetadataTypeEnum::from(qb_t)));
        x
    };
    let func_ty = iw_ctx.void_type().fn_type(&args_tys, false);
    let func = context.get_extern_func(func, func_ty)?;

    let qb_inputs = args.inputs.iter().copied().take(args.inputs.len() - 1).collect_vec();
    let func_inputs = {
        let mut x = vec![args.inputs.last().copied().unwrap().into()];
        x.extend(qb_inputs.iter().copied().map_into::<BasicMetadataValueEnum>());
        x
    };
    context.builder().build_call(func, &func_inputs, "")?;
    args.outputs.finish(context.builder(), qb_inputs)

}

fn emit_qir_xqb<'c,'d,H: HugrView>(context: &mut EmitFuncContext<'c,'d,H>, args: EmitOpArgs<'c, '_, ExtensionOp, H>, func: impl AsRef<str>) -> Result<()> {
    let iw_ctx = context.iw_context();
    let qb_t = context.llvm_type(&qb_t())?;
    let func_ty = iw_ctx.void_type().fn_type(&vec![qb_t.into();args.inputs.len()], false);
    let func = context.get_extern_func(func, func_ty)?;

    let func_inputs = args.inputs.iter().copied().map_into().collect_vec();
    context.builder().build_call(func, &func_inputs, "")?;
    args.outputs.finish(context.builder(), args.inputs)
}

pub struct QirCodegenExtension;

impl CodegenExtension for QirCodegenExtension {
    fn add_extension<'a, H: HugrView + 'a>(
        self,
        builder: CodegenExtsBuilder<'a, H>,
    ) -> CodegenExtsBuilder<'a, H>
    where
        Self: 'a {
        builder.simple_extension_op::<tket2::Tk2Op>(|context, args, op| {
            match op {
                tket2::Tk2Op::H => emit_qir_xqb(context, args, "__quantum__qis__h__body"),
                tket2::Tk2Op::CX => emit_qir_xqb(context, args, "__quantum__qis__cx__body"),
                tket2::Tk2Op::CY => emit_qir_xqb(context, args, "__quantum__qis__cy__body"),
                tket2::Tk2Op::CZ => emit_qir_xqb(context, args, "__quantum__qis__cz__body"),
                tket2::Tk2Op::T => emit_qir_xqb(context, args, "__quantum__qis__t__body"),
                tket2::Tk2Op::Tdg => emit_qir_xqb(context, args, "__quantum__qis__t__adj"),
                tket2::Tk2Op::S => emit_qir_xqb(context, args, "__quantum__qis__s__body"),
                tket2::Tk2Op::Sdg => emit_qir_xqb(context, args, "__quantum__qis__s__adj"),
                tket2::Tk2Op::X => emit_qir_xqb(context, args, "__quantum__qis__x__body"),
                tket2::Tk2Op::Y => emit_qir_xqb(context, args, "__quantum__qis__y__body"),
                tket2::Tk2Op::Z => emit_qir_xqb(context, args, "__quantum__qis__z__body"),
                tket2::Tk2Op::Rx => emit_qir_1f_xqb(context, args, "__quantum__qis__rx__body"),
                tket2::Tk2Op::Ry => emit_qir_1f_xqb(context, args, "__quantum__qis__ry__body"),
                tket2::Tk2Op::Rz => emit_qir_1f_xqb(context, args, "__quantum__qis__rz__body"),
                tket2::Tk2Op::Reset => emit_qir_xqb(context, args, "__quantum__qis__reset__body"),
                tket2::Tk2Op::Measure => {
                    let qb = args.inputs[0];
                    let iw_ctx = context.iw_context();
                    let qb_t = qb.get_type();
                    let res_t = result_type(iw_ctx);
                    let measure_t = res_t.fn_type(&vec![qb_t.into()], false);
                    let measure_func = context.get_extern_func("__quantum__qis__m__body", measure_t)?;

                    let read_result_t = iw_ctx.bool_type().fn_type(&[res_t.as_basic_type_enum().into()], false);
                    let read_result_func = context.get_extern_func("__quantum__qis__read_result__body", read_result_t)?;

                    let result = context.builder().build_call(measure_func, &[qb.into()], "")?.try_as_basic_value().left().ok_or_else(|| anyhow!("expected a result from measure"))?;
                    let result_i1 = context.builder().build_call(read_result_func, &[result.into()], "")?.try_as_basic_value().left().ok_or_else(|| anyhow!("expected a bool from read_result"))?.into_int_value();

                    let true_val = emit_value(context, &Value::true_val())?;
                    let false_val = emit_value(context, &Value::false_val())?;
                    let res = context
                        .builder()
                        .build_select(result_i1, true_val, false_val, "")?;
                    args.outputs.finish(context.builder(), [qb, res])
                },
                tket2::Tk2Op::MeasureFree => {
                    let qb = args.inputs[0];
                    let iw_ctx = context.iw_context();
                    let qb_t = qb.get_type();
                    let res_t = result_type(iw_ctx);
                    let measure_t = res_t.fn_type(&vec![qb_t.into()], false);
                    let measure_func = context.get_extern_func("__quantum__qis__m__body", measure_t)?;

                    let read_result_t = iw_ctx.bool_type().fn_type(&[res_t.as_basic_type_enum().into()], false);
                    let read_result_func = context.get_extern_func("__quantum__qis__read_result__body", read_result_t)?;

                    let result = context.builder().build_call(measure_func, &[qb.into()], "")?.try_as_basic_value().left().ok_or_else(|| anyhow!("expected a result from measure"))?;
                    let result_i1 = context.builder().build_call(read_result_func, &[result.into()], "")?.try_as_basic_value().left().ok_or_else(|| anyhow!("expected a bool from read_result"))?.into_int_value();

                    let true_val = emit_value(context, &Value::true_val())?;
                    let false_val = emit_value(context, &Value::false_val())?;

                    let qfree_t = iw_ctx.void_type().fn_type(&[qb_t.into()], false);
                    let qfree_func = context.get_extern_func("__quantum__rt__qubit_release", qfree_t)?;
                    context.builder().build_call(qfree_func, &[qb.into()], "")?;

                    let res = context
                        .builder()
                        .build_select(result_i1, true_val, false_val, "")?;
                    args.outputs.finish(context.builder(), [res])
                }
                tket2::Tk2Op::QAlloc => {
                    let qb_t = context.llvm_type(&qb_t())?;
                    let qalloc_t = qb_t.fn_type(&vec![], false);
                    let qalloc_func = context.get_extern_func("__quantum__rt__qubit_allocate", qalloc_t)?;
                    let qb = context.builder().build_call(qalloc_func, &[], "")?.try_as_basic_value().left().ok_or_else(|| anyhow!("expected a qubit from qalloc"))?;
                    args.outputs.finish(context.builder(), [qb])
                },
                tket2::Tk2Op::QFree => {
                    let iw_ctx = context.iw_context();
                    let qb = args.inputs[0];
                    let qb_t = qb.get_type();
                    let qfree_t = iw_ctx.void_type().fn_type(&[qb_t.into()], false);
                    let qfree_func = context.get_extern_func("__quantum__rt__qubit_release", qfree_t)?;
                    context.builder().build_call(qfree_func, &[qb.into()], "")?;
                    args.outputs.finish(context.builder(), [])
                }
                _ => bail!("Unknown op: {op:?}")
            }

        }).simple_extension_op::<tket2_hseries::extension::result::ResultOpDef>(|context, args, op| {
            let result_op = ResultOp::from_extension_op(&args.node())?;
            let tag_str = result_op.tag;
            if tag_str.is_empty() {
                return Err(anyhow!("Empty result tag received"));
            }

            let tag_ptr = emit_value(context, &ConstString::new(tag_str).into())?;
            let i8_ptr_ty = context.iw_context().i8_type().ptr_type(Default::default()).as_basic_type_enum();

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
                    let print_fn_ty = context.iw_context().void_type().fn_type(&[i1_ty.into(), i8_ptr_ty.into(), ], false);
                    let print_fn = context.get_extern_func("__quantum__rt__bool_record_output", print_fn_ty)?;
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
                    let print_fn_ty = context.iw_context().void_type().fn_type(&[i64_ty.into(), i8_ptr_ty.into(), ], false);
                    let print_fn = context.get_extern_func("__quantum__rt__int_record_output", print_fn_ty)?;
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
                    let print_fn_ty = context.iw_context().void_type().fn_type(&[f64_ty.into(), i8_ptr_ty.into(), ], false);
                    let print_fn = context.get_extern_func("__quantum__rt__double_record_output", print_fn_ty)?;
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

        })

    }
}
