import 'dart:js_interop';
import 'package:poor_web/js.dart';
import 'package:cf_workers/cf_workers.dart';

main() => fetch(_handler, property: '__fetcher');

extension on Env {
  @JS('ASSETS')
  external Fetcher get assets;
}

Future<Response> _handler(Request request, Env env, Context ctx) async {
  final uri = Uri.parse(request.url);

  if (uri.path.startsWith('/greet/')) {
    final name = uri.path.substring(7);
    return Response(String('Hello, $name!'));
  }

    return env.assets.fetch(request, env, ctx).toDart;
}
