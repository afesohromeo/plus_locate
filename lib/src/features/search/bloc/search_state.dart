// lib/src/features/search/bloc/search_state.dart
part of 'search_bloc.dart';

/// Which input UI the Search page should render.
enum SearchMode {
  /// Live Places Autocomplete suggestions (Google Places API).
  autocomplete,

  /// Plain text field with a search button — free, device-native
  /// geocoding/Plus Code decode, used once the monthly autocomplete
  /// quota is exhausted.
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
  }) = _SearchState;

  /// Best-available latitude for the current result (location result first,
  /// falling back to the Plus Code's decoded center).
  double? get latitude => locationResult?.latitude ?? plusCode?.latitude;

  /// Best-available longitude for the current result.
  double? get longitude => locationResult?.longitude ?? plusCode?.longitude;
}