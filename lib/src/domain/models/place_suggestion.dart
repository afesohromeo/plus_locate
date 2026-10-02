import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_suggestion.freezed.dart';

/// A single prediction returned by Places Autocomplete (New).
@freezed
sealed class PlaceSuggestion with _$PlaceSuggestion {
  const PlaceSuggestion._();

  const factory PlaceSuggestion({
    /// Place ID used to fetch the place details
    required String placeId,

    /// Full prediction text, e.g. "Douala, Cameroon"
    String? fullText,

    /// Primary line, e.g. "Douala"
    String? mainText,

    /// Secondary line, e.g. "Cameroon"
    String? secondaryText,
  }) = _PlaceSuggestion;

  /// Primary display line.
  String get title => mainText ?? fullText ?? '';

  /// Manual fromJson — maps a `placePrediction` object.
  factory PlaceSuggestion.fromJson(Map<String, dynamic> json) {
    final structured = json['structuredFormat'] as Map<String, dynamic>?;
    return PlaceSuggestion(
      placeId: json['placeId']?.toString() ?? '',
      fullText: (json['text'] as Map<String, dynamic>?)?['text']?.toString(),
      mainText: (structured?['mainText'] as Map<String, dynamic>?)?['text']
          ?.toString(),
      secondaryText:
          (structured?['secondaryText'] as Map<String, dynamic>?)?['text']
              ?.toString(),
    );
  }
}
