import 'package:geocoding/geocoding.dart';

/// Local geocoding provider using the geocoding package.
/// Uses device-native reverse geocoding — no API key required.
class GeocodingApiProvider {
  /// Forward geocode: address text → coordinates + location info.
  Future<Map<String, dynamic>> geocodeAddress({
    required String address,
  }) async {
    final locations = await locationFromAddress(address);
    if (locations.isEmpty) return {'results': []};

    final loc = locations.first;
    final placemarks =
        await placemarkFromCoordinates(loc.latitude, loc.longitude);
    final placemark = placemarks.isNotEmpty ? placemarks.first : null;

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
    final placemarks = await placemarkFromCoordinates(latitude, longitude);
    if (placemarks.isEmpty) return {'results': []};

    final placemark = placemarks.first;
    final formattedAddress = [
      placemark.street,
      placemark.locality,
      placemark.administrativeArea,
      placemark.country,
    ].where((p) => p != null && p.isNotEmpty).join(', ');

    return {
      'results': [
        {
          'formatted_address': formattedAddress.isNotEmpty ? formattedAddress : null,
          'latitude': latitude,
          'longitude': longitude,
          'locality': placemark.locality,
          'country': placemark.country,
        }
      ]
    };
  }
}