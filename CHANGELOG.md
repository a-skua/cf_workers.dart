## 2025.5.16

You can write like this.

```dart
@JS('__dart_fetch')
external set fetcher(Fetcher _);

main() => fetcher = Fetcher(_handler);

Future<Response> _handler(Request request, Env env, Context ctx) async =>
    Response(String('Hello, Dart!'));
```

## 2025.5.15 Braking Change

```dart
// example/simple.dart
import 'package:poor_web/js.dart';
import 'package:cf_workers/cf_workers.dart';

main() => fetch(_handler);

Future<Response> _handler(Request request, Env env, Context ctx) async =>
    Response(String('Hello, Dart!'));
```

```js
// example/simple.js
import { instantiate, invoke } from "./simple.mjs";
import dartModule from "./simple.wasm";

const dartInstance = await instantiate(dartModule);
invoke(dartInstance);

export default __dart_fetch;
```

## 1.0.0-rc.2

Changed Handler IO.

Usage:

```dart
import 'package:http/http.dart';
import 'package:cf_workers/cf_workers.dart';
import 'package:cf_workers/http.dart';

Future<void> main() {
  return Workers((JSRequest request) async {
    return Response("Hello, World!", 200).toJS;
  }).serve();
}
```

## 1.0.0-rc.1

Initial version.

Usage:

```dart
import 'package:http/http.dart';
import 'package:cf_workers/cf_workers.dart';

Future<void> main() {
  return Workers((Request request) async {
    return Response("Hello, World!", 200);
  }).serve();
}
```
