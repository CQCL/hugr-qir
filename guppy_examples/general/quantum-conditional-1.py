import sys
from typing import no_type_check

from guppylang import guppy, qubit
from guppylang.std.builtins import result
from guppylang.std.quantum import cx, h, measure, x


@guppy
@no_type_check
def main() -> None:
    q0 = qubit()
    q1 = qubit()

    h(q0)
    cx(q0, q1)

    b0 = measure(q0)

    if b0:
        x(q1)

    result("0", measure(q1))


if __name__ == "__main__":
    sys.stdout.buffer.write(main.compile().to_bytes())
