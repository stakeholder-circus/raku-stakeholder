# Docker validation is intentionally deferred for this M1-safe local Raku tranche.
# The native validation lane uses Homebrew Rakudo on macOS.
FROM alpine:3.20
CMD ["sh", "-c", "echo 'Docker validation deferred for raku-stakeholder'; exit 1"]
