import 'package:cf_workers/workers.dart';

main() => fetch(_handler, property: '__dart_fetch');

Future<Response> _handler(Request request, Env env, Context context) async {
  final assets = env['ASSETS'];
  print('Assets: $assets');

  return Response(
      String('Hello, Dart!'),
      ResponseInit(
          status: 200,
          statusText: 'OK',
          headers: Object()
            ..['Content-Type'] = String('text/plain')
            ..['X-Worker'] = String('Dart')));
}
