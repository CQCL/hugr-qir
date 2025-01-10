#!/usr/bin/env python3

from guppylang import guppy, quantum, qubit
from guppylang.std.angles import angle, angles
from guppylang.std.quantum import *

guppy.load(quantum)
guppy.load(angles)


@guppy
def rx(q: qubit, x: angle) -> None:
    # Implement Rx via Rz rotation
    h(q)
    rz(q, x)
    h(q)


@guppy
def main() -> None:
    q = qubit()
    rx(q, angle(1.5))
    result("1", measure(q))


if __name__ == "__main__":
    print(guppy.get_module().compile().package.to_json())
