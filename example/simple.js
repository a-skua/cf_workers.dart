import { instantiate, invoke } from "./simple.mjs";
import dartModule from "./simple.wasm";

const dartInstance = await instantiate(dartModule);
invoke(dartInstance);

export default __dart_fetch;
