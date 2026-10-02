// lib/src/features/search/bloc/search_state.dart
part of 'search_bloc.dart';

/// Which input behaviour the Search page uses.
enum SearchMode {
  /// Live Places Autocomplete (New) suggestions while typing.
  autocomplete,

  /// No suggestions — free, device-native geocoding/Plus Code decode on
  /// submit, used once the monthly autocomplete quota is exhausted.
  onSubmit,
}

@freezed
sealed class SearchState with _$SearchState {
  const SearchState._();

  const factory SearchState({
    @Default(GenericStatus.initial) GenericStatus searchStatus,
    @Default(SearchMode.autocomplete) SearchMode searchMode,
    LocationResult? locationResult,
    PlusCode? plusCode,
    String? searchErrorMessage,
    @Default(GenericStatus.initial) GenericStatus suggestionsStatus,
    @Default(<PlaceSuggestion>[]) List<PlaceSuggestion> suggestions,
    String? suggestionsErrorMessage,

    /// Name of the place picked from the suggestions ("Dovv Essos"), used to
    /// pre-fill the label when saving. Null for Plus Code/address searches.
    String? placeName,
  }) = _SearchState;

  /// Best-available latitude for the current result (location result first,
  /// falling back to the Plus Code's decoded center).
  double? get latitude => locationResult?.latitude ?? plusCode?.latitude;

  /// Best-available longitude for the current result.
  double? get longitude => locationResult?.longitude ?? plusCode?.longitude;
}
