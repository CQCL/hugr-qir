use std::{ffi::OsString, iter};

use clap::Parser;
use hugr::llvm::inkwell;
use itertools::Itertools as _;
use pyo3::{
    pyfunction, pymodule,
    types::{PyAnyMethods as _, PyModule, PyModuleMethods as _, PyTuple},
    wrap_pyfunction, Bound, PyResult,
};

use crate::cli::Cli;

#[pyfunction]
#[pyo3(signature = (*args))]
pub fn cli(args: &Bound<PyTuple>) -> PyResult<()> {
    let args = iter::once("hugr-qir".into())
        .chain(args.extract::<Vec<OsString>>()?)
        .collect_vec();
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
