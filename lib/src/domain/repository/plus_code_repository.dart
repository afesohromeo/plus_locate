import 'dart:developer';

import 'package:plus_locate/src/data/api/plus_code/plus_code_api_provider.dart';
import 'package:plus_locate/src/domain/models/plus_code.dart';

/// Repository for Plus Code encode/decode operations.
///
/// Per RULE-012: always log + rethrow, never swallow exceptions.
/// Per RULE-014: error messages from LocalizationService only.
class PlusCodeRepository {
  final PlusCodeApiProvider _apiProvider;

  PlusCodeRepository({PlusCodeApiProvider? apiProvider})
      : _apiProvider = apiProvider ?? PlusCodeApiProvider();

  /// Encode coordinates → Plus Code.
  Future<PlusCode?> encodePlusCode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final res = await _apiProvider.encodePlusCode(
        latitude: latitude,
        longitude: longitude,
      );
      log('mdss $res');
      return PlusCode.fromJson(res);
    } catch (e) {
      log('Error encoding Plus Code: $e');
      rethrow;
    }
  }

  /// Decode Plus Code → coordinates.
  Future<PlusCode?> decodePlusCode({
    required String code,
  }) async {
    try {
      final res = await _apiProvider.decodePlusCode(code: code);
      return PlusCode.fromJson(res);
    } catch (e) {
      log('Error decoding Plus Code: $e');
      rethrow;
    }
  }

  /// Whether [code] is a syntactically valid Plus Code (no network call).
  bool isValidPlusCode(String code) {
    return _apiProvider.isValidPlusCode(code);
  }

  /// Whether [code] is a valid full (global) Plus Code.
  bool isFullPlusCode(String code) => _apiProvider.isFullPlusCode(code);

  /// Whether [code] is a valid short Plus Code (needs a reference location).
  bool isShortPlusCode(String code) => _apiProvider.isShortPlusCode(code);

  /// Recover the full Plus Code for [shortCode] near the reference point,
  /// then decode it.
  Future<PlusCode?> recoverShortPlusCode({
    required String shortCode,
    required double referenceLatitude,
    required double referenceLongitude,
  }) async {
    try {
      final fullCode = _apiProvider.recoverNearest(
        shortCode: shortCode,
        referenceLatitude: referenceLatitude,
        referenceLongitude: referenceLongitude,
      );
      return await decodePlusCode(code: fullCode);
    } catch (e) {
      log('Error recovering short Plus Code: $e');
      rethrow;
    }
  }
}
