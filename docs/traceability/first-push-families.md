# First push families

This local tranche ports the deterministic family-focus contract into a Raku runtime executed by Rakudo/MoarVM.

| Family group | Raku path | Source reference | Parity class |
| --- | --- | --- | --- |
| classic-six | `bin/stakeholder.raku` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| modern-core | `bin/stakeholder.raku` | current deterministic CLI family registry and smoke-contract shape | dedicated |
| later families | `bin/stakeholder.raku` | grouped fallback policy in current deterministic repos | grouped fallback |
| CLI contract | `bin/stakeholder.raku`, `tests/test_cli.sh` | small-tranche smoke contract | deterministic |
| experimental provider | `bin/stakeholder.raku`, `tests/test_cli.sh` | fail-fast provider policy in current deterministic repos | explicit fail-fast |

Rust and Java remain canonical behavioral anchors; this Raku tranche is local-only and native-validated.
