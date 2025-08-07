use anyhow::anyhow;
use hugr_core::ops::{ExtensionOp, Value};
use hugr_core::types::{SumType, TypeName};
use hugr_core::{HugrView, Node};
use hugr_llvm::CodegenExtension;
use hugr_llvm::emit::{EmitFuncContext, EmitOpArgs, emit_value};
use hugr_llvm::inkwell::IntPredicate;
use hugr_llvm::inkwell::types::IntType;
use hugr_llvm::sum::LLVMSumValue;
use hugr_llvm::types::TypingSession;
use tket::extension::bool::{BOOL_EXTENSION_ID, BoolOp, ConstBool};

// This is copied from https://github.com/CQCL/guppylang/blob/main/execute_llvm/src/bool.rs
// And is a workaround until the below issues are resolved
// https://github.com/CQCL/tket2/issues/909
// https://github.com/CQCL/tket2/issues/910

#[allow(dead_code)]
const BOOL_TYPE_ID: TypeName = TypeName::new_inline("bool");

#[allow(dead_code)]
fn llvm_bool_type<'c>(ts: &TypingSession<'c, '_>) -> IntType<'c> {
    ts.iw_context().bool_type()
}
#[allow(dead_code)]
pub struct BoolCodegenExtension;

impl BoolCodegenExtension {
    #[allow(dead_code)]
    fn emit_bool_op<'c, H: HugrView<Node = Node>>(
        &self,
        context: &mut EmitFuncContext<'c, '_, H>,
        args: EmitOpArgs<'c, '_, ExtensionOp, H>,
        op: BoolOp,
    ) -> anyhow::Result<()> {
        match op {
            BoolOp::read => {
                let [inp] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("BoolOp::read expects one argument"))?;
                let res = inp.into_int_value();
                let true_val = emit_value(context, &Value::true_val())?;
                let false_val = emit_value(context, &Value::false_val())?;
                let res = context
                    .builder()
                    .build_select(res, true_val, false_val, "")?;
                args.outputs.finish(context.builder(), vec![res])
            }
            BoolOp::make_opaque => {
                let [inp] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("BoolOp::make_opaque expects one argument"))?;
                let bool_ty = context.llvm_sum_type(SumType::new_unary(2))?;
                let bool_val = LLVMSumValue::try_new(inp, bool_ty)?;
                let res = bool_val.build_get_tag(context.builder())?;
                args.outputs.finish(context.builder(), vec![res.into()])
            }
            BoolOp::not => {
                let [inp] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("BoolOp::not expects one argument"))?;
                let res = inp.into_int_value();
                let res = context.builder().build_not(res, "")?;
                args.outputs.finish(context.builder(), vec![res.into()])
            }
            binary_op => {
                let [inp1, inp2] = args
                    .inputs
                    .try_into()
                    .map_err(|_| anyhow!("BoolOp::{:?} expects two arguments", binary_op))?;
                let inp1_val = inp1.into_int_value();
                let inp2_val = inp2.into_int_value();
                let res = match binary_op {
                    BoolOp::and => context.builder().build_and(inp1_val, inp2_val, "")?,
                    BoolOp::or => context.builder().build_or(inp1_val, inp2_val, "")?,
                    BoolOp::xor => context.builder().build_xor(inp1_val, inp2_val, "")?,
                    BoolOp::eq => context.builder().build_int_compare(
                        IntPredicate::EQ,
                        inp1_val,
                        inp2_val,
                        "",
                    )?,
                    _ => return Err(anyhow!("Unsupported binary bool operation")),
                };
                args.outputs.finish(context.builder(), vec![res.into()])
            }
        }
    }
}

impl CodegenExtension for BoolCodegenExtension {
    fn add_extension<'a, H: hugr::HugrView<Node = hugr::Node> + 'a>(
        self,
        builder: hugr::llvm::CodegenExtsBuilder<'a, H>,
    ) -> hugr::llvm::CodegenExtsBuilder<'a, H>
    where
        Self: 'a,
    {
        builder
            .custom_type((BOOL_EXTENSION_ID, BOOL_TYPE_ID), |ts, _| {
                Ok(llvm_bool_type(&ts).into())
            })
            .custom_const::<ConstBool>(|context, val| {
                let bool_ty = llvm_bool_type(&context.typing_session());
                Ok(bool_ty.const_int(val.value().into(), false).into())
            })
            .simple_extension_op(move |context, args, op| self.emit_bool_op(context, args, op))
    }
}
