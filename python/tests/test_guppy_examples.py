import subprocess
import sys
from pathlib import Path
from typing import IO

import pytest
from hugr_qir._hugr_qir import cli
from pytest_snapshot.plugin import Snapshot  # type: ignore
from quantinuum_qircheck import qircheck

GUPPY_EXAMPLES_DIR = Path(__file__).parent / "../../guppy_examples"
SNAPSHOT_DIR = Path(__file__).parent / "snapshots"
GUPPY_EXAMPLES_XFAIL = ["quantum-loop-1.py", "quantum-loop-2.py"]


def guppy_to_hugr_file(guppy_file: Path, outfd: IO) -> None:
    subprocess.run(  # noqa: S603
        [sys.executable, guppy_file],
        check=True,
        stdout=outfd,
        text=True,
    )


def cli_on_guppy(guppy_file: Path, tmp_path: Path, *args: str) -> None:
    guppy_file = Path(guppy_file)
    hugr_file = tmp_path / Path(f"{guppy_file.name}.hugr")
    with Path.open(hugr_file, "w") as f:
        guppy_to_hugr_file(guppy_file, f)
    cli(str(hugr_file), *[str(arg) for arg in args])


def get_guppy_files() -> list[Path]:
    guppy_dir = Path(GUPPY_EXAMPLES_DIR)
    return list(guppy_dir.glob("*.py"))


guppy_files = get_guppy_files()


@pytest.mark.parametrize(
    "guppy_file", guppy_files, ids=[str(file_path.stem) for file_path in guppy_files]
)
def test_guppy_files(tmp_path: Path, guppy_file: Path, snapshot: Snapshot) -> None:
    snapshot.snapshot_dir = SNAPSHOT_DIR
    out_file = tmp_path / "out.ll"
    cli_on_guppy(guppy_file, tmp_path, "-o", str(out_file))
    with Path.open(out_file) as f:
        qir = f.read()
    snapshot.assert_match(qir, str(Path(guppy_file.stem).with_suffix(".ll")))


@pytest.mark.parametrize(
    "guppy_file", guppy_files, ids=[str(file_path.stem) for file_path in guppy_files]
)
def test_guppy_files_qircheck(tmp_path: Path, guppy_file: Path) -> None:
    if guppy_file.name not in GUPPY_EXAMPLES_XFAIL:
        out_file = tmp_path / "out.ll"
        cli_on_guppy(guppy_file, tmp_path, "-o", str(out_file))
        with Path.open(out_file) as f:
            qir = f.read()
        qircheck(qir)
