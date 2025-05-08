import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'package:poor_web/poor_web.dart';

export 'package:poor_web/poor_web.dart';

typedef Handler = Future<Response> Function(Request);

/// [fetch]
///
/// ```dart
/// void main() => fetch((Request r) async => Response('Hello, world!'.toJS));
void fetch(Handler fetch, {String property = '__dart_fetch'}) => globalContext
    .setProperty(property.toJS, ((Request r) => fetch(r).toJS).toJS);
