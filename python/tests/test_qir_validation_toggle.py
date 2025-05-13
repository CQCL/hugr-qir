from pathlib import Path
from unittest.mock import patch

from .conftest import cli_on_guppy, guppy_files


def test_validate_qir_by_default(tmp_path: Path) -> None:
    out_file = tmp_path / "out.ll"
    with patch("hugr_qir.cli.qircheck") as mock_qircheck:
        cli_on_guppy(guppy_files[0], tmp_path, "-o", str(out_file))
        mock_qircheck.assert_called_once()


def test_validate_qir_if_validate_requested(tmp_path: Path) -> None:
    out_file = tmp_path / "out.ll"
    with patch("hugr_qir.cli.qircheck") as mock_qircheck:
        cli_on_guppy(guppy_files[0], tmp_path, "-o", str(out_file), "--validate-qir")
        mock_qircheck.assert_called_once()


def test_no_validate_qir_if_no_validate_requested(tmp_path: Path) -> None:
    out_file = tmp_path / "out.ll"
    with patch("hugr_qir.cli.qircheck") as mock_qircheck:
        cli_on_guppy(guppy_files[0], tmp_path, "-o", str(out_file), "--no-validate-qir")
        mock_qircheck.assert_not_called()
