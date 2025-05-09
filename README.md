# Cloudflare Workers.dart

- [pub.dev](https://pub.dev/packages/cf_workers)
- [Cloudflare Doc](https://developers.cloudflare.com/workers/)

## Usage

```dart
// example/workers.dart
import 'package:cf_workers/workers.dart';

main() => fetch(_handler, property: '__dart_fetch');

Future<Response> _handler(Request request, Env env, Context context) async {
  final assets = env['ASSETS'];
  print('Assets: $assets');

  return Response('Hello, Dart!'.toJS);
}
```

```js
// example/main.js
import { instantiate, invoke } from "./workers.mjs";
import dartModule from "./workers.wasm";

const dartInstance = await instantiate(dartModule);
invoke(dartInstance);

export default { fetch: __dart_fetch };
```
