library;

import 'dart:js_interop';
import 'package:http/http.dart';
import 'src/http.dart';

typedef Handler = Future<Response> Function(Request);

/// A function that returns a Request object in JavaScript.
///
/// Usage:
/// ```js
/// globalThis.__dart_cf_workers = {
///   request: () => request,
///   response: (r) => response = r,
/// };
/// ```
@JS('__dart_cf_workers.request')
external JSRequest request();

/// A function that sets a Response object in JavaScript.
///
/// Usage:
/// ```js
/// globalThis.__dart_cf_workers = {
///   request: () => request,
///   response: (r) => response = r,
/// };
/// ```
@JS('__dart_cf_workers.response')
external void response(JSResponse response);

/// A class that handles requests from Cloudflare Workers.
///
/// Usage:
///
/// ```dart
/// import 'package:http/http.dart';
/// import 'package:cf_workers/workers.dart';
///
/// Future<void> main() {
///   return Workers((Request request) async {
///     return Response('Hello, World!', 200);
///   }).serve();
/// }
/// ```
class Workers {
  final Handler handler;

  Workers(this.handler);

  Future<void> serve() async {
    response((await handler(await request().toDart)).toJS);
  }
}
