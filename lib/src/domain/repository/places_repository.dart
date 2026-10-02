import 'dart:developer';
import 'dart:math' show Random;

import 'package:dio/dio.dart';
import 'package:plus_locate/src/data/api/places/places_api_provider.dart';
import 'package:plus_locate/src/domain/models/app_exception.dart';
import 'package:plus_locate/src/domain/models/location_result.dart';
import 'package:plus_locate/src/domain/models/place_suggestion.dart';

/// Repository for Google Places Autocomplete (New) + place details.
///
/// Owns the autocomplete session token: it is created on the first
/// autocomplete request and ended by [placeDetails] (or [endSession]).
///
/// Per RULE-012: always log + rethrow, never swallow exceptions.
class PlacesRepository {
  final PlacesApiProvider _apiProvider;
  final Random _random = Random.secure();
  String? _sessionToken;

  PlacesRepository({PlacesApiProvider? apiProvider})
      : _apiProvider = apiProvider ?? PlacesApiProvider();

  /// Suggestions for [input].
  Future<List<PlaceSuggestion>> autocomplete({
    required String input,
    String? languageCode,
  }) async {
    try {
      final res = await _apiProvider.autocomplete(
        input: input,
        sessionToken: _sessionToken ??= _newSessionToken(),
        languageCode: languageCode,
      );
      final suggestions = res['suggestions'] as List<dynamic>? ?? const [];
      return suggestions
          .whereType<Map<String, dynamic>>()
          .map((s) => s['placePrediction'])
          .whereType<Map<String, dynamic>>()
          .map(PlaceSuggestion.fromJson)
          .where((s) => s.placeId.isNotEmpty)
          .toList();
    } catch (e, stack) {
      log('Error fetching place suggestions: $e');
      _rethrowAsAccessDenied(e, stack);
    }
  }

  /// Details (address + coordinates) for [placeId]. Ends the current session.
  Future<LocationResult?> placeDetails({
    required String placeId,
    String? languageCode,
  }) async {
    try {
      final res = await _apiProvider.placeDetails(
        placeId: placeId,
        sessionToken: _sessionToken ?? _newSessionToken(),
        languageCode: languageCode,
      );
      final result = LocationResult.fromPlaceDetails(res);
      return result.hasCoordinates ? result : null;
    } catch (e, stack) {
      log('Error fetching place details: $e');
      _rethrowAsAccessDenied(e, stack);
    } finally {
      endSession();
    }
  }

  /// Rethrows [error], as an [AccessDeniedException] when Google refused the
  /// project itself: no key, invalid key, or any 403 (billing disabled, API
  /// not enabled, key restricted). Timeouts and server errors pass through
  /// unchanged because a retry may succeed.
  Never _rethrowAsAccessDenied(Object error, StackTrace stack) {
    if (error is StateError) {
      throw AccessDeniedException(message: error.message);
    }
    if (error is DioException) {
      final status = error.response?.statusCode;
      final isInvalidKey = status == 400 &&
          error.response.toString().contains('API_KEY_INVALID');
      if (status == 403 || isInvalidKey) {
        throw AccessDeniedException(
          message: 'Places API refused the request (HTTP $status)',
        );
      }
    }
    Error.throwWithStackTrace(error, stack);
  }

  /// Drops the current session so the next autocomplete starts a new one.
  void endSession() => _sessionToken = null;

  /// Random UUID v4.
  String _newSessionToken() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    bytes[6] = (bytes[6] & 0x0f) | 0x40;
    bytes[8] = (bytes[8] & 0x3f) | 0x80;
    final hex = bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
    return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-'
        '${hex.substring(12, 16)}-${hex.substring(16, 20)}-${hex.substring(20)}';
  }
}
