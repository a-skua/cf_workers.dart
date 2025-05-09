import 'package:poor_web/poor_web.dart';
export 'package:poor_web/poor_web.dart';

typedef Env = Object;
typedef Context = Object;

typedef Handler = Future<Response> Function(Request, Env env, Context context);

/// [fetch]
///
/// ```dart
/// void main() => fetch((Request r) async => Response('Hello, world!'.toJS));
void fetch(Handler fetch, {String property = '__dart_fetch'}) {
  JSPromise<Response> handle(Request r, JSObject e, JSObject c) {
    return fetch(r, Env.fromJS(e), Context.fromJS(c)).toJS;
  }

  globalThis[property] = Object.fromJS(handle.toJS);
}
