use hugr::{ops::ExtensionOp, HugrView};
use hugr_llvm::{emit::{EmitFuncContext, EmitOpArgs}, inkwell::types::BasicType as _};
use anyhow::{anyhow, bail, Result};

use crate::qir::{emit_qir_1f_xqb, emit_qir_xqb, result_type};

use super::QirCodegenExtension;

impl QirCodegenExtension {
    pub fn emit_tk2op<'c, H: HugrView>(&self, context: &mut EmitFuncContext<'c,'_,H>, args: EmitOpArgs<'c, '_, ExtensionOp, H>, op: tket2::Tk2Op) -> Result<()> {
        use tket2::Tk2Op::*;
        match op {
            H => emit_qir_xqb(context, args, "__quantum__qis__h__body"),
            CX => emit_qir_xqb(context, args, "__quantum__qis__cx__body"),
            CY => emit_qir_xqb(context, args, "__quantum__qis__cy__body"),
            CZ => emit_qir_xqb(context, args, "__quantum__qis__cz__body"),
            T => emit_qir_xqb(context, args, "__quantum__qis__t__body"),
            Tdg => emit_qir_xqb(context, args, "__quantum__qis__t__adj"),
            S => emit_qir_xqb(context, args, "__quantum__qis__s__body"),
            Sdg => emit_qir_xqb(context, args, "__quantum__qis__s__adj"),
            X => emit_qir_xqb(context, args, "__quantum__qis__x__body"),
            Y => emit_qir_xqb(context, args, "__quantum__qis__y__body"),
            Z => emit_qir_xqb(context, args, "__quantum__qis__z__body"),
            Rx => emit_qir_1f_xqb(context, args, "__quantum__qis__rx__body"),
            Ry => emit_qir_1f_xqb(context, args, "__quantum__qis__ry__body"),
            Rz => emit_qir_1f_xqb(context, args, "__quantum__qis__rz__body"),
            Reset => emit_qir_xqb(context, args, "__quantum__qis__reset__body"),
            Measure => {
                let qb = args.inputs[0];
                let iw_ctx = context.iw_context();
                let qb_t = qb.get_type();
                let res_t = result_type(iw_ctx);
                let measure_t = res_t.fn_type(&[qb_t.into()], false);
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
                let qb_t = qb.get_type();
                let res_t = result_type(iw_ctx);
                let measure_t = res_t.fn_type(&[qb_t.into()], false);
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

                let qfree_t = iw_ctx.void_type().fn_type(&[qb_t.into()], false);
                let qfree_func =
                    context.get_extern_func("__quantum__rt__qubit_release", qfree_t)?;
                context.builder().build_call(qfree_func, &[qb.into()], "")?;

                let res = context
                    .builder()
                    .build_select(result_i1, true_val, false_val, "")?;
                args.outputs.finish(context.builder(), [res])
            }
            QAlloc => {
                let qb_t = context.llvm_type(&qb_t())?;
                let qalloc_t = qb_t.fn_type(&[], false);
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
