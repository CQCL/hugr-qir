use std::process::ExitCode;

use anyhow::Result;
use clap::Parser as _;
use clap_verbosity_flag::log::Level;
use hugr::llvm::inkwell;
use hugr_qir::cli::Cli;

fn main_impl(mut args: Cli) -> Result<()> {
    let context = inkwell::context::Context::create();
    let module = args.run(&context)?;
    args.write_module(&module)?;
    Ok(())
}

fn main() -> ExitCode {
    let args = Cli::parse();
    let report_err = args.verbosity(Level::Error);
    match main_impl(args) {
        Ok(_) => ExitCode::SUCCESS,
        Err(e) => {
            if report_err {
                eprintln!("Error: {}", e);
            }
            ExitCode::FAILURE
        }
    }
}
