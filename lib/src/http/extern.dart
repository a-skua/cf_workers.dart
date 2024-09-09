import 'dart:js_interop';
import './types.dart';

@JS('fetch')
external JSPromise<JSResponse> _fetch(JSRequest request);

/// Web API: https://developer.mozilla.org/en-US/docs/Web/API/Window/fetch
Future<JSResponse> fetch(JSRequest request) => _fetch(request).toDart;
