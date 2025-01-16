use anyhow::{bail, ensure, Result};
use hugr::{
    extension::prelude::bool_t,
    ops::ExtensionOp,
    types::CustomType,
    HugrView,
};
use hugr_llvm::{
    emit::{EmitFuncContext, EmitOpArgs},
    inkwell::types::BasicTypeEnum,
    types::TypingSession,
};
use tket2_hseries::extension::futures::{FutureOpDef, EXTENSION_ID, FUTURE_TYPE_NAME};

use super::QirCodegenExtension;

impl QirCodegenExtension {
    pub fn convert_future_type<'c>(
        &self,
        session: TypingSession<'c, '_>,
        custom_type: &CustomType,
    ) -> Result<BasicTypeEnum<'c>> {
        ensure!(
            custom_type.extension() == &EXTENSION_ID
                && custom_type.name() == FUTURE_TYPE_NAME.as_str()
                && custom_type.args() == [bool_t().into()]
        );
        Ok(session.iw_context().bool_type().into())
    }

    pub fn emit_futures_op<'c, H: HugrView>(
        &self,
        context: &mut EmitFuncContext<'c, '_, H>,
        args: EmitOpArgs<'c, '_, ExtensionOp, H>,
        op: FutureOpDef,
    ) -> Result<()> {
        match op {
            FutureOpDef::Read => args.outputs.finish(context.builder(), [args.inputs[0]]),
            FutureOpDef::Dup => {
                let input = args.inputs[0];
                args.outputs.finish(context.builder(), [input, input])
            }
            FutureOpDef::Free => args.outputs.finish(context.builder(), []),
            _ => bail!("Unknown op: {op:?}"),
        }
    }
}
