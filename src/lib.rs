use std::fs::OpenOptions;
use std::rc::Rc;

use anyhow::Result;
use clap_verbosity_flag::log::Level;
use hugr::algorithms::validation::ValidationLevel;
use hugr::llvm::custom::CodegenExtsMap;
use hugr::llvm::emit::{EmitHugr, Namer};
use hugr::llvm::utils::fat::FatExt;
use hugr::llvm::{inkwell, CodegenExtsBuilder};
use hugr::{Hugr};
use hugr_llvm::inkwell::attributes::AttributeLoc;
use inkwell::context::Context;
use inkwell::module::Module;
use qir::{QirCodegenExtension, QirPreludeCodegen};
use rotation::RotationCodegenExtension;

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
        let module = emit.emit_module(hugr.fat_root().unwrap())?.finish(); 
        add_module_metadata(&module)?;
        Ok(module)
    }

    pub fn compile<'c>(&self, hugr: &mut Hugr, context: &'c Context) -> Result<Module<'c>> {
        self.hugr_to_hugr(hugr)?;
        let module = self.hugr_to_llvm(hugr, context)?;
        let _ = module.verify();
        return Ok(module);
    }}

    pub fn add_module_metadata(module: &Module) ->  Result<()> {
        let attributes = [
            module.get_context().create_string_attribute("entry_point", ""),
            module.get_context().create_string_attribute("output_labeling_schema", ""),
            module.get_context().create_string_attribute("qir_profiles", "custom"),
            module.get_context().create_string_attribute("required_num_qubits", "20"),
            module.get_context().create_string_attribute("required_num_results", "20"),
            // see https://github.com/CQCL/hugr-qir/issues/27
        ];
        let fn_value = module.get_first_function().unwrap();
        for attribute in attributes {
            fn_value.add_attribute(AttributeLoc::Function, attribute);
        }
        Ok(())
    }

#[cfg(test)]
pub(crate) mod test;
