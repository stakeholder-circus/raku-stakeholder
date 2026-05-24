RAKU ?= raku
BIN := bin/stakeholder.raku

.PHONY: all compiler-proof syntax-check test clean

all: syntax-check

compiler-proof:
	$(RAKU) --version

syntax-check:
	$(RAKU) -c $(BIN)
	$(RAKU) $(BIN) --list-values >/dev/null

test: syntax-check
	RAKU=$(RAKU) BIN=$(BIN) tests/test_cli.sh

clean:
	@true
