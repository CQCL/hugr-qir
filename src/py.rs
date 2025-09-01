use std::{ffi::OsString, iter};

use crate::cli::{Cli, CliOptimizationLevel, OutputFormat};
use crate::target::CompileTarget;
use clap::Parser;
use hugr::llvm::inkwell;
use itertools::Itertools as _;
use pyo3::{
    Bound, PyResult, pyfunction, pymodule,
    types::{PyAnyMethods as _, PyModule, PyModuleMethods as _, PyTuple},
    wrap_pyfunction,
};
use strum::IntoEnumIterator;

#[pyfunction]
#[pyo3(signature = (*args))]
pub fn cli(args: &Bound<PyTuple>) -> PyResult<()> {
    let args = iter::once("hugr-qir".into())
        .chain(args.extract::<Vec<OsString>>()?)
        .collect_vec();
    let context = inkwell::context::Context::create();
    let mut cli = Cli::try_parse_from(args).map_err(anyhow::Error::from)?;
    let module = cli.run(&context)?;
    cli.write_module(&module)?;
    Ok(())
}

#[pyfunction]
pub fn opt_level_choices() -> Vec<String> {
    CliOptimizationLevel::iter()
        .map(|c| format!("{:?}", c))
        .collect::<Vec<_>>()
}

#[pyfunction]
pub fn compile_target_choices() -> Vec<String> {
    CompileTarget::iter()
        .map(|c| format!("{:?}", c))
        .collect::<Vec<_>>()
}

#[pyfunction]
pub fn output_format_choices() -> Vec<String> {
    OutputFormat::iter()
        .map(|c| format!("{:?}", c))
        .collect::<Vec<_>>()
}

#[pymodule]
pub fn _hugr_qir(m: &Bound<PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(cli, m)?)?;
    m.add_function(wrap_pyfunction!(opt_level_choices, m)?)?;
    m.add_function(wrap_pyfunction!(compile_target_choices, m)?)?;
    m.add_function(wrap_pyfunction!(output_format_choices, m)?)?;
    Ok(())
}
