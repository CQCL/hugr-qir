use anyhow::{bail, Result};
use hugr::{
    ops::ExtensionOp,
    HugrView,
};
use hugr_llvm::emit::{EmitFuncContext, EmitOpArgs};

use crate::qir::{
    emit_qis_gate_finish, emit_qis_measure_to_result, emit_qis_qalloc,
    emit_qis_qfree, emit_qis_read_result,
};

use super::QirCodegenExtension;

impl QirCodegenExtension {
    pub fn emit_tk2op<'c, H: HugrView>(
        &self,
        context: &mut EmitFuncContext<'c, '_, H>,
        args: EmitOpArgs<'c, '_, ExtensionOp, H>,
        op: tket2::Tk2Op,
    ) -> Result<()> {
        use tket2::Tk2Op::*;
        match op {
            H => emit_qis_gate_finish(
                context,
                "__quantum__qis__h__body",
                [],
                args.inputs,
                args.outputs,
            ),
            CX => emit_qis_gate_finish(
                context,
                "__quantum__qis__cx__body",
                [],
                args.inputs,
                args.outputs,
            ),
            CY => emit_qis_gate_finish(
                context,
                "__quantum__qis__cy__body",
                [],
                args.inputs,
                args.outputs,
            ),
            CZ => emit_qis_gate_finish(
                context,
                "__quantum__qis__cz__body",
                [],
                args.inputs,
                args.outputs,
            ),
            T => emit_qis_gate_finish(
                context,
                "__quantum__qis__t__body",
                [],
                args.inputs,
                args.outputs,
            ),
            Tdg => emit_qis_gate_finish(
                context,
                "__quantum__qis__t__adj",
                [],
                args.inputs,
                args.outputs,
            ),
            S => emit_qis_gate_finish(
                context,
                "__quantum__qis__s__body",
                [],
                args.inputs,
                args.outputs,
            ),
            Sdg => emit_qis_gate_finish(
                context,
                "__quantum__qis__s__adj",
                [],
                args.inputs,
                args.outputs,
            ),
            X => emit_qis_gate_finish(
                context,
                "__quantum__qis__x__body",
                [],
                args.inputs,
                args.outputs,
            ),
            Y => emit_qis_gate_finish(
                context,
                "__quantum__qis__y__body",
                [],
                args.inputs,
                args.outputs,
            ),
            Z => emit_qis_gate_finish(
                context,
                "__quantum__qis__z__body",
                [],
                args.inputs,
                args.outputs,
            ),
            Rx => emit_qis_gate_finish(
                context,
                "__quantum__qis__rx__body",
                &args.inputs[1..2],
                &args.inputs[0..1],
                args.outputs,
            ),
            Ry => emit_qis_gate_finish(
                context,
                "__quantum__qis__ry__body",
                &args.inputs[1..2],
                &args.inputs[0..1],
                args.outputs,
            ),
            Rz => emit_qis_gate_finish(
                context,
                "__quantum__qis__rz__body",
                &args.inputs[1..2],
                &args.inputs[0..1],
                args.outputs,
            ),
            Reset => emit_qis_gate_finish(
                context,
                "__quantum__qis__reset__body",
                [],
                &args.inputs,
                args.outputs,
            ),
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
