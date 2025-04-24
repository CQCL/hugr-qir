import sys
from typing import no_type_check

from guppylang import guppy, quantum, qubit
from guppylang.std.angles import angle, angles
from guppylang.std.builtins import result
from guppylang.std.quantum import cx, cz, h, measure, rx, ry, rz, s, t, x, y, z

guppy.load(quantum)
guppy.load(angles)


@guppy
@no_type_check
def main() -> None:
    q0 = qubit()
    q1 = qubit()

    h(q0)
    s(q0)
    t(q0)

    x(q0)
    y(q0)
    z(q0)

    cx(q0, q1)
    cz(q0, q1)

    rx(q0, angle(1.5))
    ry(q0, angle(1.5))
    rz(q0, angle(1.5))

    result("0", measure(q0))
    result("1", measure(q1))


if __name__ == "__main__":
    sys.stdout.buffer.write(guppy.get_module().compile().package.to_bytes())
