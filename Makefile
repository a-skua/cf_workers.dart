SRC := $(shell find lib -name '*.dart')

.PHONY: all
all: example/__dart/example.wasm doc/api/index.html

.PHONY: clean
clean:
	rm -rf example/__dart

.PHONY: doc
doc: doc/api/index.html
	python3 -m http.server -d doc/api

example/__dart/%.wasm: example/%.dart $(SRC)
	dart compile wasm $< -o $@

doc/api/index.html: $(SRC) README.md
	dart doc

