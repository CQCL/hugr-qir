import tempfile
from pathlib import Path

from hugr.package import Package

from ._hugr_qir import compile_target_default, opt_level_default
from .cli import hugr_qir_impl
from .output import OutputFormat, ir_string_to_output_format


def hugr_to_qir(  # noqa: PLR0913
    hugr: Package | bytes,
    *,
    validate_qir: bool = True,
    validate_hugr: bool = False,
    target: str = compile_target_default(),
    opt_level: str = opt_level_default(),
    output_format: OutputFormat = OutputFormat.BASE64,
) -> str | bytes:
    """A function for converting hugr to qir (llvm bitcode)

    :param hugr: HUGR in binary format
    :param validate_qir: Whether to validate the created QIR
    :param validate_hugr: Whether to validate the input hugr before
     and after each internal pass
    :param target: LLVM compilation target, same options as cli,
     run hugr-qir --help to see available options and default
    :param opt_level: LLVM optimization level, same options as cli,
     run hugr-qir --help to see available options and default
    :param output_format: Output format, see OutputFormat enum
     for available options
    :returns: QIR corresponding to the HUGR input in format given
     by `output_format`
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
        # Write to tmp file as llvmir (text) and convert after if necessary
        hugr_qir_impl(
            validate_qir,
            validate_hugr,
            target,
            opt_level,
            OutputFormat.LLVM_IR,
            tmp_infile_path,
            tmp_outfile_path,
        )
        with Path.open(tmp_outfile_path, "r") as cli_output:
            qir_ir = cli_output.read()

        return ir_string_to_output_format(qir_ir, output_format)
