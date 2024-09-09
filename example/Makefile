.PHONY: serve
serve: __dart/example.wasm
	deno task dev

__dart/example.wasm: example.dart
	$(MAKE) -C ..
