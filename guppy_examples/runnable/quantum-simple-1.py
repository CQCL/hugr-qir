import sys
from typing import no_type_check

from guppylang import guppy, qubit
from guppylang.std.builtins import result
from guppylang.std.quantum import h, measure


@guppy
@no_type_check
def main() -> None:
    q = qubit()
    h(q)
    result("0", measure(q))


if __name__ == "__main__":
    sys.stdout.buffer.write(main.compile().to_bytes())
