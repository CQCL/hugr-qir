import base64
import hashlib
from pathlib import Path

import pytest
from hugr_qir.hugr_to_qir import hugr_to_qir
from llvmlite.binding import (  # type: ignore
    create_context,
    parse_assembly,
    parse_bitcode,
)
from pytest_snapshot.plugin import Snapshot  # type: ignore

from .conftest import guppy_files, guppy_to_hugr_binary

SNAPSHOT_DIR = Path(__file__).parent / "snapshots"
GUPPY_EXAMPLES_XFAIL: list[str] = []

guppy_files_xpass = [
    guppy_file
    for guppy_file in guppy_files
    if guppy_file.name not in GUPPY_EXAMPLES_XFAIL
]

guppy_files_xfail = [
    guppy_file for guppy_file in guppy_files if guppy_file.name in GUPPY_EXAMPLES_XFAIL
]


@pytest.mark.parametrize(
    "guppy_file",
    guppy_files_xpass,
    ids=[str(file_path.stem) for file_path in guppy_files_xpass],
)
def test_guppy_files(guppy_file: Path) -> None:
    hugr = guppy_to_hugr_binary(guppy_file)
    hugr_to_qir(hugr)


@pytest.mark.parametrize(
    "guppy_file",
    guppy_files_xfail,
    ids=[str(file_path.stem) for file_path in guppy_files_xfail],
)
def test_guppy_files_xfail(guppy_file: Path) -> None:
    hugr = guppy_to_hugr_binary(guppy_file)
    with pytest.raises(ValueError):  # noqa: PT011
        hugr_to_qir(hugr)


@pytest.mark.parametrize(
    "guppy_file", guppy_files, ids=[str(file_path.stem) for file_path in guppy_files]
)
def test_guppy_file_snapshots(guppy_file: Path, snapshot: Snapshot) -> None:
    snapshot.snapshot_dir = SNAPSHOT_DIR
    hugr = guppy_to_hugr_binary(guppy_file)
    qir = hugr_to_qir(hugr, validate_qir=False, emit_text=True)
    snapshot.assert_match(qir, str(Path(guppy_file.stem).with_suffix(".ll")))


@pytest.mark.parametrize(
    "guppy_file", guppy_files, ids=[str(file_path.stem) for file_path in guppy_files]
)
def test_bitcode_and_assembly_output_match(guppy_file: Path) -> None:
    hugr = guppy_to_hugr_binary(guppy_file)
    qir_bitcode_bytes = base64.b64decode(
        hugr_to_qir(hugr, validate_qir=False).encode("utf-8")
    )
    qir_assembly = hugr_to_qir(hugr, validate_qir=False, emit_text=True)
    # use a fresh context for each operation to prevent variable name collisions
    module = parse_bitcode(qir_bitcode_bytes, context=create_context())
    module2 = parse_bitcode(
        parse_assembly(qir_assembly, context=create_context()).as_bitcode(),
        context=create_context(),
    )  # the conversion to bitcode removes comments
    hashes = [
        hashlib.sha256(str(mod).encode()).hexdigest() for mod in [module, module2]
    ]
    assert hashes[0] == hashes[1]
