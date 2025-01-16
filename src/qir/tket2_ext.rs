use hugr::{extension::{prelude::qb_t, simple_op::MakeExtensionOp as _}, ops::{ExtensionOp, Value}, HugrView};
use hugr_llvm::{emit::{EmitFuncContext, EmitOpArgs, emit_value}, inkwell::types::BasicType as _};
use anyhow::{anyhow, bail, Result};
use tket2_hseries::extension::result::{ResultOp, ResultOpDef};


use crate::qir::{emit_qir_qis_call, emit_qis_measure_to_result, emit_qis_qalloc, emit_qis_read_result, emit_qis_qfree};

use super::{result_type, QirCodegenExtension};

impl QirCodegenExtension {
    pub fn emit_tk2op<'c, H: HugrView>(&self, context: &mut EmitFuncContext<'c,'_,H>, args: EmitOpArgs<'c, '_, ExtensionOp, H>, op: tket2::Tk2Op) -> Result<()> {
        use tket2::Tk2Op::*;
        match op {
            H => emit_qir_qis_call(context, "__quantum__qis__h__body", [], args.inputs, args.outputs),
            CX => emit_qir_qis_call(context, "__quantum__qis__cx__body", [], args.inputs, args.outputs),
            CY => emit_qir_qis_call(context, "__quantum__qis__cy__body", [], args.inputs, args.outputs),
            CZ => emit_qir_qis_call(context, "__quantum__qis__cz__body", [], args.inputs, args.outputs),
            T => emit_qir_qis_call(context, "__quantum__qis__t__body", [], args.inputs, args.outputs),
            Tdg => emit_qir_qis_call(context, "__quantum__qis__t__adj", [], args.inputs, args.outputs),
            S => emit_qir_qis_call(context, "__quantum__qis__s__body", [], args.inputs, args.outputs),
            Sdg => emit_qir_qis_call(context, "__quantum__qis__s__adj", [], args.inputs, args.outputs),
            X => emit_qir_qis_call(context, "__quantum__qis__x__adj", [], args.inputs, args.outputs),
            Y => emit_qir_qis_call(context, "__quantum__qis__y__adj", [], args.inputs, args.outputs),
            Z => emit_qir_qis_call(context, "__quantum__qis__z__adj", [], args.inputs, args.outputs),
            Rx => emit_qir_qis_call(context, "__quantum__qis__rx__adj", &args.inputs[0..1], &args.inputs[1..2], args.outputs),
            Ry => emit_qir_qis_call(context, "__quantum__qis__ry__adj", &args.inputs[0..1], &args.inputs[1..2], args.outputs),
            Rz => emit_qir_qis_call(context, "__quantum__qis__rz__adj", &args.inputs[0..1], &args.inputs[1..2], args.outputs),
            Reset => emit_qir_qis_call(context, "__quantum__qis__rz__adj", [], &args.inputs, args.outputs),
            Measure => {
                let qb = args.inputs[0];
                // i.e. RESULT*
                let result = emit_qis_measure_to_result(context, qb)?;

                let result_i1 = emit_qis_read_result(context, result)?;
                args.outputs.finish(context.builder(), [qb, result_i1])
            }
            MeasureFree => {
                let qb = args.inputs[0];
                // i.e. RESULT*
                let result = emit_qis_measure_to_result(context, qb)?;
                emit_qis_qfree(context, qb)?;
                let result_i1 = emit_qis_read_result(context, result)?;
                args.outputs.finish(context.builder(), [result_i1])
            }
            QAlloc => {
                let qb = emit_qis_qalloc(context)?;
                args.outputs.finish(context.builder(), [qb])
            }
            QFree => emit_qis_qfree(context, args.inputs[0]),
            _ => bail!("Unknown op: {op:?}"),
        }
    }

}
