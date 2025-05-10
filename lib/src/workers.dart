import 'dart:core' as core;
import 'package:poor_web/poor_web.dart';
export 'package:poor_web/poor_web.dart';

typedef Env = Object;
typedef Context = Object;

typedef Handler = core.Future<Response> Function(
    Request, Env env, Context context);

/// [fetch]
///
/// ```dart
/// void main() => fetch((Request r) async => Response('Hello, world!'.toJS));
void fetch(Handler fetch, {core.String property = '__dart_fetch'}) =>
    globalThis[property] =
        Fn.a3((Any r, Env e, Context c) => Promise(fetch(r as Request, e, c)));
