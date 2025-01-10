use anyhow::Result;
use clap_verbosity_flag::log::Level;
use hugr::hugr::hugrmut::HugrMut;
use hugr::llvm::inkwell;
use inkwell::context::Context;
use inkwell::module::Module;

pub mod cli;
mod py;

#[non_exhaustive]
pub struct CompileArgs {
    pub debug: u8,
    pub save_hugr: Option<String>,
    /// None means no output
    pub verbosity: Option<Level>,
}

pub fn compile<'c>(
    hugr: &mut impl HugrMut,
    context: &'c Context,
    args: CompileArgs,
) -> Result<Module<'c>> {

    Ok(context.create_module("hello"))
}
