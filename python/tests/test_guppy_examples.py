from pathlib import Path

import pytest
from hugr_qir._hugr_qir import compile_target_choices, opt_level_choices
from hugr_qir.output import OutputFormat, expected_file_extension
from pytest_snapshot.plugin import Snapshot  # type: ignore

from .conftest import (
    GUPPY_EXAMPLES_DIR_GENERAL,
    cli_on_guppy,
    guppy_files,
    skip_snapshot_checks,
)

SNAPSHOT_DIR = Path(__file__).parent / "snapshots"

guppy_files_xpass = list(guppy_files)


@pytest.mark.parametrize(
    "guppy_file",
    guppy_files_xpass,
    ids=[str(file_path.stem) for file_path in guppy_files_xpass],
)
def test_guppy_files(tmp_path: Path, guppy_file: Path) -> None:
    out_file = tmp_path / "out.ll"
    cli_on_guppy(
        guppy_file,
        tmp_path,
        "-o",
        str(out_file),
    )


@pytest.mark.parametrize(
    "guppy_file", guppy_files, ids=[str(file_path.stem) for file_path in guppy_files]
)
def test_guppy_file_snapshots(
    tmp_path: Path, guppy_file: Path, snapshot: Snapshot
) -> None:
    snapshot.snapshot_dir = SNAPSHOT_DIR
    out_file = tmp_path / "out.ll"
    cli_on_guppy(
        guppy_file,
        tmp_path,
        "-o",
        str(out_file),
        "--no-validate-qir",
        "--validate-hugr",
    )
    with Path.open(out_file) as f:
        qir = f.read()
    if not skip_snapshot_checks:
        snapshot.assert_match(qir, str(Path(guppy_file.stem).with_suffix(".ll")))


@pytest.mark.parametrize(
    ("target", "opt_level", "out_format"),
    [
        (t, opt, form)
        for t in compile_target_choices()
        for opt in opt_level_choices()
        for form in [c.value for c in OutputFormat]
    ],
)
def test_guppy_files_options(
    tmp_path: Path, snapshot: Snapshot, target: str, opt_level: str, out_format: str
) -> None:
    snapshot.snapshot_dir = SNAPSHOT_DIR
    guppy_file = Path(GUPPY_EXAMPLES_DIR_GENERAL) / Path("quantum-conditional-2.py")
    out_file = tmp_path / "out.ll"
    extra_args = ["-t", target, "-l", opt_level, "-f", out_format]
    if opt_level == "none":
        extra_args.append("--no-validate-qir")
    cli_on_guppy(guppy_file, tmp_path, "-o", str(out_file), *extra_args)
    file_read_mode = "rb" if out_format == "bitcode" else "r"
    file_suffix = expected_file_extension(out_format)
    with Path.open(out_file, mode=file_read_mode) as f:
        qir = f.read()
    # don't test snapshots for 'native' since output is machine-dependent
    if target != "native" and not skip_snapshot_checks:
        snapshot_filename = guppy_file.stem + "_" + target + "_" + opt_level
        snapshot.assert_match(
            qir, str(Path(snapshot_filename).with_suffix(file_suffix))
        )
