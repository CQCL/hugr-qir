use std::{env, path::Path, process::{self, Command, Stdio}};

use hugr::{package::Package, std_extensions::STD_REG, Hugr};
use hugr_llvm::inkwell;
use hugr_qir::CompileArgs;
use insta::assert_snapshot;
use itertools::Itertools as _;
use rstest::rstest;

fn capture_guppy(path: impl AsRef<Path>) -> (Hugr, String) {
    let process::Output {
        status,
        stdout,
        stderr,
    } = Command::new(".devenv/state/venv/bin/python")
        .arg(path.as_ref())
        .stdin(Stdio::null())
        .stdout(Stdio::piped())
        .stderr(Stdio::piped())
        .output()
        .unwrap();
    eprintln!("{}", std::str::from_utf8(&stdout).unwrap());
    eprintln!("{}", std::str::from_utf8(&stderr).unwrap());
    assert!(status.success());
    let hugr = Package::from_json_reader(stdout.as_slice(), &STD_REG)
        .unwrap()
        .modules
        .into_iter()
        .exactly_one()
        .unwrap();
    let stderr = String::from_utf8(stderr).unwrap();
    (hugr, stderr)
}

fn compile(hugr: &mut Hugr) -> String {
    let args = {
        let mut a = CompileArgs::default();
        a.validate = true;
        a
    };
    let context = inkwell::context::Context::create();
    let module = args.compile(hugr, &context).unwrap();
    module.to_string()
}

// This generates a test case for each file matching 'guppy_examples/**/*.py'
//
// For now we snapshot test the stderr output of executing the python file,
// and the LLVM IR output by hugr-qir.
//
// If we get problems with new test cases not being run in dev environments we might consider
// adding a `build.rs` as in:
// <https://docs.rs/rstest/latest/rstest/attr.rstest.html#files-path-as-input-arguments>
#[rstest]
fn guppy_examples(
    #[base_dir = "guppy_examples"]
    #[files("**/*.py")]
    file: impl AsRef<Path>,
) {
    let file2 = file.as_ref();
    let mut settings = insta::Settings::clone_current();
    settings.set_snapshot_suffix(file2.file_stem().unwrap().to_str().unwrap());
    settings.bind(|| {
        let (mut hugr, stderr) = capture_guppy(file);
        assert_snapshot!("llvmir", compile(&mut hugr));
        assert_snapshot!("stderr", stderr);
    });
}
