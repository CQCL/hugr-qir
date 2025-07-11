import sys
from typing import no_type_check

from guppylang import guppy, qubit
from guppylang.std.angles import angle
from guppylang.std.builtins import result
from guppylang.std.quantum import h, measure, rz


@guppy
@no_type_check
def rx(q: qubit, x: angle) -> None:
    # Implement Rx via Rz rotation
    h(q)
    rz(q, x)
    h(q)


@guppy
@no_type_check
def main() -> None:
    q = qubit()
    rx(q, angle(1.5))
    result("1", measure(q))


if __name__ == "__main__":
    sys.stdout.buffer.write(guppy.compile(main).package.to_bytes())
