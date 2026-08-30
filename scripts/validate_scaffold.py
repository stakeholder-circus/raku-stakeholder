#!/usr/bin/env python3
"""Validate the Raku deterministic tranche and delivery baseline."""

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
    ".github/workflows/actionlint.yml",
    ".github/workflows/dependency-review.yml",
    ".github/workflows/sast.yml",
    ".github/workflows/security-analysis.yml",
    ".github/dependabot.yml",
    "bin/stakeholder.raku",
    "Makefile",
    "tests/test_cli.sh",
]


def main() -> int:
    missing = [path for path in REQUIRED if not Path(path).exists()]
    if missing:
        for path in missing:
            print(f"missing Raku deterministic tranche file: {path}")
        return 1
    status_files = [
        "AGENTS.md",
        "README.md",
        "STATUS.md",
        "GAPS.md",
        "PARITY.md",
        "docs/remotes.md",
    ]
    stale_markers = ("scaffold-only", "Docker validation is deferred", "local only, no upstream tracking")
    stale = [
        f"{path}: {marker}"
        for path in status_files
        for marker in stale_markers
        if marker in Path(path).read_text(encoding="utf-8")
    ]
    if stale:
        for finding in stale:
            print(f"stale Raku status marker: {finding}")
        return 1
    print("Raku deterministic runtime, delivery, and security baseline files are present")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
