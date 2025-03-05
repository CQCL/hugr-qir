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
use inkwell::passes::PassManager;
use anyhow::anyhow;
use hugr::HugrView;

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

    /// Some standard LLVM optimizations
    pub fn optimize_module(&self, module: &inkwell::module::Module) -> Result<()>{
        let pb = PassManager::create(());
        pb.add_promote_memory_to_register_pass();
        pb.add_scalar_repl_aggregates_pass();
        pb.add_cfg_simplification_pass();
        pb.add_aggressive_inst_combiner_pass();
        pb.add_aggressive_dce_pass();
        
        pb.run_on(module);

        module.verify().map_err(|msg| anyhow!("Failed to optmise module: {msg}\n, {}", module.to_string()))?;
        Ok(())
    }


    pub fn hugr_to_llvm<'c>(&self, hugr: &Hugr, context: &'c Context) -> Result<Module<'c>> {
        let extensions = self.codegen_extensions().into();
        let namer = Rc::new(Namer::new("__hugr__.", true));
        let module = context.create_module(self.module_name().as_ref());
        let emit = EmitHugr::new(context, module, namer, extensions);
        let module = emit.emit_module(hugr.fat_root().unwrap())?.finish(); 
        add_module_metadata(hugr, &module)?;
        Ok(module)
    }

    pub fn compile<'c>(&self, hugr: &mut Hugr, context: &'c Context) -> Result<Module<'c>> {
        self.hugr_to_hugr(hugr)?;
        let module = self.hugr_to_llvm(hugr, context)?;
        self.optimize_module(&module)?;
        return Ok(module);
    }}


    pub fn find_entry_point(namer: &Namer, hugr: &impl HugrView) -> Result<String> {
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
        Ok(namer.name_func("main", entry_point_node))
    }

    pub fn add_module_metadata(hugr: &impl HugrView, module: &Module) ->  Result<()> {
        let attributes = [
            module.get_context().create_string_attribute("entry_point", ""),
            module.get_context().create_string_attribute("output_labeling_schema", ""),
            module.get_context().create_string_attribute("qir_profiles", "custom"),
            module.get_context().create_string_attribute("required_num_qubits", "20"),
            module.get_context().create_string_attribute("required_num_results", "20"),
            // see https://github.com/CQCL/hugr-qir/issues/27
        ];
        let namer = Namer::new("", true);
        let entry_func_name = find_entry_point(&namer, hugr).unwrap();
        let fn_value = module.get_function(&("__hugr__.".to_owned() + &entry_func_name));
        if fn_value == None {
            return Err(anyhow!("main?? {} function not found in HUGR", entry_func_name));
        }
        for attribute in attributes {
            fn_value.unwrap().add_attribute(AttributeLoc::Function, attribute);
        }
        Ok(())
    }

#[cfg(test)]
pub(crate) mod test;
