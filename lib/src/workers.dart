import 'dart:js_interop';
import 'dart:core' as core;
import 'package:web/web.dart' as web;
import 'package:poor_web/poor_web.dart';

/// Cloudflare Workers API
extension type Fetcher._(Object _assets) implements Object {
  /// Fetcher
  ///
  /// ```dart
  /// @JS('__dart_fetch')
  /// external set fetcher(Fetcher _);
  ///
  /// main() => fetcher = Fetcher(_handler);
  ///
  /// Future<Response> _handler(Request request, Env env, Context ctx) async =>
  ///     Response(String('Hello, Dart!'));
  /// ```
  factory Fetcher(Handler fetch) => Fetcher._(Object())
    ..['fetch'] = Fn.a3((_Request request, Env env, Context ctx) =>
        Promise(fetch(request, env, ctx)));

  @JS()
  external Promise<Response> fetch(Request _, Env __, Context ___);
}

typedef Request = web.Request;
typedef RequestInit = web.RequestInit;

/// [Request]'s internal type
extension type _Request._(Object _request) implements Object, Request {}

typedef Response = web.Response;
typedef ResponseInit = web.ResponseInit;

extension type Env._(Object _env) implements Object {}
extension type Context._(Object _context) implements Object {}
typedef Handler = core.Future<Response> Function(Request, Env, Context);

/// [fetch]
///
/// ```dart
/// void main() => fetch((Request request, Env env, Context ctx) async {
///   return Response(String('Hello, Dart!'));
/// });
/// ```
void fetch(Handler fetch, {core.String property = '__dart_fetch'}) =>
    (globalThis as Object)[property] = Object()
      ..['fetch'] = Fn.a3((_Request request, Env env, Context ctx) =>
          Promise(fetch(request, env, ctx)));
