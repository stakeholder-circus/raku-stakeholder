# raku-stakeholder Status

- Phase target: deterministic first tranche
- Phase state: implemented; native and Docker CI validation active
- Program state: deterministic tranche complete; live-provider tranche deferred
- Publication state: published at `stakeholder-circus/raku-stakeholder`; protected `main` pending first stable CI pass
- Current implementation: Raku script runtime using hash catalog data and deterministic string rendering without package dependencies

## Evidence

- `python3 scripts/validate_scaffold.py`
- `make compiler-proof`
- `make analyze`
- `make test`
- GitHub Actions contract, native, Docker, dependency, SAST, actionlint, and workflow-security gates

## Open

- Full live-provider/runtime support is deferred to the second-pass provider rollout wave.
