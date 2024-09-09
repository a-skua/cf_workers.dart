import 'package:http/http.dart';
import 'package:cf_workers/cf_workers.dart';
import 'package:cf_workers/http.dart';

Future<void> main() {
  return Workers((JSRequest request) async {
    print(await request.toDart);

    return fetch(Request('GET', Uri.parse('https://example.com')).toJS);
  }).serve();
}
