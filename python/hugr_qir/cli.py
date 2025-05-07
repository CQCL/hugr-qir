"""Cli for hugr-qir."""

import tempfile
from importlib.metadata import version
from pathlib import Path

import click
from quantinuum_qircheck import qircheck

from hugr_qir._hugr_qir import cli


@click.command(name="hugr-qir")
@click.argument("hugr_file")
@click.option(
    "--validate-qir/--no-validate-qir",
    "validate",
    default=True,
    help="Whether to validate output",
)
@click.option(
    "-o",
    "--output",
    "outfile",
    type=str,
    default=None,
    help="Name of output file (optional)",
)
@click.version_option(version=version("hugr_qir"))
def main(validate: bool, hugr_file: str, outfile: str | None) -> None:
    """This is the cli for converting hugr to qir."""

    options = ["-q"]
    with tempfile.NamedTemporaryFile(delete=True, suffix=".ll") as temp_file:
        tmp_options = [*options, "-o", temp_file.name]
        cli(hugr_file, *tmp_options)
        with Path.open(Path(temp_file.name)) as output:
            qir = output.read()
            print(qir)
    if validate:
        qircheck(qir)

    if outfile:
        with Path.open(Path(outfile), "w") as f:
            print(qir, file=f)
    else:
        print(qir)


if __name__ == "__main__":
    main()
