# Cloudflare Workers.dart

## Usage

```dart
import 'package:http/http.dart';
import 'package:cf_workers/cf_workers.dart';

Future<void> main() {
  return Workers((JSRequest request) async {
    return Response("Hello, World!", 200).toJS;
  }).serve();
}
```

```sh
dart compile wasm bin/api.dart -p __dart/api.wasm
```

```js
import { instantiate, invoke } from "./__dart/api.mjs";
import dartModule from "./__dart/api.wasm";
import { exec } from "./web/exec.mjs";

export default {
  async fetch(request, _env, _ctx) {
    const dartInstance = await instantiate(dartModule);
    return exec(() => invoke(dartInstance), request);
  },
};
```

```sh
npx wrangler dev
```
