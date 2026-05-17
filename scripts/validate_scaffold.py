#!/usr/bin/env python3
"""Validate scaffold-only baseline file presence.

This script is scaffold-only for the Raku HorizonLanguage target.
No deterministic runtime validation is claimed.
"""

from pathlib import Path

REQUIRED = [
    "AGENTS.md",
    "README.md",
    "STATUS.md",
    "GAPS.md",
    "PARITY.md",
    "AI_DISCLOSURE.md",
    "docs/remotes.md",
    "docs/provenance.md",
    "docs/toolchain.md",
    "docs/traceability/first-push-families.md",
    "scripts/validate_scaffold.py",
    "flake.nix",
    "Dockerfile",
    ".github/workflows/ci.yml",
    ".github/workflows/ci-native.yml",
    ".github/workflows/docker-smoke.yml",
]


def main() -> int:
    missing = [path for path in REQUIRED if not Path(path).exists()]
    if missing:
        for path in missing:
            print(f"missing scaffold-only baseline file: {path}")
        return 1
    print("scaffold-only baseline files present; no deterministic runtime validation is claimed")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
