from typing import no_type_check

from guppylang import guppy, qubit
from guppylang.std.builtins import result
from guppylang.std.quantum import h, measure
from hugr_qir.hugr_to_qir import hugr_to_qir


@guppy
@no_type_check
def main() -> None:
    q0 = qubit()
    q1 = qubit()

    h(q0)
    h(q1)

    b0 = measure(q0)
    b1 = measure(q1)
    b2 = b0 ^ b1

    result("0", b2)


qir = hugr_to_qir(main.compile(), emit_text=True)

assert len(qir) > 10  # noqa: PLR2004
