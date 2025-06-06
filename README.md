# hugr-qir

# WARNING: this is a beta version, still under development and not all hugr/guppy programs can be converted

[![build_status][]](https://github.com/CQCL/hugr-qir/actions)
[![codecov][]](https://codecov.io/gh/CQCL/hugr-qir)

A tool for converting Hierarchical Unified Graph Representation (HUGR, pronounced _hugger_) formatted quantum programs into [QIR](https://github.com/qir-alliance/qir-spec) format.


## Installation

You can install this from pypi via `pip install hugr-qir`.

## Usage

You can find an example notebook at `examples/submit-guppy-h1-h2-via-qir.ipynb`.

## Development

### #️⃣ Setting up the development environment

The easiest way to setup the development environment is to use the provided
[`devenv.nix`](devenv.nix) file. This will setup a development shell with all the
required dependencies.

To use this, you will need to install [devenv](https://devenv.sh/getting-started/).
Once you have it running, open a shell with:

```bash
devenv shell
```

All the required dependencies should be available. You can automate loading the
shell by setting up [direnv](https://devenv.sh/automatic-shell-activation/).

### Run tests

You can run the rust test with:

```bash
cargo test
```

You can run the Python test with:

```bash
pytest
```

If you want to update the snapshots you can do that via:

```bash
pytest --snapshot-update
```

## License

This project is licensed under Apache License, Version 2.0 ([LICENSE][] or http://www.apache.org/licenses/LICENSE-2.0).

[build_status]: https://github.com/CQCL/hugr-qir/actions/workflows/ci-py.yml/badge.svg?branch=main
[codecov]: https://img.shields.io/codecov/c/gh/CQCL/hugr-qir?logo=codecov
[LICENSE]: https://github.com/CQCL/hugr-qir/blob/main/LICENCE
