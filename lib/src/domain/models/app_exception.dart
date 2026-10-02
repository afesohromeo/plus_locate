/// Typed exception hierarchy for the app.
///
/// Replaces the enterprise HttpException400/SpecialCase410 pattern
/// with a clean sealed class approach.
sealed class AppException implements Exception {
  final String message;

  const AppException({required this.message});

  const factory AppException.badRequest({
    required String message,
    int statusCode,
  }) = BadRequestException;

  const factory AppException.server({
    required String message,
    int statusCode,
  }) = ServerException;

  const factory AppException.timeout() = TimeoutException;

  const factory AppException.noConnection() = NoConnectionException;

  const factory AppException.cancelled() = CancelledException;

  /// The service refused this app/project (missing or invalid key, billing
  /// disabled, API not enabled). Retrying won't help.
  const factory AppException.accessDenied({required String message}) =
      AccessDeniedException;

  const factory AppException.unknown({required String message}) =
      UnknownException;

  @override
  String toString() => message;
}

class BadRequestException extends AppException {
  final int statusCode;

  const BadRequestException({
    required super.message,
    this.statusCode = 400,
  });
}

class ServerException extends AppException {
  final int statusCode;

  const ServerException({
    required super.message,
    this.statusCode = 500,
  });
}

class TimeoutException extends AppException {
  const TimeoutException() : super(message: 'Connection timed out');
}

class NoConnectionException extends AppException {
  const NoConnectionException() : super(message: 'No internet connection');
}

class CancelledException extends AppException {
  const CancelledException() : super(message: 'Request was cancelled');
}

class AccessDeniedException extends AppException {
  const AccessDeniedException({required super.message});
}

class UnknownException extends AppException {
  const UnknownException({required super.message});
}
