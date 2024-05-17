import { instantiate, invoke } from "./__dart/example.mjs";
import dartModule from "./__dart/example.wasm";

export default {
  async fetch(request, _env, _ctx) {
    const dartInstance = await instantiate(
      dartModule,
    );

    let response;
    globalThis.__dart_cf_workers = {
      request: () => request,
      response: (r) => response = r,
    };
    await invoke(dartInstance);
    console.log(response);
    return response;
  },
};
