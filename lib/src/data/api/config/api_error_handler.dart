import 'package:dio/dio.dart';
import 'package:plus_locate/src/domain/models/app_exception.dart';

/// Converts [DioException] into typed [AppException] instances.
///
/// Per RULE-015: API providers catch only DioException and re-throw
/// via this handler.
class ApiErrorHandler {
  ApiErrorHandler._();

  static AppException handle(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppException.timeout();

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode ?? 0;
        final message =
            error.response?.data?['error']?.toString() ??
            error.response?.statusMessage ??
            'Unknown error';

        if (statusCode >= 400 && statusCode < 500) {
          return AppException.badRequest(
            message: message,
            statusCode: statusCode,
          );
        }
        if (statusCode >= 500) {
          return AppException.server(
            message: message,
            statusCode: statusCode,
          );
        }
        return AppException.unknown(message: message);

      case DioExceptionType.connectionError:
        return const AppException.noConnection();

      case DioExceptionType.cancel:
        return const AppException.cancelled();

      default:
        return AppException.unknown(
          message: error.message ?? 'An unexpected error occurred',
        );
    }
  }
}
