import 'dart:developer';

import 'package:plus_locate/src/data/api/geocoding/geocoding_api_provider.dart';
import 'package:plus_locate/src/domain/models/location_result.dart';

/// Repository for geocoding operations (address ↔ coordinates).
///
/// Per RULE-012: always log + rethrow, never swallow exceptions.
class GeocodingRepository {
  final GeocodingApiProvider _apiProvider;

  GeocodingRepository({GeocodingApiProvider? apiProvider})
      : _apiProvider = apiProvider ?? GeocodingApiProvider();

  /// Forward geocode: address text → LocationResult.
  Future<LocationResult?> geocodeAddress({
    required String address,
  }) async {
    try {
      final res = await _apiProvider.geocodeAddress(address: address);
      final results = res['results'] as List<dynamic>?;
      if (results != null && results.isNotEmpty) {
        return LocationResult.fromJson(
          results.first as Map<String, dynamic>,
        );
      }
      return null;
    } catch (e) {
      log('Error geocoding address: $e');
      rethrow;
    }
  }

  /// Reverse geocode: coordinates → LocationResult.
  Future<LocationResult?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final res = await _apiProvider.reverseGeocode(
        latitude: latitude,
        longitude: longitude,
      );
      final results = res['results'] as List<dynamic>?;
      if (results != null && results.isNotEmpty) {
        log('resss $res');
        return LocationResult.fromJson(
          results.first as Map<String, dynamic>,
        );
      }
      return null;
    } catch (e) {
      log('Error reverse geocoding: $e');
      rethrow;
    }
  }
}
