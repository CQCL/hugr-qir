from guppylang import guppy, quantum, qubit
from guppylang.std.angles import angle, angles
from guppylang.std.builtins import result
from guppylang.std.quantum import cx, cz, h, measure, rx, ry, rz, s, t, x, y, z

guppy.load(quantum)
guppy.load(angles)



@guppy
def fun_func(q: qubit) -> None:
    h(q)

@guppy
def main() -> None:
    q0 = qubit()
    q1 = qubit()

    fun_func(q0)
    fun_func(q1)
    
    result("0", measure(q0))
    result("1", measure(q1))


if __name__ == "__main__":
    print(guppy.get_module().compile().package.to_json())
