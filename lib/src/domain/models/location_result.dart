import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plus_locate/plus_locate.dart';

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
    // Extract locality and country from address_components if available

    return LocationResult(
      formattedAddress: json['formatted_address']?.toString(),
      latitude: convertToDouble(json['latitude']),
      longitude: convertToDouble(json['longitude']),
      placeId: json['place_id']?.toString(),
      locality: json['locality']?.toString(),
      country: json['country']?.toString(),
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
}
