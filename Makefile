SRC := $(shell find lib -name '*.dart')

.PHONY: example
example: example/workers.wasm

.PHONY: clean
clean:
	@rm -f example/*.wasm example/*.mjs example/*.map

.PHONY: fmt
fmt:
	@dart format .

.PHONY: doc
doc: doc/api/index.html
	python3 -m http.server -d doc/api

%.wasm: %.dart $(SRC)
	@dart compile wasm $< -o $@

doc/api/index.html: $(SRC) README.md
	dart doc

