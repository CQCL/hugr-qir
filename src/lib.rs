use std::fs::OpenOptions;
use std::rc::Rc;

use anyhow::{anyhow, Result};
use clap_verbosity_flag::log::Level;
use hugr::algorithms::validation::ValidationLevel;
use hugr::algorithms::RemoveDeadFuncsPass;
use hugr::llvm::custom::CodegenExtsMap;
use hugr::llvm::emit::{EmitHugr, Namer};
use hugr::llvm::utils::fat::FatExt;
use hugr::llvm::{inkwell, CodegenExtsBuilder};
use hugr::{Hugr, HugrView};
use inkwell::context::Context;
use inkwell::module::Module;
use qir::{QirCodegenExtension, QirPreludeCodegen};
use rotation::RotationCodegenExtension;
use crate::inline::inline;

pub mod cli;
pub mod qir;

#[cfg(feature = "py")]
mod py;

// TODO this was copy pasted, ideally it would live in tket2-hseries
pub mod rotation;

#[non_exhaustive]
pub struct CompileArgs {
    pub debug: u8,
    pub save_hugr: Option<String>,

    /// None means no output
    pub verbosity: Option<Level>,
    pub validate: bool,
    pub qsystem_pass: bool,
}

impl Default for CompileArgs {
    fn default() -> Self {
        Self {
            debug: 0,
            save_hugr: None,
            verbosity: None,
            validate: false,
            qsystem_pass: true,
        }
    }
}

impl CompileArgs {
    pub fn codegen_extensions(&self) -> CodegenExtsMap<'static, Hugr> {
        let pcg = QirPreludeCodegen;

        CodegenExtsBuilder::default()
            .add_prelude_extensions(pcg.clone())
            .add_int_extensions()
            .add_float_extensions()
            .add_conversion_extensions()
            .add_logic_extensions()
            .add_extension(RotationCodegenExtension::new(QirPreludeCodegen))
            .add_extension(QirCodegenExtension)
            .finish()
    }

    pub fn module_name(&self) -> impl AsRef<str> {
        // TODO get this from args
        "hugr-qir"
    }

    /// TODO: Change to "hugr: &mut impl HugrMut" once QSeriesPass works on &mut impl HugrMut
    pub fn hugr_to_hugr(&self, hugr: &mut Hugr) -> Result<()> {
        if self.qsystem_pass {
            let mut pass = tket2_hseries::QSystemPass::default();
            if self.validate {
                pass = pass.with_validation_level(ValidationLevel::WithExtensions);
            }
            pass.run(hugr)?;
        }
        
        let all_calls: Vec<_> = hugr.nodes().filter(|n| hugr.get_optype(*n).is_call()).collect();
        inline(hugr,  all_calls)?;
        self.remove_dead_functions(hugr)?;

        if let Some(path) = &self.save_hugr {
            let mut open_options = OpenOptions::new();
            open_options.truncate(true);
            serde_json::to_writer_pretty(open_options.open(path)?, hugr)?;
        }
        Ok(())
    }

    pub fn remove_dead_functions(&self, hugr: &mut Hugr) -> Result<()> {
        let entry_point_node = {
            let mains: Vec<_> = hugr
                .nodes()
                .filter(|&n| {
                    hugr.get_optype(n)
                        .as_func_defn()
                        .is_some_and(|f| f.name == "main")
                })
                .collect();
            match mains.as_slice() {
                [] => Err(anyhow!("main function not found in HUGR"))?,
                [x] => *x,
                xs => Err(anyhow!("found {} main functions in HUGR", xs.len()))?,
            }
        };
        let mut dead_func_pass = RemoveDeadFuncsPass::default().with_module_entry_points([entry_point_node]);
        if self.validate {
            dead_func_pass = dead_func_pass.validation_level(ValidationLevel::WithExtensions);
        }
        dead_func_pass.run(hugr)?;
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

#[cfg(test)]
pub(crate) mod test;
mod inline;
