use std::fs::{self, OpenOptions};
use std::rc::Rc;

use anyhow::Result;
use clap_verbosity_flag::log::Level;
use hugr::algorithms::validation::ValidationLevel;
use hugr::llvm::custom::CodegenExtsMap;
use hugr::llvm::emit::{EmitHugr, Namer};
use hugr::llvm::extension::DefaultPreludeCodegen;
use hugr::llvm::utils::fat::FatExt;
use hugr::llvm::{inkwell, CodegenExtsBuilder};
use hugr::Hugr;
use inkwell::context::Context;
use inkwell::module::Module;
use tket2_hseries::QSystemPass;

pub mod cli;
mod py;

#[non_exhaustive]
pub struct CompileArgs {
    pub debug: u8,
    pub save_hugr: Option<String>,
    /// None means no output
    pub verbosity: Option<Level>,
    pub validate: bool,
}


impl CompileArgs {
    pub fn codegen_extensions(&self) -> CodegenExtsMap<'static, Hugr> {
        // TODO: we probably need to customise prelude codegen
        let pcg = DefaultPreludeCodegen;

        CodegenExtsBuilder::default()
            .add_prelude_extensions(pcg.clone())
            .add_int_extensions()
            .add_float_extensions()
            // TODO we will likely need this, but it's in eldarion
            // .add_extension(RotationCodegenExtension::new(pcg))
            .add_conversion_extensions()
            .add_logic_extensions()
            .finish()
    }

    pub fn module_name(&self) -> impl AsRef<str> {
        // TODO get this from args
        "hugr-qir"
    }


    /// TODO: hugr: &mut impl HugrMut
    pub fn hugr_to_hugr(&self, hugr: &mut Hugr) -> Result<()> {
        // note this rebases into tket2.qsystem extension
        let mut pass = QSystemPass::default();
        if self.validate {
            pass = pass.with_validation_level(ValidationLevel::WithExtensions);
        }
        pass.run(hugr)?;

        if let Some(path) = &self.save_hugr {
            let mut open_options = OpenOptions::new();
            open_options.truncate(true);
            serde_json::to_writer_pretty(open_options.open(path)?, hugr)?;
        }
        Ok(())
    }

    pub fn hugr_to_llvm<'c>(&self, hugr: &Hugr, context: &'c Context) -> Result<Module<'c>> {
        let extensions = self.codegen_extensions().into();
        let namer = Rc::new(Namer::new("__hugr__.", true));
        let module = context.create_module(self.module_name().as_ref());
        let emit = EmitHugr::new(context, module, namer, extensions);
        Ok(emit.emit_module(hugr.fat_root().unwrap())?.finish())
    }

    pub fn compile<'c>(&self, hugr: &mut Hugr, context: &'c Context) -> Result<Module<'c>> {
        self.hugr_to_hugr(hugr)?;
        self.hugr_to_llvm(hugr, context)
    }
}
