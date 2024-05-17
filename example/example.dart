import 'package:http/http.dart';
import 'package:cf_workers/cf_workers.dart';

Future<void> main() {
  return Workers((Request request) async {
    print(request);
    return Response("Hello, World!", 200);
  }).serve();
}
