import tempfile
from pathlib import Path

from .cli import hugr_qir_impl


def hugr_to_qir(hugr: bytes, validate_qir: bool = True) -> str:
    """A function for converting hugr to qir.

    :param hugr: HUGR in binary format
    :param validate_qir: Whether to validate the created QIR

    :returns: QIR corresponding to the HUGR input as a text string
    """
    with (
        tempfile.NamedTemporaryFile(delete=True, suffix=".hugr") as temp_infile,
        tempfile.NamedTemporaryFile(delete=True, suffix=".ll") as temp_outfile,
    ):
        with Path.open(Path(temp_infile.name), "wb") as cli_input:
            cli_input.write(hugr)
        with Path.open(Path(temp_outfile.name), "w") as cli_output:
            hugr_qir_impl(validate_qir, Path(temp_infile.name), cli_output)
        with Path.open(Path(temp_outfile.name), "r") as cli_output:
            return cli_output.read()
