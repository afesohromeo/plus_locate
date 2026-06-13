// lib/src/features/search/bloc/search_event.dart
part of 'search_bloc.dart';

@freezed
class SearchEvent with _$SearchEvent {
  /// Checks the local autocomplete quota and sets the initial [SearchMode].
  const factory SearchEvent.init() = _Init;

  /// A suggestion was picked from the Places Autocomplete list.
  const factory SearchEvent.placeSelected({
    required String description,
    required double latitude,
    required double longitude,
  }) = _PlaceSelected;

  /// The user submitted a free-text query (address or Plus Code) in
  /// search-on-submit mode.
  const factory SearchEvent.submitQuery({required String query}) =
      _SubmitQuery;

  /// Clears the current result.
  const factory SearchEvent.reset() = _Reset;
}