use std::{io::Write, path::Path};

use anyhow::{anyhow, Result};
use clap::Parser;
use clap_verbosity_flag::log::Level;
use delegate::delegate;
use hugr::llvm::inkwell;
use hugr_cli::validate::ValArgs;
use itertools::Itertools;

use crate::CompileArgs;

/// Main command line interface
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
pub struct Cli {
    #[command(flatten)]
    /// common arguments for injesting HUGRs
    pub hugr_args: ValArgs,

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
    delegate! {
        to self.hugr_args {
            pub fn verbosity(&self, level: Level) -> bool;
        }
    }
    pub fn run<'c>(
        &mut self,
        context: &'c inkwell::context::Context,
    ) -> Result<inkwell::module::Module<'c>> {
        let mut hugr = self
            .hugr_args
            .run()?
            .into_iter()
            .exactly_one()
            .map_err(|e| {
                anyhow!(
                    "Input contained {} HUGRs, only one is supported.",
                    e.count()
                )
            })?;
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
            save_hugr: self.save_hugr.clone(),
            verbosity: self.hugr_args.other_args.verbose.log_level(),
            validate: self.validate,
            qsystem_pass: self.qsystem_pass,
        }
    }
}
