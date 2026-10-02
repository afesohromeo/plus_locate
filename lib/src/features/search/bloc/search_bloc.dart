// lib/src/features/search/bloc/search_bloc.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:plus_locate/src/domain/models/app_exception.dart'
    show AccessDeniedException;
import 'package:plus_locate/src/domain/models/location_result.dart';
import 'package:plus_locate/src/domain/models/place_suggestion.dart';
import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/domain/repository/geocoding_repository.dart';
import 'package:plus_locate/src/domain/repository/places_repository.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';
import 'package:plus_locate/src/domain/repository/search_quota_repository.dart';
import 'package:plus_locate/src/shared/utils/event_transformers.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  static const _suggestionsDebounce = Duration(seconds: 1);
  static const _minAutocompleteLength = 3;

  final PlusCodeRepository _plusCodeRepository;
  final GeocodingRepository _geocodingRepository;
  final SearchQuotaRepository _quotaRepository;
  final PlacesRepository _placesRepository;

  /// Latest text the user typed. Suggestion responses for any other text
  /// (or arriving after a result was picked) are discarded.
  String? _latestQuery;

  SearchBloc({
    required PlusCodeRepository plusCodeRepository,
    required GeocodingRepository geocodingRepository,
    required SearchQuotaRepository quotaRepository,
    required PlacesRepository placesRepository,
  })  : _plusCodeRepository = plusCodeRepository,
        _geocodingRepository = geocodingRepository,
        _quotaRepository = quotaRepository,
        _placesRepository = placesRepository,
        super(const SearchState()) {
    on<_Init>(_onInit);
    on<_QueryChanged>(
      _onQueryChanged,
      transformer: debounceSequential(_suggestionsDebounce),
    );
    on<_SuggestionSelected>(_onSuggestionSelected);
    on<_SubmitQuery>(_onSubmitQuery);
    on<_Reset>(_onReset);
  }

  @override
  void onEvent(SearchEvent event) {
    super.onEvent(event);
    // Runs synchronously on add(), before the debounce delay.
    if (event is _QueryChanged) _latestQuery = event.query;
  }

  String get _languageCode => LocalizationService.localization.localeName;

  Future<void> _onInit(_Init event, Emitter<SearchState> emit) async {
    final canUseAutocomplete = await _quotaRepository.canUseAutocomplete();
    emit(state.copyWith(
      searchMode:
          canUseAutocomplete ? SearchMode.autocomplete : SearchMode.onSubmit,
    ));
  }

  Future<void> _onQueryChanged(
    _QueryChanged event,
    Emitter<SearchState> emit,
  ) async {
    if (event.query != _latestQuery) return;

    final query = event.query.trim();
    if (state.searchMode != SearchMode.autocomplete ||
        query.length < _minAutocompleteLength ||
        _parsePlusCodeQuery(query) != null) {
      _emitSuggestionsCleared(emit);
      return;
    }

    emit(state.copyWith(
      suggestionsStatus: GenericStatus.loading,
      suggestionsErrorMessage: null,
    ));

    try {
      final suggestions = await _placesRepository.autocomplete(
        input: query,
        languageCode: _languageCode,
      );
      if (event.query != _latestQuery) return;

      emit(state.copyWith(
        suggestionsStatus: GenericStatus.success,
        suggestions: suggestions,
      ));
    } on AccessDeniedException catch (e) {
      // Google refused the project (e.g. billing off): stop asking for this
      // session and fall back to free search-on-submit, without an error.
      log('Places unavailable, switching to search-on-submit: $e');
      _emitSuggestionsCleared(emit);
      emit(state.copyWith(searchMode: SearchMode.onSubmit));
    } catch (e) {
      log('Error fetching suggestions: $e');
      if (event.query != _latestQuery) return;

      emit(state.copyWith(
        suggestionsStatus: GenericStatus.failure,
        suggestions: const [],
        suggestionsErrorMessage:
            LocalizationService.localization.errorPlacesUnavailable,
      ));
    }
  }

  Future<void> _onSuggestionSelected(
    _SuggestionSelected event,
    Emitter<SearchState> emit,
  ) async {
    _latestQuery = null;
    _emitSearchLoading(emit);

    try {
      final locationResult = await _placesRepository.placeDetails(
        placeId: event.suggestion.placeId,
        languageCode: _languageCode,
      );
      if (locationResult == null) {
        _emitSearchFailure(
          emit,
          LocalizationService.localization.errorPlaceDetails,
        );
        return;
      }

      await _quotaRepository.recordAutocompleteUsage();
      final plusCode = await _plusCodeRepository.encodePlusCode(
        latitude: locationResult.latitude!,
        longitude: locationResult.longitude!,
      );
      final canStillUseAutocomplete =
          await _quotaRepository.canUseAutocomplete();

      final placeName = event.suggestion.title.trim();

      emit(state.copyWith(
        searchStatus: GenericStatus.success,
        plusCode: plusCode,
        locationResult: locationResult,
        placeName: placeName.isEmpty ? null : placeName,
        searchMode: canStillUseAutocomplete
            ? SearchMode.autocomplete
            : SearchMode.onSubmit,
      ));
    } on AccessDeniedException catch (e) {
      log('Places unavailable, switching to search-on-submit: $e');
      emit(state.copyWith(searchMode: SearchMode.onSubmit));
      _emitSearchFailure(
        emit,
        LocalizationService.localization.errorPlaceDetails,
      );
    } catch (e) {
      log('Error resolving selected place: $e');
      _emitSearchFailure(
        emit,
        LocalizationService.localization.errorPlaceDetails,
      );
    }
  }

  /// Auto-detects full Plus Code, short Plus Code + locality, or address.
  Future<void> _onSubmitQuery(
    _SubmitQuery event,
    Emitter<SearchState> emit,
  ) async {
    _latestQuery = null;
    _placesRepository.endSession();

    final query = event.query.trim();
    if (query.isEmpty) return;

    _emitSearchLoading(emit);

    try {
      final plusCodeQuery = _parsePlusCodeQuery(query);
      if (plusCodeQuery != null) {
        await _searchByPlusCode(
          plusCodeQuery.code,
          plusCodeQuery.locality,
          emit,
        );
      } else {
        await _searchByAddress(query, emit);
      }
    } catch (e) {
      log('Error submitting search query: $e');
      _emitSearchFailure(
        emit,
        LocalizationService.localization.errorSearchFailed,
      );
    }
  }

  /// Splits `"9G8F+6W Douala, Cameroon"` into the code and the locality.
  /// Returns null when the first word isn't a valid Plus Code.
  ({String code, String? locality})? _parsePlusCodeQuery(String query) {
    final words = query.split(RegExp(r'\s+'));
    final code = words.first.toUpperCase();
    if (!_plusCodeRepository.isValidPlusCode(code)) return null;

    final locality =
        words.skip(1).join(' ').replaceFirst(RegExp(r'^,\s*'), '').trim();
    return (code: code, locality: locality.isEmpty ? null : locality);
  }

  Future<void> _searchByPlusCode(
    String code,
    String? locality,
    Emitter<SearchState> emit,
  ) async {
    final PlusCode? plusCode;

    if (_plusCodeRepository.isFullPlusCode(code)) {
      plusCode = await _plusCodeRepository.decodePlusCode(code: code);
    } else {
      if (locality == null) {
        _emitSearchFailure(
          emit,
          LocalizationService.localization.errorShortPlusCodeNeedsLocality,
        );
        return;
      }

      final reference = await _safeGeocode(locality);
      if (reference == null || !reference.hasCoordinates) {
        _emitSearchFailure(
          emit,
          LocalizationService.localization.errorShortPlusCodeLocalityNotFound,
        );
        return;
      }

      plusCode = await _plusCodeRepository.recoverShortPlusCode(
        shortCode: code,
        referenceLatitude: reference.latitude!,
        referenceLongitude: reference.longitude!,
      );
    }

    if (plusCode == null || !plusCode.hasCoordinates) {
      _emitSearchFailure(
        emit,
        LocalizationService.localization.errorInvalidPlusCode,
      );
      return;
    }

    final locationResult = await _safeReverseGeocode(
      plusCode.latitude!,
      plusCode.longitude!,
    );

    emit(state.copyWith(
      searchStatus: GenericStatus.success,
      plusCode: plusCode,
      locationResult: locationResult,
    ));
  }

  Future<void> _searchByAddress(
    String address,
    Emitter<SearchState> emit,
  ) async {
    final locationResult = await _safeGeocode(address);
    if (locationResult == null || !locationResult.hasCoordinates) {
      _emitSearchFailure(
        emit,
        LocalizationService.localization.msgNoResults,
      );
      return;
    }

    final plusCode = await _plusCodeRepository.encodePlusCode(
      latitude: locationResult.latitude!,
      longitude: locationResult.longitude!,
    );

    emit(state.copyWith(
      searchStatus: GenericStatus.success,
      plusCode: plusCode,
      locationResult: locationResult,
    ));
  }

  /// Forward geocode without throwing — the device geocoder throws when it
  /// finds nothing.
  Future<LocationResult?> _safeGeocode(String address) async {
    try {
      return await _geocodingRepository.geocodeAddress(address: address);
    } catch (e) {
      log('Forward geocoding failed (non-fatal): $e');
      return null;
    }
  }

  /// Reverse geocode without throwing — failure just leaves the address
  /// blank, the Plus Code/coordinates are still shown.
  Future<LocationResult?> _safeReverseGeocode(
    double latitude,
    double longitude,
  ) async {
    try {
      return await _geocodingRepository.reverseGeocode(
        latitude: latitude,
        longitude: longitude,
      );
    } catch (e) {
      log('Reverse geocoding failed (non-fatal): $e');
      return null;
    }
  }

  void _emitSearchLoading(Emitter<SearchState> emit) {
    emit(state.copyWith(
      searchStatus: GenericStatus.loading,
      searchErrorMessage: null,
      placeName: null,
      suggestions: const [],
      suggestionsStatus: GenericStatus.initial,
      suggestionsErrorMessage: null,
    ));
  }

  void _emitSearchFailure(Emitter<SearchState> emit, String message) {
    emit(state.copyWith(
      searchStatus: GenericStatus.failure,
      searchErrorMessage: message,
    ));
  }

  void _emitSuggestionsCleared(Emitter<SearchState> emit) {
    emit(state.copyWith(
      suggestions: const [],
      suggestionsStatus: GenericStatus.initial,
      suggestionsErrorMessage: null,
    ));
  }

  void _onReset(_Reset event, Emitter<SearchState> emit) {
    _latestQuery = null;
    _placesRepository.endSession();
    emit(state.copyWith(
      searchStatus: GenericStatus.initial,
      plusCode: null,
      locationResult: null,
      searchErrorMessage: null,
      suggestions: const [],
      suggestionsStatus: GenericStatus.initial,
      suggestionsErrorMessage: null,
      placeName: null,
    ));
  }
}
