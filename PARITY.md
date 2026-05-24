# Parity

Parity classification: deterministic first tranche, native-validated local only.

## Implemented

- CLI flags: `--list-values`, `--focus-family`, `--output-format`, `--seed`, `--experimental-provider`.
- Normalized JSON event fields: `eventType`, `sequence`, `family`, `message`, `timestamp`, `context`, `generationProvenance`, `outputFormat`.
- Full dedicated `classic-six + modern-core` family set.
- Grouped fallback for later generator families.

## Deferred

- Docker validation.
- Full live-provider/runtime support.
- Publication governance.
