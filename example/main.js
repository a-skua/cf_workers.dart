import { instantiate, invoke } from "./workers.mjs";
import dartModule from "./workers.wasm";

const dartInstance = await instantiate(dartModule);
invoke(dartInstance);

export default { fetch: __dart_fetch };
