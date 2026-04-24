import 'package:dio/dio.dart';

import 'package:plus_locate/src/data/api/config/api_error_handler.dart';
import 'package:plus_locate/src/core/environment.dart';

/// API provider for Google Geocoding operations.
///
/// Uses a separate Dio instance pointed at the Google Geocoding API.
class GeocodingApiProvider {
  late final Dio _dio;

  GeocodingApiProvider() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'https://maps.googleapis.com/maps/api/geocode',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
        },
      ),
    );
  }

  /// Forward geocode: address text → coordinates.
  Future<Map<String, dynamic>> geocodeAddress({
    required String address,
  }) async {
    try {
      final response = await _dio.get(
        '/json',
        queryParameters: {
          'address': address,
          'key': Environment.geocodingApiKey,
        }..removeWhere((key, value) => value == null),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }

  /// Reverse geocode: coordinates → address.
  Future<Map<String, dynamic>> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final response = await _dio.get(
        '/json',
        queryParameters: {
          'latlng': '$latitude,$longitude',
          'key': Environment.geocodingApiKey,
        }..removeWhere((key, value) => value == null),
      );
      return response.data as Map<String, dynamic>;
    } on DioException catch (e) {
      throw ApiErrorHandler.handle(e);
    }
  }
}
