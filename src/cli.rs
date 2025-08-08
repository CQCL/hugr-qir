use std::{io::Write, path::Path};

use anyhow::Result;
use clap::Parser;
use clap_verbosity_flag::log::Level;
use hugr::llvm::inkwell;
use hugr::package::PackageValidationError;

use crate::CompileArgs;

use clap_verbosity_flag::InfoLevel;
use clap_verbosity_flag::Verbosity;
use hugr_cli::hugr_io::HugrInputArgs;

use hugr_cli::CliError;

/// Main command line interface
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
pub struct Cli {
    /// Hugr input.
    #[command(flatten)]
    pub input_args: HugrInputArgs,
    /// Verbosity.
    #[command(flatten)]
    pub verbose: Verbosity<InfoLevel>,

    #[clap(
        value_parser,
        default_value = "-",
        short,
        long,
        help = "Output file, or - for stdout"
    )]
    pub output: clio::Output,

    #[arg(short, long, action = clap::ArgAction::Count, help = "Turn debugging information on")]
    pub debug: u8,

    #[arg(long, help = "Save transformed HUGR to a file")]
    pub save_hugr: Option<String>,

    #[clap(value_parser, short = 'f', long)]
    pub output_format: Option<OutputFormat>,

    #[clap(long, help = "Validate hugr before and after each pass")]
    pub validate: bool,

    #[arg(long, help = "Run QSystemPass", default_value_t = true)]
    pub qsystem_pass: bool,
}

#[derive(clap::ValueEnum, Clone, Debug, Copy)]
pub enum OutputFormat {
    Bitcode,
    LlvmIr,
}

impl Cli {
    pub fn verbosity(&self, level: Level) -> bool {
        self.verbose.log_level_filter() >= level
    }

    pub fn run<'c>(
        &mut self,
        context: &'c inkwell::context::Context,
    ) -> Result<inkwell::module::Module<'c>> {
        let package = self.input_args.get_package()?;
        let generator = hugr::envelope::get_generator(&package.modules);
        package
            .validate()
            .map_err(|val_err| Self::wrap_generator(generator, val_err))?;
        let mut hugr = package.modules[0].clone();

        let args = self.compile_args();
        args.compile(&mut hugr, context)
    }

    pub fn write_module(&mut self, module: &inkwell::module::Module<'_>) -> Result<()> {
        match self.output_format() {
            OutputFormat::Bitcode => {
                let memory = module.write_bitcode_to_memory();
                self.output.write_all(memory.as_slice())?;
            }
            OutputFormat::LlvmIr => {
                let str = module.print_to_string();
                self.output.write_all(str.to_bytes())?;
            }
        }
        Ok(())
    }

    pub fn output_format(&self) -> OutputFormat {
        self.output_format.unwrap_or_else(|| {
            if self.output.is_tty() {
                return OutputFormat::LlvmIr;
            } else if let Some(extension) = self
                .output
                .path()
                .file_name()
                .and_then(|x| Path::new(x).extension()?.to_str())
            {
                if ["ll", "asm"].contains(&extension) {
                    return OutputFormat::LlvmIr;
                }
            }
            OutputFormat::Bitcode
        })
    }

    pub fn compile_args(&self) -> CompileArgs {
        CompileArgs {
            debug: self.debug,
            verbosity: self.verbose.log_level(),
            validate: self.validate,
            qsystem_pass: self.qsystem_pass,
        }
    }

    // TODO: Replace with `CliError::validation` in `hugr-cli >= 0.22.2`.
    fn wrap_generator(generator: Option<String>, val_err: PackageValidationError) -> CliError {
        if let Some(g) = generator {
            CliError::ValidateKnownGenerator {
                inner: val_err,
                generator: Box::new(g.to_string()),
            }
        } else {
            CliError::Validate(val_err)
        }
    }
}
