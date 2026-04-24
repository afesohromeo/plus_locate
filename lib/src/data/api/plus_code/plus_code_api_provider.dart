import 'package:dio/dio.dart';

import 'package:plus_locate/src/data/api/config/api_provider.dart';
import 'package:plus_locate/src/data/api/config/api_error_handler.dart';

/// API provider for Google Plus Codes operations.
///
/// Per RULE-015: catches only DioException, re-throws via ApiErrorHandler.
/// Per RULE-019: no business logic — raw API calls only.
class PlusCodeApiProvider {
  Dio get _dio => ApiProvider().dio;

  /// Encode latitude/longitude → Plus Code.
  Future<Map<String, dynamic>> encodePlusCode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get(
        '',
        queryParameters: {
          'latlng': '$latitude,$longitude',
        }..removeWhere((key, value) => value == null),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// Decode Plus Code → latitude/longitude.
  Future<Map<String, dynamic>> decodePlusCode({
    required String code,
  }) async {
    try {
      final response = await _dio.get(
        '',
        queryParameters: {
          'address': code,
        }..removeWhere((key, value) => value == null),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
