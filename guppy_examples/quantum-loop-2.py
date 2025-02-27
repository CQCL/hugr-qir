from guppylang import guppy, quantum, qubit
from guppylang.std.angles import angle, angles
from guppylang.std.builtins import result
from guppylang.std.quantum import cx, cz, h, measure, rx, ry, rz, s, t, x, y, z

guppy.load(quantum)
guppy.load(angles)


@guppy
def main() -> None:
    q0 = qubit()
    q1 = qubit()

    for _ in range(10):
        q3 = qubit()
        h(q3)
        b = measure(q3)
        if b:
            h(q0)

    result("0", measure(q0))
    result("1", measure(q1))


if __name__ == "__main__":
    print(guppy.get_module().compile().package.to_json())
