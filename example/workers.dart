import 'package:cf_workers/workers.dart';

main() => fetch(_handler, property: '__dart_fetch');

Future<Response> _handler(Request request, Env env, Context context) async {
  final assets = env['ASSETS'];
  print('Assets: $assets');

  return Response('Hello, Dart!'.toJS);
}
