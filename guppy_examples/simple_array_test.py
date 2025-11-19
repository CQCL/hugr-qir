import sys
from typing import no_type_check

from guppylang import guppy
from guppylang.std.builtins import array, owned
from guppylang.std.platform import result
from guppylang.std.quantum import cx, measure, qubit


@guppy
@no_type_check
def main() -> None:
    q = f(qubit(), qubit())
    q1, q2 = q
    inttt = array(1, 2, 3, 4)
    s = array(qubit() for _ in range(3))
    s1, s2, s3 = s
    result("rug11", measure(q1))
    result("arr3", inttt[3])
    measure(q2)
    measure(s1)
    measure(s2)
    measure(s3)


@guppy.comptime
@no_type_check
def f(q1: qubit @ owned, q2: qubit @ owned) -> array[qubit, 2]:
    cx(q1, q2)
    return array(q1, q2)


if __name__ == "__main__":
    sys.stdout.buffer.write(main.compile().to_bytes())
