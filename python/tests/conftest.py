import os
import subprocess
import sys
import tempfile
from pathlib import Path
from typing import IO

import pytest
from click.testing import CliRunner
from hugr_qir.cli import hugr_qir

GUPPY_EXAMPLES_DIR_GENERAL = Path(__file__).parent / "../../guppy_examples/general"
GUPPY_EXAMPLES_DIR_QHO = (
    Path(__file__).parent / "../../guppy_examples/quantinuum-hardware-only"
)
# Within the cibuildwheels environments, ssa variable names tend to be slightly
# different, so verbatim snapshot tests do not pass. So we just test
# that generation works for the wheel builds
skip_snapshot_checks = os.getenv("CIBUILDWHEEL") == "1"


def pytest_configure(config: pytest.Config) -> None:
    if skip_snapshot_checks:
        config.issue_config_time_warning(
            UserWarning(
                "Detected tests running on cibuildwheel,"
                " so skipping all snapshot checks"
            ),
            stacklevel=2,
        )


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
    guppy_dir_runable = Path(GUPPY_EXAMPLES_DIR_GENERAL)
    guppy_dir_unrunable = Path(GUPPY_EXAMPLES_DIR_QHO)

    return list(guppy_dir_runable.glob("*.py")) + list(guppy_dir_unrunable.glob("*.py"))


guppy_files = get_guppy_files()


def cli_on_guppy(guppy_file: Path, tmp_path: Path, *args: str) -> None:
    guppy_file = Path(guppy_file)
    hugr_file = tmp_path / Path(f"{guppy_file.name}.hugr")
    with Path.open(hugr_file, "w") as f:
        guppy_to_hugr_file(guppy_file, f)
    runner = CliRunner()
    runner.invoke(hugr_qir, [str(hugr_file), *[str(arg) for arg in args]])
