import 'dart:js_interop';
import 'dart:js_interop_unsafe';
import 'dart:typed_data';
import 'package:http/http.dart' show Request, Response;

/// [JSRequest] is a Request object in JavaScript.
extension type JSRequest(JSObject object) implements JSObject {}

/// Convert from [JSRequest] to [Request].
///
/// Usage:
///
/// ```dart
/// Future<void> foo(JSRequest jsRequest) async {
///   final request = await jsRequest.toDart;
/// }
/// ```
extension JSRequestToRequest on JSRequest {
  Future<Request> get toDart => () async {
        final request = Request(getProperty<JSString>("method".toJS).toDart,
            Uri.parse(getProperty<JSString>("url".toJS).toDart));
        request.headers
            .addAll(_jsHeadersToHeaders(getProperty("headers".toJS)));

        if (request.method != "GET" && request.method != "HEAD") {
          request.bodyBytes = await _blobToUint8Array(callMethod("blob".toJS));
        }
        return request;
      }();
}

/// Convert from [Request] to [JSRequest].
///
/// Usage:
///
/// ```dart
/// void foo(Request request) {
///   final jsRequest = request.toJS;
/// }
/// ```
extension RequestToJSRequest on Request {
  JSRequest get toJS => globalContext
      .getProperty<JSFunction>("Request".toJS)
      .callAsConstructor<JSRequest>(
        url.toString().toJS,
        _requestToJSRequestOptions(this),
      );
}

/// [JSResponse] is a Response object in JavaScript.
extension type JSResponse(JSObject object) implements JSObject {}

/// Convert from [JSResponse] to [Response].
///
/// Usage:
///
/// ```dart
/// Future<void> foo(JSResponse jsResponse) async {
///   final response = await jsResponse.toDart;
/// }
/// ```
extension JSResponseToResponse on JSResponse {
  Future<Response> get toDart => () async {
        final response = Response.bytes(
          await _blobToUint8Array(callMethod("blob".toJS)),
          getProperty<JSNumber>("status".toJS).toDartInt,
          headers: _jsHeadersToHeaders(getProperty("headers".toJS)),
        );
        return response;
      }();
}

/// Convert from [Response] to [JSResponse].
///
/// Usage:
///
/// ```dart
/// void foo(Response response) {
///   final jsResponse = response.toJS;
/// }
/// ```
extension ResponseToJSResponse on Response {
  JSResponse get toJS => globalContext
      .getProperty<JSFunction>("Response".toJS)
      .callAsConstructor<JSResponse>(
        bodyBytes.toJS,
        _responseToJSResponseOptions(this),
      );
}

/// [_JSHeaders] is a Headers object in JavaScript.
/// See: https://developer.mozilla.org/en-US/docs/Web/API/Headers
typedef _JSHeaders = JSObject;

/// Convert from [Map<String, String>] to [_JSHeaders].
_JSHeaders _headersToJSHeaders(Map<String, String> headers) {
  return globalContext
      .getProperty<JSFunction>("Headers".toJS)
      .callAsConstructor(
        headers.entries
            .map((e) => [e.key.toJS, e.value.toJS].toJS)
            .toList()
            .toJS,
      );
}

/// Convert from [_JSHeaders] to [Map<String, String>].
Map<String, String> _jsHeadersToHeaders(_JSHeaders headers) {
  final result = <String, String>{};
  final keys = globalContext
      .getProperty<JSFunction>("Array".toJS)
      .callMethod<JSArray<JSString>>(
        "from".toJS,
        headers.callMethod<JSObject>("keys".toJS),
      )
      .toDart;
  for (final key in keys) {
    result[key.toDart] = headers.callMethod<JSString>("get".toJS, key).toDart;
  }

  return result;
}

typedef _JSBlob = JSObject;
Future<Uint8List> _blobToUint8Array(JSPromise<_JSBlob> blob) async {
  return globalContext
      .getProperty<JSFunction>("Uint8Array".toJS)
      .callAsConstructor<JSUint8Array>(await (await blob.toDart)
          .callMethod<JSPromise<JSObject>>("arrayBuffer".toJS)
          .toDart)
      .toDart;
}

typedef _JSRequestOptions = JSObject;
_JSRequestOptions _requestToJSRequestOptions(Request request) {
  final options = _JSRequestOptions();
  options.setProperty("method".toJS, request.method.toJS);
  options.setProperty("headers".toJS, _headersToJSHeaders(request.headers));

  if (request.method != "GET" && request.method != "HEAD") {
    options.setProperty("body".toJS, request.bodyBytes.toJS);
  }
  return options;
}

typedef _JSResponseOptions = JSObject;
_JSResponseOptions _responseToJSResponseOptions(Response response) {
  final options = _JSRequestOptions();
  options.setProperty("status".toJS, response.statusCode.toJS);
  options.setProperty("headers".toJS, _headersToJSHeaders(response.headers));
  return options;
}
