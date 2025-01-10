use std::process::ExitCode;

use clap::Parser as _;
use clap_verbosity_flag::log::Level;
use hugr::llvm::inkwell;
use hugr_qir::cli::Cli;

fn main() -> ExitCode {
    let args = Cli::parse();
    let context = inkwell::context::Context::create();
    let report_err = args.verbosity(Level::Error);
    match args.run(&context).map(|_| ()) {
        Ok(_) => ExitCode::SUCCESS,
        Err(e) => {
            if report_err {
                eprintln!("{}", e);
            }
            ExitCode::FAILURE
        }
    }
}
