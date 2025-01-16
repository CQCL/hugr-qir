use anyhow::Result;
use hugr::{ops::ExtensionOp, HugrView};
use hugr_llvm::emit::{EmitFuncContext, EmitOpArgs};
use tket2_hseries::extension::qsystem::QSystemOp;

use crate::qir::{
    emit_qis_gate, emit_qis_gate_finish, emit_qis_measure_to_result, emit_qis_qalloc,
    emit_qis_qfree, emit_qis_read_result,
};

use super::QirCodegenExtension;

impl QirCodegenExtension {
    pub fn emit_qsystem_op<'c, H: HugrView>(
        &self,
        context: &mut EmitFuncContext<'c, '_, H>,
        args: EmitOpArgs<'c, '_, ExtensionOp, H>,
        op: QSystemOp,
    ) -> Result<()> {
        use QSystemOp::*;
        match op {
            Measure => {
                let qb = args.inputs[0];
                // i.e. RESULT*
                let result = emit_qis_measure_to_result(context, qb)?;

                let result_i1 = emit_qis_read_result(context, result)?;
                args.outputs.finish(context.builder(), [qb, result_i1])
            }
            LazyMeasure => {
                let qb = args.inputs[0];
                // i.e. RESULT*
                let result = emit_qis_measure_to_result(context, qb)?;

                let result_i1 = emit_qis_read_result(context, result)?;
                // futures are i1s, so this is fine
                args.outputs.finish(context.builder(), [qb, result_i1])
            }
            Rz => emit_qis_gate_finish(
                context,
                "__quantum__qis__rz__body",
                &args.inputs[1..2],
                &args.inputs[0..1],
                args.outputs,
            ),
            PhasedX => emit_qis_gate_finish(
                context,
                "__quantum__qis__phasedx__body",
                &args.inputs[1..3],
                &args.inputs[0..1],
                args.outputs,
            ),
            ZZMax => emit_qis_gate_finish(
                context,
                "__quantum__qis__zzmax__body",
                [],
                &args.inputs[0..2],
                args.outputs,
            ),
            QSystemOp::ZZPhase => emit_qis_gate_finish(
                context,
                "__quantum__qis__rzz__body",
                &args.inputs[2..2],
                &args.inputs[0..2],
                args.outputs,
            ),
            QSystemOp::TryQAlloc => {
                let qb = emit_qis_qalloc(context)?;
                args.outputs.finish(context.builder(), [qb])
            }
            QSystemOp::QFree => emit_qis_qfree(context, args.inputs[0]),
            QSystemOp::Reset => emit_qis_gate_finish(
                context,
                "__quantum__qis__reset__body",
                [],
                &args.inputs,
                args.outputs,
            ),
            QSystemOp::MeasureReset => {
                let qb = args.inputs[0];
                // i.e. RESULT*
                let result = emit_qis_measure_to_result(context, qb)?;
                let _ = emit_qis_gate(context, "__quantum__qis__reset__body", [], [qb])?;
                let result_i1 = emit_qis_read_result(context, result)?;
                args.outputs.finish(context.builder(), [qb, result_i1])
            }
            _ => todo!(),
        }
    }
}
