from guppylang import guppy, quantum, qubit
from guppylang.std.angles import angles
from guppylang.std.builtins import result
from guppylang.std.quantum import h, measure

guppy.load(quantum)
guppy.load(angles)


@guppy
def main() -> None:
    q = qubit()
    h(q)
    result("0", measure(q))


if __name__ == "__main__":
    print(guppy.get_module().compile().package.to_json())
