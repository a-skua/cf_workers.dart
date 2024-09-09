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
