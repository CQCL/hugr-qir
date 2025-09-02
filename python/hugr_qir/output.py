from base64 import b64encode
from enum import Enum
from pathlib import Path

from llvmlite.binding import (  # type: ignore[import-untyped]
    create_context,
    parse_assembly,
)


class OutputFormat(Enum):
    LLVMIR = "llvmir"
    BITCODE = "bitcode"
    BASE64 = "base64"


def get_write_mode(out_format: OutputFormat | None, file_path: Path | None) -> str:
    if out_format and out_format in [OutputFormat.BITCODE, OutputFormat.BASE64]:
        return "wb"
    if file_path and file_path.suffix not in [".ll", ".asm"]:
        return "wb"
    return "w"


def ir_string_to_output_format(qir_ir: str, output_format: OutputFormat) -> str | bytes:
    match output_format:
        case OutputFormat.LLVMIR:
            return qir_ir
        case OutputFormat.BITCODE:
            ctx = create_context()
            module = parse_assembly(qir_ir, context=ctx)
            return module.as_bitcode()
        case OutputFormat.BASE64:
            ctx = create_context()
            module = parse_assembly(qir_ir, context=ctx)
            qir_bitcode = module.as_bitcode()
            return b64encode(qir_bitcode).decode("utf-8")
    errmsg = "Unrecognized output format"
    raise ValueError(errmsg)
