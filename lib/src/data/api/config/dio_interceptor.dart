import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:plus_locate/src/core/environment.dart';

/// Dio interceptor that injects the API key and logs requests/responses.
class AppDioInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // Inject API key as query parameter for Google APIs
    if (Environment.googleMapsApiKey.isNotEmpty) {
      options.queryParameters['key'] = Environment.googleMapsApiKey;
    }

    log('[API] ${options.method} ${options.uri}');

    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    log('[API] ${response.statusCode} ${response.requestOptions.uri}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    log('[API ERROR] ${err.type} ${err.message} — ${err.requestOptions.uri}');
    handler.next(err);
  }
}
