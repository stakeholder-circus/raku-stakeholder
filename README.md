> [!WARNING]
> This repository is AI-assisted and manually reviewed. It is local-only in the resource-safe small deterministic tranche.

# raku-stakeholder

Raku implementation of the stakeholder deterministic first tranche using Rakudo/MoarVM.

## Current tranche

- Full dedicated `classic-six + modern-core` generator families.
- Grouped fallback for later generator families.
- Deterministic normalized JSON with same-seed stability.
- `--list-values`, `--focus-family`, `--output-format`, `--seed`, and explicit `--experimental-provider` fail-fast.
- Full live-provider/runtime support remains deferred to the later provider wave.

## Commands

- `python3 scripts/validate_scaffold.py`
- `make compiler-proof`
- `make test`
- `raku bin/stakeholder.raku --list-values`

Docker is intentionally not used in this M1-safe pass; native Rakudo is the validation lane.
