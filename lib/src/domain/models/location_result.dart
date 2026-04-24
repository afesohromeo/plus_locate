import 'package:freezed_annotation/freezed_annotation.dart';

part 'location_result.freezed.dart';

/// Represents a geocoded location result from the Google Geocoding API.
@freezed
sealed class LocationResult with _$LocationResult {
  const LocationResult._();

  const factory LocationResult({
    /// Formatted address string
    String? formattedAddress,

    /// Latitude
    double? latitude,

    /// Longitude
    double? longitude,

    /// Place ID from Google APIs
    String? placeId,

    /// Short locality name (city/town)
    String? locality,

    /// Country name
    String? country,
  }) = _LocationResult;

  /// Whether this result has valid coordinates.
  bool get hasCoordinates => latitude != null && longitude != null;

  /// Manual fromJson — handles Google Geocoding API response shape.
  factory LocationResult.fromJson(Map<String, dynamic> json) {
    final geometry = json['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    // Extract locality and country from address_components if available
    String? locality;
    String? country;
    final components = json['address_components'] as List<dynamic>?;
    if (components != null) {
      for (final component in components) {
        final types = (component['types'] as List<dynamic>?)
                ?.map((e) => e.toString())
                .toList() ??
            [];
        if (types.contains('locality')) {
          locality = component['long_name']?.toString();
        }
        if (types.contains('country')) {
          country = component['long_name']?.toString();
        }
      }
    }

    return LocationResult(
      formattedAddress: json['formatted_address']?.toString(),
      latitude: _parseDouble(location?['lat'] ?? json['latitude']),
      longitude: _parseDouble(location?['lng'] ?? json['longitude']),
      placeId: json['place_id']?.toString(),
      locality: locality ?? json['locality']?.toString(),
      country: country ?? json['country']?.toString(),
    );
  }

  static Map<String, dynamic> toJson(LocationResult item) {
    return {
      'formatted_address': item.formattedAddress,
      'latitude': item.latitude,
      'longitude': item.longitude,
      'place_id': item.placeId,
      'locality': item.locality,
      'country': item.country,
    }..removeWhere((key, value) => value == null);
  }

  static double? _parseDouble(value) {
    if (value == null) return null;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    return double.tryParse(value.toString());
  }
}
