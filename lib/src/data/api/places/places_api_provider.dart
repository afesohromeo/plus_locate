import 'package:dio/dio.dart';
import 'package:plus_locate/src/core/environment.dart';

/// Google Places API (New) provider.
///
/// Calls `places.googleapis.com/v1` directly. Autocomplete requests and the
/// place details request that ends them share a session token, which Google
/// bills as a single session instead of per keystroke.
class PlacesApiProvider {
  static const _baseUrl = 'https://places.googleapis.com/v1/';
  static const _detailsFieldMask =
      'id,formattedAddress,location,addressComponents,displayName';

  final Dio _dio;
  final String _apiKey;

  PlacesApiProvider({Dio? dio, String? apiKey})
      : _apiKey = apiKey ?? Environment.placesApiKey,
        _dio = dio ??
            Dio(
              BaseOptions(
                baseUrl: _baseUrl,
                connectTimeout: const Duration(seconds: 10),
                receiveTimeout: const Duration(seconds: 10),
              ),
            );

  Map<String, String> get _authHeaders => {'X-Goog-Api-Key': _apiKey};

  /// Raw autocomplete response: `{ "suggestions": [ { "placePrediction": … } ] }`.
  Future<Map<String, dynamic>> autocomplete({
    required String input,
    required String sessionToken,
    String? languageCode,
  }) async {
    _ensureApiKey();
    final response = await _dio.post<Map<String, dynamic>>(
      'places:autocomplete',
      data: {
        'input': input,
        'sessionToken': sessionToken,
        if (languageCode != null) 'languageCode': languageCode,
      },
      options: Options(headers: _authHeaders),
    );
    return response.data ?? const {};
  }

  /// Raw place details response for [placeId].
  Future<Map<String, dynamic>> placeDetails({
    required String placeId,
    required String sessionToken,
    String? languageCode,
  }) async {
    _ensureApiKey();
    final response = await _dio.get<Map<String, dynamic>>(
      'places/$placeId',
      queryParameters: {
        'sessionToken': sessionToken,
        if (languageCode != null) 'languageCode': languageCode,
      },
      options: Options(
        headers: {..._authHeaders, 'X-Goog-FieldMask': _detailsFieldMask},
      ),
    );
    return response.data ?? const {};
  }

  void _ensureApiKey() {
    if (_apiKey.isEmpty) {
      throw StateError(
        'Places API key is empty. Pass --dart-define=GOOGLE_MAPS_API_KEY=… '
        '(or PLACES_API_KEY) when running the app.',
      );
    }
  }
}
