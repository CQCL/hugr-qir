import tempfile
from base64 import b64encode
from pathlib import Path

from hugr.package import ModulePointer
from llvmlite.binding import (  # type: ignore[import-untyped]
    create_context,
    parse_assembly,
)

from .cli import hugr_qir_impl


def hugr_to_qir(
    hugr: ModulePointer | bytes, *, validate_qir: bool = True, emit_text: bool = False
) -> str:
    """A function for converting hugr to qir (llvm bitcode)

    :param hugr: HUGR in binary format
    :param validate_qir: Whether to validate the created QIR
    :param emit_text: If True, output qir as human-readable LLVM assembly language

    :returns: QIR corresponding to the HUGR input as an LLVM bitcode string base64
    encoded (default) or as human-readable LLVM assembly language (when
    passing `as_bitcode = False`)
    """
    with (
        tempfile.NamedTemporaryFile(delete=True, suffix=".hugr") as temp_infile,
        tempfile.NamedTemporaryFile(delete=True, suffix=".ll") as temp_outfile,
    ):
        hugr_bytes: bytes

        if type(hugr) is bytes:
            hugr_bytes = hugr
        else:
            assert type(hugr) is ModulePointer  # noqa: S101
            hugr_bytes = hugr.package.to_bytes()

        with Path.open(Path(temp_infile.name), "wb") as cli_input:
            cli_input.write(hugr_bytes)
        with Path.open(Path(temp_outfile.name), "w") as cli_output:
            hugr_qir_impl(validate_qir, Path(temp_infile.name), cli_output)
        with Path.open(Path(temp_outfile.name), "r") as cli_output:
            qir_ir = cli_output.read()
            if emit_text:
                return qir_ir
            ctx = create_context()
            module = parse_assembly(qir_ir, context=ctx)
            qir_bitcode = module.as_bitcode()
            return b64encode(qir_bitcode).decode("utf-8")
