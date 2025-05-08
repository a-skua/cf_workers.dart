import 'dart:js_interop';
import 'package:cf_workers/workers.dart';

main() => fetch((Request request) async => Response('Hello, Dart!'.toJS));
