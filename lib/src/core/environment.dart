/// Environment configuration loaded from `--dart-define` build args.
///
/// Usage:
/// ```bash
/// flutter run --dart-define=GOOGLE_MAPS_API_KEY=YOUR_KEY
/// ```
class Environment {
  static const String environment =
      String.fromEnvironment('env', defaultValue: 'dev');

  /// Google Maps API key — injected at build time. Never hardcode.
  static const String googleMapsApiKey =
      String.fromEnvironment('GOOGLE_MAPS_API_KEY', defaultValue: '');

  /// Google Geocoding API key — defaults to Maps key if not set separately.
  static const String geocodingApiKey = String.fromEnvironment(
    'GEOCODING_API_KEY',
    defaultValue: googleMapsApiKey,
  );

  /// Places API (New) key — defaults to Maps key if not set separately.
  /// Restrict this key to "Places API (New)" in the Google Cloud Console.
  static const String placesApiKey = String.fromEnvironment(
    'PLACES_API_KEY',
    defaultValue: googleMapsApiKey,
  );

  /// Base URL for the Plus Codes API.
  static const String plusCodeApiBaseUrl = String.fromEnvironment(
    'PLUS_CODE_API_BASE_URL',
    defaultValue: 'https://plus.codes/api',
  );

  static bool get isProduction => environment == 'prod';
  static bool get isDevelopment => environment == 'dev';
}