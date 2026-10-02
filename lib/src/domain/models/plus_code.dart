import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:plus_locate/plus_locate.dart';

part 'plus_code.freezed.dart';

/// Represents a Google Plus Code with its associated location data.
@freezed
sealed class PlusCode with _$PlusCode {
  const PlusCode._();

  const factory PlusCode({
    /// The full (global) Plus Code, e.g. "8FVC9G8F+6W"
    String? globalCode,

    /// The short (local) Plus Code relative to a locality, e.g. "9G8F+6W Zurich"
    String? localCode,

    /// Latitude of the Plus Code center
    double? latitude,

    /// Longitude of the Plus Code center
    double? longitude,

    /// Locality name associated with the short code
    String? locality,
  }) = _PlusCode;

  /// Whether this Plus Code has valid coordinate data.
  bool get hasCoordinates => latitude != null && longitude != null;

  /// Whether a global code is available.
  bool get hasGlobalCode => globalCode != null && globalCode!.isNotEmpty;

  /// Manual fromJson — per standards, no json_serializable auto-generation.
  factory PlusCode.fromJson(Map<String, dynamic> json) {
    return PlusCode(
      globalCode: json['global_code']?.toString(),
      localCode: json['local_code']?.toString(),
      latitude: convertToDouble(json['latitude']),
      longitude: convertToDouble(json['longitude']),
      locality: json['locality']?.toString(),
    );
  }

  /// Payload for encoding coordinates → Plus Code.
  static Map<String, dynamic> encodePayload({
    required double latitude,
    required double longitude,
  }) {
    return {
      'lat': latitude,
      'lng': longitude,
    };
  }

  /// Payload for decoding Plus Code → coordinates.
  static Map<String, dynamic> decodePayload({
    required String plusCode,
  }) {
    return {
      'code': plusCode,
    };
  }

  static Map<String, dynamic> toJson(PlusCode item) {
    return {
      'global_code': item.globalCode,
      'local_code': item.localCode,
      'latitude': item.latitude,
      'longitude': item.longitude,
      'locality': item.locality,
    }..removeWhere((key, value) => value == null);
  }
}
