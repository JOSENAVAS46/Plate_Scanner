import 'dart:convert';

import 'package:http/http.dart';

enum HttpMethod { get, post }

typedef Parser<T> = T Function(dynamic data);

class HttpNetworkSettings {
  Future<HttpResult<T>> startSettings<T>(String server, String path,
      {HttpMethod method = HttpMethod.get,
      Map<String, String> headers = const {},
      Map<String, String> queryParameters = const {},
      dynamic body,
      Parser<T>? parser,
      Duration timeOut = const Duration(seconds: 30)}) async {
    int? statusCode;
    dynamic data;
    try {
      final url = Uri.parse('$server/$path');
      print('<============ URL ============>');
      print(url);

      final response = await senRequest(
          url: url,
          body: body,
          headers: headers,
          method: method,
          timeOut: timeOut);

      data = response.body;
      statusCode = response.statusCode;
      print('<============ STATUS CODE ============>');
      print(statusCode);
      print('<============ HEADERS ============>');
      print(response.headers);
      print('<============ RESPUESTA SERVIDOR ============>');
      print(jsonEncode(data));
      if (statusCode >= 400) {
        throw HttpError(
            exeception: null, stackTrace: StackTrace.current, data: data);
      }
      return HttpResult<T>(
          data: parser != null ? parser(data) : data,
          statusCode: statusCode,
          error: null);
    } catch (e, s) {
      if (e is HttpError) {
        return HttpResult<T>(
          data: null,
          statusCode: statusCode!,
          error: e,
        );
      }
      return HttpResult<T>(
        data: null,
        statusCode: -1,
        error: HttpError(
          data: data,
          stackTrace: s,
          exeception: e,
        ),
      );
    }
  }
}

dynamic _parseBody(dynamic body) {
  try {
    return jsonEncode(body);
  } catch (e) {
    return body;
  }
}

Future<Response> senRequest({
  required Uri url,
  required HttpMethod method,
  required Map<String, String> headers,
  required dynamic body,
  required Duration timeOut,
}) async {
  var finalHeaders = {
    ...headers,
    // 'Authorization': 'Bearer $token',
  };
  if (method != HttpMethod.get) {
    final conteType = headers['Content-Type'];
    if (conteType == null || conteType.contains('application/json')) {
      finalHeaders['Content-Type'] = "application/json; charset=UTF-8";
      body = _parseBody(body);
    }
  }
  final client = Client();
  switch (method) {
    case HttpMethod.get:
      return client
          .get(
            url,
            headers: finalHeaders,
          )
          .timeout(timeOut);
    case HttpMethod.post:
      return client
          .post(
            url,
            headers: finalHeaders,
            body: body,
          )
          .timeout(timeOut);
  }
}

class HttpResult<T> {
  final T? data;
  final int statusCode;
  final HttpError? error;

  HttpResult({
    required this.data,
    required this.statusCode,
    required this.error,
  });
}

class HttpError {
  final Object? exeception;
  final StackTrace stackTrace;
  final dynamic data;

  HttpError({
    required this.exeception,
    required this.stackTrace,
    required this.data,
  });
}
