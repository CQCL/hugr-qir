import sys
from typing import no_type_check

from guppylang import guppy
from guppylang.std.builtins import array, owned
from guppylang.std.quantum import cx, measure, qubit


@guppy
@no_type_check
def main() -> None:
    q1, q2 = qubit(), qubit()
    q1, q2 = f(q1, q2)
    measure(q1)
    measure(q2)


@guppy.comptime
@no_type_check
def f(q1: qubit @ owned, q2: qubit @ owned) -> array[qubit, 2]:
    cx(q1, q2)
    return array(q1, q2)


if __name__ == "__main__":
    sys.stdout.buffer.write(guppy.compile(main).package.to_bytes())
