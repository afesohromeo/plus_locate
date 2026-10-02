import 'package:open_location_code/open_location_code.dart' as olc;

/// Local Plus Code provider using the open_location_code package.
/// No network calls — encoding/decoding is done entirely on-device.
class PlusCodeApiProvider {
  /// Encode latitude/longitude → Plus Code map.
  Future<Map<String, dynamic>> encodePlusCode({
    required double latitude,
    required double longitude,
  }) async {
    final plusCode = olc.PlusCode.encode(olc.LatLng(latitude, longitude));
    return {
      'global_code': plusCode.toString(),
      'local_code': _localCode(plusCode.toString()),
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// Decode Plus Code → coordinates map.
  Future<Map<String, dynamic>> decodePlusCode({
    required String code,
  }) async {
    final area = olc.PlusCode(code).decode();
    return {
      'global_code': code,
      'local_code': _localCode(code),
      'latitude': area.center.latitude,
      'longitude': area.center.longitude,
    };
  }

  /// Short form as Google Maps shows it ("VGFR+F4" for "6FMHVGFR+F4"),
  /// meant to be read together with a nearby town name. Dropping the first
  /// four characters is recoverable from a reference up to ~30 km away.
  /// Null for padded or already-short codes.
  static String? _localCode(String globalCode) {
    final code = globalCode.toUpperCase();
    if (code.contains('0') || code.indexOf('+') != 8) return null;
    return code.substring(4);
  }

  /// Whether [code] is a syntactically valid Plus Code.
  ///
  /// Non-throwing — unlike `.decode()`, `.isValid` returns false for
  /// malformed or short codes instead of throwing [ArgumentError].
  bool isValidPlusCode(String code) {
    return olc.PlusCode.unverified(code).isValid;
  }

  /// Whether [code] is a valid full (global) Plus Code, e.g. `8FVC9G8F+6W`.
  bool isFullPlusCode(String code) {
    final plusCode = olc.PlusCode.unverified(code);
    return plusCode.isValid && plusCode.isFull();
  }

  /// Whether [code] is a valid short Plus Code, e.g. `9G8F+6W`.
  bool isShortPlusCode(String code) {
    final plusCode = olc.PlusCode.unverified(code);
    return plusCode.isValid && plusCode.isShort();
  }

  /// Full code nearest to the reference point that matches [shortCode].
  String recoverNearest({
    required String shortCode,
    required double referenceLatitude,
    required double referenceLongitude,
  }) {
    return olc.PlusCode(shortCode)
        .recoverNearest(olc.LatLng(referenceLatitude, referenceLongitude))
        .toString();
  }
}
