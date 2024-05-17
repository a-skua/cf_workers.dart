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
