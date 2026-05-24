# Toolchain

Raku native validation uses Rakudo on MoarVM on arm64 macOS.

## Proven commands

- `raku --version`
- `raku -c bin/stakeholder.raku`
- `make compiler-proof`
- `make test`

Toolchain source: Homebrew bottled `rakudo` 2026.05 plus `moarvm`, `nqp`, and `mimalloc`. Docker, Nix, and Raku package managers are not required for the current deterministic first tranche.
