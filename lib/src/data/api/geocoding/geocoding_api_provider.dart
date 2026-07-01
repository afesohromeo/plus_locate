import 'dart:async';

import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';

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
    final placemark = await _safePlacemark(loc.latitude, loc.longitude);

    return {
      'results': [
        {
          'formatted_address': address,
          'latitude': loc.latitude,
          'longitude': loc.longitude,
          'locality': placemark?.locality,
          'country': placemark?.country,
        }
      ]
    };
  }

  /// Reverse geocode: coordinates → address info.
  Future<Map<String, dynamic>> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    final placemark = await _safePlacemark(latitude, longitude);
    if (placemark == null) return {'results': []};

    final formattedAddress = [
      placemark.street,
      placemark.locality,
      placemark.administrativeArea,
      placemark.country,
    ].where((p) => p != null && p.isNotEmpty).join(', ');

    return {
      'results': [
        {
          'formatted_address':
              formattedAddress.isNotEmpty ? formattedAddress : null,
          'latitude': latitude,
          'longitude': longitude,
          'locality': placemark.locality,
          'country': placemark.country,
        }
      ]
    };
  }

  /// Wraps [placemarkFromCoordinates] with a timeout and absorbs the
  /// Android Play Services IO_ERROR that occurs when the native Geocoder
  /// times out. Returns null on any platform/timeout failure so callers
  /// can degrade gracefully instead of propagating a non-actionable error.
  Future<Placemark?> _safePlacemark(double lat, double lng) async {
    try {
      final marks = await placemarkFromCoordinates(lat, lng).timeout(_kTimeout);
      return marks.isNotEmpty ? marks.first : null;
    } on TimeoutException {
      return null;
    } on PlatformException catch (e) {
      if (e.code == 'IO_ERROR') return null;
      rethrow;
    }
  }
}
