import { instantiate, invoke } from "./__dart/example.mjs";
import dartModule from "./__dart/example.wasm";
import { exec } from "../web/exec.mjs";

export default {
  async fetch(request, _env, _ctx) {
    const dartInstance = await instantiate(dartModule);
    return exec(() => invoke(dartInstance), request);
  },
};
