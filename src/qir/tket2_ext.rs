use hugr::{extension::{prelude::qb_t, simple_op::MakeExtensionOp as _}, ops::{ExtensionOp, Value}, HugrView};
use hugr_llvm::{emit::{EmitFuncContext, EmitOpArgs, emit_value}, inkwell::types::BasicType as _};
use anyhow::{anyhow, bail, Result};
use tket2_hseries::extension::result::{ResultOp, ResultOpDef};


use crate::qir::emit_qir_qis_call;

use super::{emit_qir_1f_xqb, emit_qir_xqb, result_type, QirCodegenExtension};

impl QirCodegenExtension {
    pub fn emit_tk2op<'c, H: HugrView>(&self, context: &mut EmitFuncContext<'c,'_,H>, args: EmitOpArgs<'c, '_, ExtensionOp, H>, op: tket2::Tk2Op) -> Result<()> {
        use tket2::Tk2Op::*;
        let qb_ty = context.llvm_type(&qb_t())?;
        match op {
            H => emit_qir_qis_call(context, "__quantum__qis__h__body", [], args.inputs, args.outputs),
            CX => emit_qir_qis_call(context, "__quantum__qis__cx__body", [], args.inputs, args.outputs),
            CY => emit_qir_qis_call(context, "__quantum__qis__cy__body", [], args.inputs, args.outputs),
            CZ => emit_qir_qis_call(context, "__quantum__qis__cz__body", [], args.inputs, args.outputs),
            T => emit_qir_qis_call(context, "__quantum__qis__t__body", [], args.inputs, args.outputs),
            Tdb => emit_qir_qis_call(context, "__quantum__qis__t__adj", [], args.inputs, args.outputs),
            S => emit_qir_qis_call(context, "__quantum__qis__s__body", [], args.inputs, args.outputs),
            Sdg => emit_qir_qis_call(context, "__quantum__qis__s__adj", [], args.inputs, args.outputs),
            X => emit_qir_qis_call(context, "__quantum__qis__x__adj", [], args.inputs, args.outputs),
            Y => emit_qir_qis_call(context, "__quantum__qis__y__adj", [], args.inputs, args.outputs),
            Z => emit_qir_qis_call(context, "__quantum__qis__z__adj", [], args.inputs, args.outputs),
            Rx => emit_qir_qis_call(context, "__quantum__qis__rx__adj", &args.inputs[0..1], &args.inputs[1..2], args.outputs),
            Ry => emit_qir_qis_call(context, "__quantum__qis__ry__adj", &args.inputs[0..1], &args.inputs[1..2], args.outputs),
            Rz => emit_qir_qis_call(context, "__quantum__qis__rz__adj", &args.inputs[0..1], &args.inputs[1..2], args.outputs),
            Reset => emit_qir_xqb(context, args, "__quantum__qis__reset__body"),
            Measure => {
                let qb = args.inputs[0];
                let iw_ctx = context.iw_context();
                let res_t = result_type(iw_ctx);
                let measure_t = res_t.fn_type(&[qb_ty.into()], false);
                let measure_func =
                    context.get_extern_func("__quantum__qis__m__body", measure_t)?;

                let read_result_t = iw_ctx
                    .bool_type()
                    .fn_type(&[res_t.as_basic_type_enum().into()], false);
                let read_result_func = context
                    .get_extern_func("__quantum__qis__read_result__body", read_result_t)?;

                let result = context
                    .builder()
                    .build_call(measure_func, &[qb.into()], "")?
                    .try_as_basic_value()
                    .left()
                    .ok_or_else(|| anyhow!("expected a result from measure"))?;
                let result_i1 = context
                    .builder()
                    .build_call(read_result_func, &[result.into()], "")?
                    .try_as_basic_value()
                    .left()
                    .ok_or_else(|| anyhow!("expected a bool from read_result"))?
                    .into_int_value();

                let true_val = emit_value(context, &Value::true_val())?;
                let false_val = emit_value(context, &Value::false_val())?;
                let res = context
                    .builder()
                    .build_select(result_i1, true_val, false_val, "")?;
                args.outputs.finish(context.builder(), [qb, res])
            }
            MeasureFree => {
                let qb = args.inputs[0];
                let iw_ctx = context.iw_context();
                let res_t = result_type(iw_ctx);
                let measure_t = res_t.fn_type(&[qb_ty.into()], false);
                let measure_func =
                    context.get_extern_func("__quantum__qis__m__body", measure_t)?;

                let read_result_t = iw_ctx
                    .bool_type()
                    .fn_type(&[res_t.as_basic_type_enum().into()], false);
                let read_result_func = context
                    .get_extern_func("__quantum__qis__read_result__body", read_result_t)?;

                let result = context
                    .builder()
                    .build_call(measure_func, &[qb.into()], "")?
                    .try_as_basic_value()
                    .left()
                    .ok_or_else(|| anyhow!("expected a result from measure"))?;
                let result_i1 = context
                    .builder()
                    .build_call(read_result_func, &[result.into()], "")?
                    .try_as_basic_value()
                    .left()
                    .ok_or_else(|| anyhow!("expected a bool from read_result"))?
                    .into_int_value();

                let true_val = emit_value(context, &Value::true_val())?;
                let false_val = emit_value(context, &Value::false_val())?;

                let qfree_t = iw_ctx.void_type().fn_type(&[qb_ty.into()], false);
                let qfree_func =
                    context.get_extern_func("__quantum__rt__qubit_release", qfree_t)?;
                context.builder().build_call(qfree_func, &[qb.into()], "")?;

                let res = context
                    .builder()
                    .build_select(result_i1, true_val, false_val, "")?;
                args.outputs.finish(context.builder(), [res])
            }
            QAlloc => {
                let qb_ty = context.llvm_type(&qb_t())?;
                let qalloc_t = qb_ty.fn_type(&[], false);
                let qalloc_func =
                    context.get_extern_func("__quantum__rt__qubit_allocate", qalloc_t)?;
                let qb = context
                    .builder()
                    .build_call(qalloc_func, &[], "")?
                    .try_as_basic_value()
                    .left()
                    .ok_or_else(|| anyhow!("expected a qubit from qalloc"))?;
                args.outputs.finish(context.builder(), [qb])
            }
            QFree => {
                let iw_ctx = context.iw_context();
                let qb = args.inputs[0];
                let qb_t = qb.get_type();
                let qfree_t = iw_ctx.void_type().fn_type(&[qb_t.into()], false);
                let qfree_func =
                    context.get_extern_func("__quantum__rt__qubit_release", qfree_t)?;
                context.builder().build_call(qfree_func, &[qb.into()], "")?;
                args.outputs.finish(context.builder(), [])
            }
            _ => bail!("Unknown op: {op:?}"),
        }
    }

}
