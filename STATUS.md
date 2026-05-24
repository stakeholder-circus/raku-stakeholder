# raku-stakeholder Status

- Phase target: deterministic first tranche
- Phase state: native-validated local tranche
- Program state: local deterministic widening
- Publication state: local only, no upstream tracking, no push
- Current implementation: Raku script runtime using hash catalog data and deterministic string rendering without package dependencies

## Evidence

- `python3 scripts/validate_scaffold.py`
- `make compiler-proof`
- `make test`

## Open

- Docker validation is deferred for M1 resource safety.
- Full live-provider/runtime support is deferred to the second-pass provider rollout wave.
- Publication remains blocked by the local-only policy for horizon scaffold and small-tranche work.
