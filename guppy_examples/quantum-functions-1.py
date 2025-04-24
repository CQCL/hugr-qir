import sys
from typing import no_type_check

from guppylang import guppy, quantum, qubit
from guppylang.std.angles import angles
from guppylang.std.builtins import result
from guppylang.std.quantum import h, measure

guppy.load(quantum)
guppy.load(angles)


@guppy
@no_type_check
def fun_func(q: qubit) -> None:
    h(q)


@guppy
@no_type_check
def main() -> None:
    q0 = qubit()
    q1 = qubit()

    fun_func(q0)
    fun_func(q1)

    result("0", measure(q0))
    result("1", measure(q1))


if __name__ == "__main__":
    sys.stdout.buffer.write(guppy.get_module().compile().package.to_bytes())
