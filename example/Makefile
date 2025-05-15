WASM := example/assets.wasm example/simple.wasm

.PHONY: serve
serve:
	@$(MAKE) -C .. $(WASM)
	npx wrangler dev
