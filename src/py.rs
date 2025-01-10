use std::ffi::OsString;

use clap::Parser;
use hugr::llvm::inkwell;
use pyo3::{
    pyfunction, pymodule,
    types::{PyAnyMethods as _, PyModule, PyModuleMethods as _},
    wrap_pyfunction, Bound, PyAny, PyResult,
};

use crate::cli::Cli;

#[pyfunction]
pub fn cli(args: &Bound<PyAny>) -> PyResult<()> {
    let args = args.extract::<Vec<OsString>>()?;
    let context = inkwell::context::Context::create();
    Cli::try_parse_from(args)
        .map_err(anyhow::Error::from)?
        .run(&context)?;
    Ok(())
}

#[pymodule]
pub fn _hugr_qir(m: &Bound<PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(cli, m)?)?;
    Ok(())
}
