import 'package:dio/dio.dart';
import 'package:plus_locate/src/core/environment.dart';

import 'dio_interceptor.dart';

/// Singleton Dio instance provider for all API calls.
class ApiProvider {
  ApiProvider._internal();

  static final ApiProvider _instance = ApiProvider._internal();

  factory ApiProvider() => _instance;

  Dio? _dio;

  /// Lazily initialized Dio instance with interceptors configured.
  Dio get dio {
    _dio ??= _createDio();
    return _dio!;
  }

  Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.plusCodeApiBaseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dio.interceptors.add(AppDioInterceptor());

    return dio;
  }
}
