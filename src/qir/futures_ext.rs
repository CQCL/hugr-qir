use anyhow::{bail, ensure, Result};
use hugr::{
    extension::prelude::bool_t,
    ops::{ExtensionOp, Value},
    types::CustomType,
    HugrView, Node,
};
use hugr_llvm::{
    emit::{emit_value, EmitFuncContext, EmitOpArgs},
    inkwell::types::BasicTypeEnum,
    types::TypingSession,
};
use tket2_hseries::extension::futures::{FutureOpDef, EXTENSION_ID, FUTURE_TYPE_NAME};

use super::QirCodegenExtension;

impl QirCodegenExtension {
    /// We represent a hugr `tket.futures.future<bool>` as an i1.
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

    pub fn emit_futures_op<'c, H: HugrView<Node = Node>>(
        &self,
        context: &mut EmitFuncContext<'c, '_, H>,
        args: EmitOpArgs<'c, '_, ExtensionOp, H>,
        op: FutureOpDef,
    ) -> Result<()> {
        match op {
            FutureOpDef::Read => {
                let true_val = emit_value(context, &Value::true_val())?;
                let false_val = emit_value(context, &Value::false_val())?;

                let bool_r = context.builder().build_select(
                    args.inputs[0].into_int_value(),
                    true_val,
                    false_val,
                    "",
                )?;
                args.outputs.finish(context.builder(), [bool_r])
            }
            FutureOpDef::Dup => {
                let input = args.inputs[0];
                args.outputs.finish(context.builder(), [input, input])
            }
            FutureOpDef::Free => args.outputs.finish(context.builder(), []),
            _ => bail!("Unknown op: {op:?}"),
        }
    }
}

#[cfg(test)]
mod test {
    use hugr::extension::simple_op::HasConcrete as _;
    use hugr::{
        extension::prelude::bool_t,
        ops::{NamedOp, OpType},
    };
    use hugr_llvm::{
        check_emission,
        test::{llvm_ctx, TestContext},
    };
    use rstest::rstest;

    use tket2_hseries::extension::futures::FutureOpDef;

    use crate::qir::{QirCodegenExtension, QirPreludeCodegen};
    use crate::test::single_op_hugr;

    #[rstest::fixture]
    fn ctx(mut llvm_ctx: TestContext) -> TestContext {
        llvm_ctx.add_extensions(|builder| {
            builder
                .add_extension(QirCodegenExtension)
                .add_prelude_extensions(QirPreludeCodegen)
        });
        llvm_ctx
    }

    #[rstest]
    #[case(FutureOpDef::Read.instantiate(&[bool_t().into()]).unwrap())]
    #[case(FutureOpDef::Dup.instantiate(&[bool_t().into()]).unwrap())]
    #[case(FutureOpDef::Free.instantiate(&[bool_t().into()]).unwrap())]
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
