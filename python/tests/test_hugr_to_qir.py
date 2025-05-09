from pathlib import Path

import pytest
from hugr_qir.hugr_to_qir import hugr_to_qir
from pytest_snapshot.plugin import Snapshot  # type: ignore

from .conftest import guppy_files, guppy_to_hugr_binary

SNAPSHOT_DIR = Path(__file__).parent / "snapshots"
GUPPY_EXAMPLES_XFAIL = ["quantum-loop-1.py", "quantum-loop-2.py"]

guppy_files_xpass = [
    guppy_file
    for guppy_file in guppy_files
    if guppy_file.name not in GUPPY_EXAMPLES_XFAIL
]


@pytest.mark.parametrize(
    "guppy_file",
    guppy_files_xpass,
    ids=[str(file_path.stem) for file_path in guppy_files_xpass],
)
def test_guppy_files(guppy_file: Path) -> None:
    hugr = guppy_to_hugr_binary(guppy_file)
    hugr_to_qir(hugr)


@pytest.mark.parametrize(
    "guppy_file", guppy_files, ids=[str(file_path.stem) for file_path in guppy_files]
)
def test_guppy_file_snapshots(guppy_file: Path, snapshot: Snapshot) -> None:
    snapshot.snapshot_dir = SNAPSHOT_DIR
    hugr = guppy_to_hugr_binary(guppy_file)
    qir = hugr_to_qir(hugr, validate_qir=False)
    snapshot.assert_match(qir, str(Path(guppy_file.stem).with_suffix(".ll")))
