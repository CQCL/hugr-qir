use anyhow::Result;
use clap::Parser;
use clap_verbosity_flag::log::Level;
use delegate::delegate;
use hugr::llvm::inkwell;
use hugr_cli::HugrArgs;

/// Main command line interface
#[derive(Parser, Debug)]
#[clap(author, version, about, long_about = None)]
pub struct Cli {
    #[command(flatten)]
    /// common arguments for injesting HUGRs
    pub hugr_args: HugrArgs,
    // #[arg(short, long, value_parser, value_name = "FILE")]
    // output: PathBuf,
    /// Turn debugging information on
    #[arg(short, long, action = clap::ArgAction::Count)]
    debug: u8,

    #[arg(long, help = "Save transformed HUGR to a file")]
    save_hugr: Option<String>,
}

impl Cli {
    delegate! {
        to self.hugr_args {
            pub fn verbosity(&self, level: Level) -> bool;
        }
    }
    pub fn run<'c>(
        mut self,
        context: &'c inkwell::context::Context,
    ) -> Result<inkwell::module::Module<'c>> {
        todo!()
    }
}
