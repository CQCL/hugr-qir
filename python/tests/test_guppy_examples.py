from pathlib import Path

import pytest
from pytest_snapshot.plugin import Snapshot  # type: ignore

from .conftest import cli_on_guppy, guppy_files

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
    snapshot.assert_match(qir, str(Path(guppy_file.stem).with_suffix(".ll")))
