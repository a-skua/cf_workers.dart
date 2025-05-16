import 'dart:js_interop';
import 'package:poor_web/js.dart';
import 'package:cf_workers/cf_workers.dart';

@JS('__dart_fetch')
external set fetcher(Fetcher _);

main() => fetcher = Fetcher(_handler);

Future<Response> _handler(Request request, Env env, Context ctx) async =>
    Response(String('Hello, Dart!'));
