use pyo3::{pymodule, pyfunction, types::{PyModule, PyModuleMethods as _}, wrap_pyfunction, Bound, PyResult};

#[pyfunction]
pub fn hello() -> PyResult<String> {
    Ok("Hello".to_string())
}

#[pymodule]
pub fn _hugr_qir(m: &Bound<PyModule>) -> PyResult<()> {
    m.add_function(wrap_pyfunction!(hello, m)?)?;
    Ok(())
}
