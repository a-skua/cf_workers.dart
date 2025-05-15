import 'package:poor_web/js.dart';
import 'package:cf_workers/cf_workers.dart';

main() => fetch(_handler);

Future<Response> _handler(Request request, Env env, Context ctx) async =>
    Response(String('Hello, Dart!'));
