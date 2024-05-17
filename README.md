# Cloudflare Workers.dart

## Usage

```dart
import 'package:http/http.dart';
import 'package:cf_workers/cf_workers.dart';

Future<void> main() {
  return Workers((Request request) async {
    return Response("Hello, World!", 200);
  }).serve();
}
```

```sh
dart compile wasm bin/api.dart -p __dart/api.wasm
```

```js
import { instantiate, invoke } from "./__dart/api.mjs";
import dartModule from "./__dart/api.wasm";

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
    return response;
  },
};
```

```sh
npx wrangler dev
```
