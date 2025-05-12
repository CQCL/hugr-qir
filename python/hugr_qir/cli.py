"""Cli for hugr-qir."""

import tempfile
from importlib.metadata import version
from pathlib import Path
from typing import IO

import click
from quantinuum_qircheck import qircheck

from hugr_qir._hugr_qir import cli


@click.command(name="hugr-qir")
@click.argument("hugr_file", type=click.Path(exists=True, path_type=Path))
@click.option(
    "--validate-qir/--no-validate-qir",
    "validate",
    default=True,
    help="Whether to validate the QIR output",
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
def hugr_qir(validate: bool, hugr_file: Path, outfile: IO) -> None:
    """Convert a HUGR file to QIR.

    Provide the name of the HUGR file as the first argument.
    Per default, QIR is emitted to stdout, but can
    be written to a file using the `-o` option.
    """
    hugr_qir_impl(validate, hugr_file, outfile)


def hugr_qir_impl(validate: bool, hugr_file: Path, outfile: IO) -> None:
    options = ["-q"]
    with tempfile.NamedTemporaryFile(delete=True, suffix=".ll") as temp_file:
        tmp_options = [*options, "-o", temp_file.name]
        cli(str(hugr_file), *tmp_options)
        with Path.open(Path(temp_file.name)) as output:
            qir = output.read()
    if validate:
        qircheck(qir)

    outfile.write(qir)


if __name__ == "__main__":
    hugr_qir()
