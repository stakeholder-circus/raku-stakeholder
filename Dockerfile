FROM ubuntu:24.04 AS build

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends raku \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace
COPY bin/ bin/
COPY tests/ tests/
RUN raku -c bin/stakeholder.raku \
    && RAKU=raku BIN=bin/stakeholder.raku tests/test_cli.sh

FROM ubuntu:24.04

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends ca-certificates raku \
    && rm -rf /var/lib/apt/lists/* \
    && useradd --create-home --uid 10001 stakeholder

WORKDIR /app
COPY --from=build --chown=stakeholder:stakeholder /workspace/bin/ bin/
USER stakeholder

ENTRYPOINT ["raku", "bin/stakeholder.raku"]
