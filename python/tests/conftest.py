import subprocess
import sys
import tempfile
from pathlib import Path
from typing import IO

from click.testing import CliRunner
from hugr_qir.cli import hugr_qir

GUPPY_EXAMPLES_DIR = Path(__file__).parent / "../../guppy_examples"


def guppy_to_hugr_file(guppy_file: Path, outfd: IO) -> None:
    subprocess.run(  # noqa: S603
        [sys.executable, guppy_file],
        check=True,
        stdout=outfd,
        text=True,
    )


def guppy_to_hugr_binary(guppy_file: Path) -> bytes:
    with tempfile.TemporaryDirectory(ignore_cleanup_errors=True) as temp_dir:
        temp_hugr_path = Path(f"{temp_dir}/tmp.hugr")  # noqa: S108
        with Path.open(temp_hugr_path, "wb") as outfd:
            subprocess.run(  # noqa: S603
                [sys.executable, guppy_file],
                check=True,
                stdout=outfd,
                text=True,
            )
        with Path.open(Path(temp_hugr_path), "rb") as outfd:
            return outfd.read()


def get_guppy_files() -> list[Path]:
    guppy_dir = Path(GUPPY_EXAMPLES_DIR)
    return list(guppy_dir.glob("*.py"))


guppy_files = get_guppy_files()


def cli_on_guppy(guppy_file: Path, tmp_path: Path, *args: str) -> None:
    guppy_file = Path(guppy_file)
    hugr_file = tmp_path / Path(f"{guppy_file.name}.hugr")
    with Path.open(hugr_file, "w") as f:
        guppy_to_hugr_file(guppy_file, f)
    runner = CliRunner()
    runner.invoke(hugr_qir, [str(hugr_file), *[str(arg) for arg in args]])
