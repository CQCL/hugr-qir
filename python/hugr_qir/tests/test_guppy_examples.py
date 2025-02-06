import subprocess
from typing import Any

import pytest
import sys
from pathlib import Path

from hugr_qir._hugr_qir import cli
from quantinuum_qircheck import qircheck

GUPPY_EXAMPLES_DIR = Path(__file__).parent / "../../../guppy_examples/"


def guppy_to_hugr_json_file(guppy_file: Path, outfd: bytes) -> None:
    subprocess.run(  # noqa: S603
        [sys.executable, guppy_file],
        check=True,
        stdout=outfd,
        text=True,
    )


def cli_on_guppy(guppy_file: Path, tmp_path: Path, *args: Any) -> None:
    guppy_file = Path(guppy_file)
    json_file = tmp_path / Path(f"{guppy_file.name}.json")
    with Path.open(json_file, "w") as f:
        guppy_to_hugr_json_file(guppy_file, f)
    cli(str(json_file), *[str(arg) for arg in args])

@pytest.mark.xfail(reason="hugr to qir conversion still a wip")
def test_guppy_files(tmp_path: Path) -> None:
    out_file = tmp_path / "out.ll"
    guppy_dir = Path(GUPPY_EXAMPLES_DIR)
    for file in guppy_dir.glob('*.py'):
        cli_on_guppy(file, tmp_path, "-o", out_file)
        with Path.open(out_file) as f:
            qir = f.read()
        qircheck(qir)
