import tempfile
from base64 import b64encode
from pathlib import Path

from hugr.package import Package
from llvmlite.binding import (  # type: ignore[import-untyped]
    create_context,
    parse_assembly,
)

from .cli import hugr_qir_impl


def hugr_to_qir(
    hugr: Package | bytes,
    *,
    validate_qir: bool = True,
    validate_hugr: bool = False,
    emit_text: bool = False,
) -> str:
    """A function for converting hugr to qir (llvm bitcode)

    :param hugr: HUGR in binary format
    :param validate_qir: Whether to validate the created QIR
    :param validate_hugr: Whether to validate the input hugr before
     and after each internal pass
    :param emit_text: If True, output qir as human-readable LLVM assembly language

    :returns: QIR corresponding to the HUGR input as an LLVM bitcode string base64
    encoded (default) or as human-readable LLVM assembly language (when
    passing `as_bitcode = False`)
    """
    with tempfile.TemporaryDirectory(ignore_cleanup_errors=True) as tmp_dir:
        hugr_bytes: bytes
        tmp_infile_path = Path(f"{tmp_dir}/tmp.hugr")  # noqa: S108
        tmp_outfile_path = Path(f"{tmp_dir}/tmp.ll")  # noqa: S108

        if type(hugr) is bytes:
            hugr_bytes = hugr
        else:
            assert type(hugr) is Package  # noqa: S101
            hugr_bytes = hugr.to_bytes()

        with Path.open(tmp_infile_path, "wb") as cli_input:
            cli_input.write(hugr_bytes)
        with Path.open(tmp_outfile_path, "w") as cli_output:
            hugr_qir_impl(validate_qir, validate_hugr, tmp_infile_path, cli_output)
        with Path.open(tmp_outfile_path, "r") as cli_output:
            qir_ir = cli_output.read()

        if emit_text:
            return qir_ir

        ctx = create_context()
        module = parse_assembly(qir_ir, context=ctx)
        qir_bitcode = module.as_bitcode()
        return b64encode(qir_bitcode).decode("utf-8")
