library;

import 'dart:js_interop';
import 'src/http/types.dart';

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

typedef Handler = Future<JSResponse> Function(JSRequest);

/// A class that handles requests from Cloudflare Workers.
///
/// Usage:
///
/// ```dart
/// import 'package:http/http.dart';
/// import 'package:cf_workers/cf_workers.dart';
///
/// Future<void> main() {
///   return Workers((JSRequest request) async {
///     return Response('Hello, World!', 200).toJS;
///   }).serve();
/// }
/// ```
class Workers {
  final Handler handler;

  Workers(this.handler);

  Future<void> serve() async {
    response((await handler(request())));
  }
}
