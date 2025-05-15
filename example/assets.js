import { instantiate, invoke } from "./assets.mjs";
import dartModule from "./assets.wasm";

const dartInstance = await instantiate(dartModule);
invoke(dartInstance);

export default __fetcher;
