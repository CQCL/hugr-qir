import subprocess
import sys
from pathlib import Path

from hugr_qir._hugr_qir import cli

GUPPY_EXAMPLES_DIR = Path(__file__).parent / "../../../guppy_examples/"


def guppy_to_hugr_json_file(guppy_file, outfd) -> None:
    subprocess.run(
        [sys.executable, GUPPY_EXAMPLES_DIR / guppy_file],
        check=True,
        stdout=outfd,
        text=True,
    )


def cli_on_guppy(guppy_file, tmp_path, *args) -> None:
    guppy_file = Path(guppy_file)
    json_file = tmp_path / Path(f"{guppy_file.name}.json")
    with open(json_file, "w") as f:
        guppy_to_hugr_json_file(guppy_file, f)
    cli(str(json_file), *[str(arg) for arg in args])


def test_guppy_planqc_q(tmp_path) -> None:
    out_file = tmp_path / "out.ll"
    cli_on_guppy("planqc_1.py", tmp_path, "-o", out_file)
