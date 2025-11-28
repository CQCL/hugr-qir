import sys
from typing import no_type_check

from guppylang import guppy, qubit
from guppylang.std.builtins import result
from guppylang.std.quantum import h, measure, x, y, z


@guppy
@no_type_check
def main() -> None:
    q0, q1, q2, q3 = qubit(), qubit(), qubit(), qubit()
    h(q0)
    h(q1)
    h(q2)
    h(q3)
    my_int = 0
    a = measure(q0)
    b = measure(q1)
    c = measure(q2)
    if a:
        my_int += 1
    if b:
        my_int += 1
    if c:
        my_int += 1

    if my_int == 0:
        h(q3)
    elif my_int == 1:
        x(q3)
    elif my_int == 2:  # noqa: PLR2004
        y(q3)
    elif my_int == 3:  # noqa: PLR2004
        z(q3)
    d = measure(q3)
    result("a", a)
    result("b", b)
    result("c", c)
    result("d", d)


if __name__ == "__main__":
    sys.stdout.buffer.write(main.compile().to_bytes())
