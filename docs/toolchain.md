# Toolchain

Raku validation uses Rakudo on MoarVM. Fast local feedback may use Homebrew on arm64 macOS; authoritative native and Docker gates run on Ubuntu 24.04 in GitHub Actions.

## Proven commands

- `raku --version`
- `raku -c bin/stakeholder.raku`
- `make compiler-proof`
- `make analyze`
- `make test`
- `docker build -t raku-stakeholder .`
- `docker run --rm raku-stakeholder --list-values`

Toolchain sources: Homebrew `rakudo` for optional macOS feedback, Ubuntu's `raku` package for GitHub-native and Docker gates, and Nix for reproducible workspace discovery. No Raku package-manager dependencies are required by the deterministic tranche.
