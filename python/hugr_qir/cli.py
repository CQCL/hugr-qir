"""Cli for hugr-qir."""

import tempfile
from importlib.metadata import version
from pathlib import Path

import click
from quantinuum_qircheck import qircheck

from hugr_qir._hugr_qir import cli


@click.command(name="hugr-qir")
@click.argument("hugr_file", type=click.Path(exists=True, path_type=Path))
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
    type=click.File("w"),
    default="-",
    help="Name of output file (optional)",
)
@click.version_option(version=version("hugr_qir"))
def hugr_qir(validate: bool, hugr_file: Path, outfile: click.File) -> None:
    """This is the cli for converting hugr to qir."""

    options = ["-q"]
    with tempfile.NamedTemporaryFile(delete=True, suffix=".ll") as temp_file:
        tmp_options = [*options, "-o", temp_file.name]
        cli(str(hugr_file), *tmp_options)
        with Path.open(Path(temp_file.name)) as output:
            qir = output.read()
    if validate:
        qircheck(qir)

    if hasattr(outfile, "write"):
        outfile.write(qir)
    else:
        # this should never happen but the check for write is
        # needed to appease mypy (click doesn't handle typing well)
        err_msg = f"Could not write to object {outfile}"
        raise AttributeError(err_msg)


if __name__ == "__main__":
    hugr_qir()
