"""Cli for hugr-qir."""

import tempfile
from importlib.metadata import version
from pathlib import Path
from typing import IO

import click
from quantinuum_qircheck import qircheck
from quantinuum_qircheck.qircheck import ValidationError

from hugr_qir._hugr_qir import (
    cli,
    compile_target_choices,
    opt_level_choices,
    output_format_choices,
)


@click.command(name="hugr-qir")
@click.argument("hugr_file", type=click.Path(exists=True, path_type=Path))
@click.option(
    "--validate-qir/--no-validate-qir",
    "validate_qir",
    default=True,
    help="Whether to validate the QIR output",
)
@click.option(
    "--validate-hugr/--no-validate-hugr",
    "validate_hugr",
    default=False,
    help="Whether to validate the input hugr before and after each internal pass",
)
@click.option(
    "-t",
    "--target",
    "target",
    type=click.Choice(compile_target_choices(), case_sensitive=False),
    default=None,
    help="LLVM compile target",
)
@click.option(
    "-l",
    "--opt-level",
    "opt_level",
    type=click.Choice(opt_level_choices(), case_sensitive=False),
    default=None,
    help="LLVM optimization level",
)
@click.option(
    "-f",
    "--output-format",
    "output_format",
    type=click.Choice(output_format_choices(), case_sensitive=False),
    default=None,
    help="Choice of output format",
)
@click.option(
    "-o",
    "--output",
    "outfile",
    type=click.File("w"),
    default="-",
    help="Name of output file (optional)",
)
@click.version_option(version=version("hugr_qir"))
def hugr_qir(  # noqa: PLR0913
    validate_qir: bool,
    validate_hugr: bool,
    target: str | None,
    opt_level: str | None,
    output_format: str | None,
    hugr_file: Path,
    outfile: IO,
) -> None:
    """Convert a HUGR file to QIR.

    Provide the name of the HUGR file as the first argument.
    Per default, QIR is emitted to stdout, but can
    be written to a file using the `-o` option.
    """
    hugr_qir_impl(
        validate_qir,
        validate_hugr,
        target,
        opt_level,
        output_format,
        hugr_file,
        outfile,
    )


def hugr_qir_impl(  # noqa: PLR0913
    validate_qir: bool,
    validate_hugr: bool,
    target: str | None,
    opt_level: str | None,
    output_format: str | None,
    hugr_file: Path,
    outfile: IO,
) -> None:
    options = ["-q"]
    if target:
        options.append(f"-t {target}")
    if opt_level:
        options.append(f"-l {opt_level}")
    if output_format:
        options.append(f"-f {output_format}")
    if validate_hugr:
        options.append("--validate")
    with tempfile.TemporaryDirectory(ignore_cleanup_errors=True) as tmp_dir:
        tmp_outfile_name = f"{tmp_dir}/tmp.ll"  # noqa: S108
        tmp_outfile_path = Path(tmp_outfile_name)
        tmp_options = [*options, "-o", tmp_outfile_name]
        cli(str(hugr_file), *tmp_options)
        with Path.open(tmp_outfile_path) as output:
            qir = output.read()
    if validate_qir:
        try:
            qircheck(qir)
        except ValidationError as e:
            msg = f"Found a problem in the generated QIR: {e}"
            raise ValueError(msg) from e

    outfile.write(qir)


if __name__ == "__main__":
    hugr_qir()
