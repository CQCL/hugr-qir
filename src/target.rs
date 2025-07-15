use crate::inkwell::{
    OptimizationLevel,
    targets::{CodeModel, InitializationConfig, RelocMode, Target, TargetMachine, TargetTriple},
};

#[derive(Clone, Debug, Copy, Default)]
#[non_exhaustive]
pub enum CompileTarget {
    #[default]
    QuantinuumHardware,
    Native,
}

impl CompileTarget {
    pub fn initialise(&self) {
        match self {
            Self::Native => {
                let _ = Target::initialize_native(&InitializationConfig::default());
            }
            Self::QuantinuumHardware => {
                Target::initialize_all(&InitializationConfig::default());
            }
        }
    }
    pub fn machine(self, level: OptimizationLevel) -> TargetMachine {
        let reloc_mode = RelocMode::PIC;
        let code_model = CodeModel::Default;
        match self {
            Self::Native => Target::from_triple(&TargetMachine::get_default_triple())
                .unwrap()
                .create_target_machine(
                    &TargetMachine::get_default_triple(),
                    "",
                    "",
                    level,
                    reloc_mode,
                    code_model,
                )
                .unwrap(),
            Self::QuantinuumHardware => {
                let triple = TargetTriple::create("aarch64-unknown-linux-gnu");
                Target::from_triple(&triple)
                    .unwrap()
                    .create_target_machine(&triple, "", "", level, reloc_mode, code_model)
                    .unwrap()
            }
        }
    }
}
