from pathlib import Path
from typing import no_type_check

from guppylang import guppy
from guppylang.defs import GuppyFunctionDefinition
from guppylang.std.angles import angle
from guppylang.std.builtins import array, owned
from guppylang.std.platform import result
from guppylang.std.qsystem.random import RNG
from guppylang.std.quantum import crz, cx, h, measure, qubit


@guppy
@no_type_check
def one_runtime_random_h(r: RNG, qs: tuple[qubit, qubit, qubit, qubit]) -> None:
    random_inx = r.random_int_bounded(4)
    if random_inx == 0:
        h(qs[0])
    if random_inx == 1:
        h(qs[1])
    if random_inx == 2:  # noqa: PLR2004
        h(qs[2])
    if random_inx == 3:  # noqa: PLR2004
        h(qs[3])
    # Note: Guppy won't allow h(qs[r.random_int_bounded(4)])
    # because qs is a tuple
    # Could do it for an array, but it would not lower to valid QIR


@guppy
@no_type_check
def conditional_measure(q0: qubit @ owned, q1: qubit @ owned) -> tuple[bool, bool]:
    q2 = qubit()
    h(q2)
    c = measure(q2)
    if c:
        h(q0)
    a = measure(q0)
    if a:
        h(q1)
    b = measure(q1)
    return a, b


def do_stuff(q_list: list[qubit], theta: float) -> None:
    for i in range(len(q_list) - 1):
        cx(q_list[i], q_list[i + 1])
        if i % 4 == 0:
            crz(q_list[i], q_list[i + 1], angle(theta))  # type: ignore[call-arg]


def cx_registers(qreg1: list[qubit], qreg2: list[qubit]) -> None:
    size = len(qreg1)
    for i in range(size):
        cx(qreg1[i], qreg2[i])


def add_some_hadamards_kind_of_randomly(q: list[qubit]) -> None:
    size = len(q)
    r = RNG(12)
    for i in range(0, size - 3, 4):
        one_runtime_random_h(r, (q[i], q[i + 1], q[i + 2], q[i + 3]))
    r.discard()


def measure_qubits(qreg: list[qubit]) -> None:
    for i, q in enumerate(qreg):
        result(f"q_{i}", measure(q))


def measure_qubits_weirdly(q: list[qubit]) -> None:
    size = len(q)
    for i in range(0, size - 1, 2):
        qres_i, qres_ip1 = conditional_measure(q[i], q[i + 1])
        result(f"q2_{i}", qres_i)
        result(f"q2_{i + 1}", qres_ip1)


def main_generator(size: int) -> GuppyFunctionDefinition[[None], None]:
    theta = 0.3

    @guppy.comptime
    @no_type_check
    def main() -> None:
        q = array(qubit() for _ in range(size))
        q2 = array(qubit() for _ in range(size))
        h(q[0])
        do_stuff(q, theta)
        add_some_hadamards_kind_of_randomly(q2)
        cx_registers(q, q2)
        measure_qubits(q)
        measure_qubits_weirdly(q2)

    return main


if __name__ == "__main__":
    package = main_generator(28).compile()
    outfile = Path("./avoid_arrays_test.hugr")
    with outfile.open("wb") as of:
        of.write(package.to_bytes())
