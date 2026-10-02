// lib/src/features/search/bloc/search_event.dart
part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  /// Checks the local autocomplete quota and sets the initial [SearchMode].
  const factory SearchEvent.init() = _Init;

  /// The search text changed. Debounced; fetches Places suggestions in
  /// [SearchMode.autocomplete] unless the text is a Plus Code.
  const factory SearchEvent.queryChanged({required String query}) =
      _QueryChanged;

  /// A suggestion was picked from the autocomplete list.
  const factory SearchEvent.suggestionSelected({
    required PlaceSuggestion suggestion,
  }) = _SuggestionSelected;

  /// The user submitted free text (address, full Plus Code, or short Plus
  /// Code followed by a locality). Works in both modes.
  const factory SearchEvent.submitQuery({required String query}) = _SubmitQuery;

  /// Clears the current result and suggestions.
  const factory SearchEvent.reset() = _Reset;
}
