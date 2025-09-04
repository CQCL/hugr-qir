from base64 import b64encode
from enum import Enum

from llvmlite.binding import (  # type: ignore[import-untyped]
    create_context,
    parse_assembly,
)


class OutputFormat(Enum):
    LLVM_IR = "llvm-ir"
    BITCODE = "bitcode"
    BASE64 = "base64"


def expected_file_extension(out_format: OutputFormat | str) -> str:
    if isinstance(out_format, str):
        out_format = OutputFormat(out_format)
    match out_format:
        case OutputFormat.BASE64:
            return ".b64"
        case OutputFormat.LLVM_IR:
            return ".ll"
        case OutputFormat.BITCODE:
            return ".bc"
        case _:
            msg = "Unrecognized output format"
            raise ValueError(msg)


def get_write_mode(out_format: OutputFormat) -> str:
    if out_format == OutputFormat.BITCODE:
        return "wb"
    return "w"


def ir_string_to_output_format(qir_ir: str, output_format: OutputFormat) -> str | bytes:
    match output_format:
        case OutputFormat.LLVM_IR:
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
        case _:
            errmsg = "Unrecognized output format"
            raise ValueError(errmsg)
