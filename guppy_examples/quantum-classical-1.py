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
    
    h(q0)
    h(q1)
    
    b0 = measure(q0)
    b1 = measure(q1)
    b2 = b0 ^ b1

    result("0", b2)

if __name__ == "__main__":
    print(guppy.get_module().compile().package.to_json())
