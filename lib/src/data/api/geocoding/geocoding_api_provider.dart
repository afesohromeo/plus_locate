import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

import 'address_formatter.dart';

/// Local geocoding provider using the geocoding package.
/// Uses device-native reverse geocoding — no API key required.
class GeocodingApiProvider {
  static const _kTimeout = Duration(seconds: 20);

  /// Forward geocode: address text → coordinates + location info.
  Future<Map<String, dynamic>> geocodeAddress({
    required String address,
  }) async {
    final locations = await locationFromAddress(address).timeout(_kTimeout);
    if (locations.isEmpty) return {'results': []};

    final loc = locations.first;

    // Placemark lookup is best-effort — a Play Services timeout should not
    // block the forward geocode result.
    final formatted = AddressFormatter.format(
      await _safePlacemarks(loc.latitude, loc.longitude),
    );

    return {
      'results': [
        {
          'formatted_address': address,
          'latitude': loc.latitude,
          'longitude': loc.longitude,
          'locality': formatted.locality,
          'country': formatted.country,
        }
      ]
    };
  }

  /// Reverse geocode: coordinates → address info.
  Future<Map<String, dynamic>> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    final placemarks = await _safePlacemarks(latitude, longitude);
    if (placemarks.isEmpty) return {'results': []};

    final formatted = AddressFormatter.format(placemarks);

    return {
      'results': [
        {
          'formatted_address': formatted.address,
          'latitude': latitude,
          'longitude': longitude,
          'locality': formatted.locality,
          'country': formatted.country,
        }
      ]
    };
  }

  /// All candidates for the point, nearest first. Wraps
  /// [placemarkFromCoordinates] with a timeout and absorbs the Android Play
  /// Services IO_ERROR that occurs when the native Geocoder times out.
  /// Returns an empty list on any platform/timeout failure so callers can
  /// degrade gracefully instead of propagating a non-actionable error.
  Future<List<Placemark>> _safePlacemarks(double lat, double lng) async {
    try {
      return await placemarkFromCoordinates(lat, lng).timeout(_kTimeout);
    } on TimeoutException {
      return const [];
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') return const [];
      rethrow;
    }
  }
}
