import sys
from typing import no_type_check

from guppylang import guppy, qubit
from guppylang.std.builtins import result
from guppylang.std.quantum import h, measure


@guppy
@no_type_check
def main() -> None:
    q0 = qubit()
    q1 = qubit()
    h(q1)
    h(q1)
    result("0", measure(q0))
    result("1", measure(q1))


if __name__ == "__main__":
    sys.stdout.buffer.write(main.compile().to_bytes())
