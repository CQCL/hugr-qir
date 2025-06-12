use hugr_llvm::inkwell::{targets::{CodeModel, RelocMode, Target, TargetMachine, TargetTriple}, OptimizationLevel};

#[derive(Clone, Debug, Copy, Default)]
#[non_exhaustive]
pub enum CompileTarget {
    #[default]
    QuantinuumHardware,
    Native
}

impl CompileTarget {
    pub fn initialise(&self) {
        match self {
            Self::Native => {
                Target::initialize_native(&Default::default());
            }
            Self::QuantinuumHardware => {
                Target::initialize_aarch64(&Default::default());
            }
        }
    }
    pub fn machine(self, level: OptimizationLevel) -> TargetMachine {
        let reloc_mode = RelocMode::PIC;
        let code_model = CodeModel::Default;
        match self {
            Self::Native => {
                Target::from_triple(&TargetMachine::get_default_triple()).unwrap().create_target_machine(&TargetMachine::get_default_triple(), "", "", level, reloc_mode, code_model).unwrap()
            }
            Self::QuantinuumHardware => {
                let triple = TargetTriple::create("arm64-unknown-none");
                Target::from_triple(&triple).unwrap().create_target_machine(&triple, "", "", level, reloc_mode, code_model).unwrap()
            }
        }

    }
}
