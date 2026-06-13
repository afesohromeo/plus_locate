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
      'latitude': area.center.latitude,
      'longitude': area.center.longitude,
    };
  }

  /// Whether [code] is a syntactically valid Plus Code.
  ///
  /// Non-throwing — unlike `.decode()`, `.isValid` returns false for
  /// malformed or short codes instead of throwing [ArgumentError].
  bool isValidPlusCode(String code) {
    return olc.PlusCode.unverified(code).isValid;
  }
}
