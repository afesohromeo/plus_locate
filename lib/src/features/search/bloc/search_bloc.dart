// lib/src/features/search/bloc/search_bloc.dart
import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:plus_locate/src/domain/models/location_result.dart';
import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/domain/repository/geocoding_repository.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';
import 'package:plus_locate/src/domain/repository/search_quota_repository.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'search_event.dart';
part 'search_state.dart';
part 'search_bloc.freezed.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final PlusCodeRepository _plusCodeRepository;
  final GeocodingRepository _geocodingRepository;
  final SearchQuotaRepository _quotaRepository;

  SearchBloc({
    required PlusCodeRepository plusCodeRepository,
    required GeocodingRepository geocodingRepository,
    required SearchQuotaRepository quotaRepository,
  })  : _plusCodeRepository = plusCodeRepository,
        _geocodingRepository = geocodingRepository,
        _quotaRepository = quotaRepository,
        super(const SearchState()) {
    on<_Init>(_onInit);
    on<_PlaceSelected>(_onPlaceSelected);
    on<_SubmitQuery>(_onSubmitQuery);
    on<_Reset>(_onReset);
  }

  Future<void> _onInit(_Init event, Emitter<SearchState> emit) async {
    final canUseAutocomplete = await _quotaRepository.canUseAutocomplete();
    emit(state.copyWith(
      searchMode:
          canUseAutocomplete ? SearchMode.autocomplete : SearchMode.onSubmit,
    ));
  }

  /// User picked a suggestion from Places Autocomplete.
  Future<void> _onPlaceSelected(
    _PlaceSelected event,
    Emitter<SearchState> emit,
  ) async {
    emit(state.copyWith(
      searchStatus: GenericStatus.loading,
      searchErrorMessage: null,
    ));

    try {
      await _quotaRepository.recordAutocompleteUsage();

      final results = await Future.wait([
        _plusCodeRepository.encodePlusCode(
          latitude: event.latitude,
          longitude: event.longitude,
        ),
        _safeReverseGeocode(event.latitude, event.longitude),
      ]);

      final plusCode = results[0] as PlusCode?;
      final locationResult = (results[1] as LocationResult?) ??
          LocationResult(
            formattedAddress: event.description,
            latitude: event.latitude,
            longitude: event.longitude,
          );

      final canStillUseAutocomplete =
          await _quotaRepository.canUseAutocomplete();

      emit(state.copyWith(
        searchStatus: GenericStatus.success,
        plusCode: plusCode,
        locationResult: locationResult,
        searchMode: canStillUseAutocomplete
            ? SearchMode.autocomplete
            : SearchMode.onSubmit,
      ));
    } catch (e) {
      log('Error resolving selected place: $e');
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage: LocalizationService.localization.operationError,
      ));
    }
  }

  /// User submitted free text in search-on-submit mode. Auto-detects
  /// whether [SubmitQuery.query] is a Plus Code or an address.
  Future<void> _onSubmitQuery(
    _SubmitQuery event,
    Emitter<SearchState> emit,
  ) async {
    final query = event.query.trim();
    if (query.isEmpty) return;

    emit(state.copyWith(
      searchStatus: GenericStatus.loading,
      searchErrorMessage: null,
    ));

    try {
      if (_plusCodeRepository.isValidPlusCode(query)) {
        await _searchByPlusCode(query, emit);
      } else {
        await _searchByAddress(query, emit);
      }
    } catch (e) {
      log('Error submitting search query: $e');
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage: LocalizationService.localization.operationError,
      ));
    }
  }

  Future<void> _searchByPlusCode(
    String code,
    Emitter<SearchState> emit,
  ) async {
    final plusCode = await _plusCodeRepository.decodePlusCode(code: code);
    if (plusCode == null || !plusCode.hasCoordinates) {
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage:
            LocalizationService.localization.errorInvalidPlusCode,
      ));
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
    final locationResult =
        await _geocodingRepository.geocodeAddress(address: address);
    if (locationResult == null || !locationResult.hasCoordinates) {
      emit(state.copyWith(
        searchStatus: GenericStatus.failure,
        searchErrorMessage: LocalizationService.localization.msgNoResults,
      ));
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

  void _onReset(_Reset event, Emitter<SearchState> emit) {
    emit(state.copyWith(
      searchStatus: GenericStatus.initial,
      plusCode: null,
      locationResult: null,
      searchErrorMessage: null,
    ));
  }
}