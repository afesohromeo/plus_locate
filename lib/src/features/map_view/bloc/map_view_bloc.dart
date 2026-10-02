import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/domain/models/location_result.dart';
import 'package:plus_locate/src/domain/repository/geocoding_repository.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'map_view_event.dart';
part 'map_view_state.dart';
part 'map_view_bloc.freezed.dart';

class MapViewBloc extends Bloc<MapViewEvent, MapViewState> {
  final GeocodingRepository _geocodingRepository;
  final PlusCodeRepository _plusCodeRepository;

  MapViewBloc({
    required GeocodingRepository geocodingRepository,
    required PlusCodeRepository plusCodeRepository,
  })  : _geocodingRepository = geocodingRepository,
        _plusCodeRepository = plusCodeRepository,
        super(const MapViewState()) {
    on<_Init>(_onInit);
    on<_UpdateLocation>(_onUpdateLocation);
    on<_ReverseGeocodeLocation>(_onReverseGeocodeLocation);
    on<_FocusOnLocation>(_onFocusOnLocation);
    on<_Reset>(_onReset);
    on<_ToggleMapType>(_onToggleMapType);
    on<_SetDetailCardExpanded>(_onSetDetailCardExpanded);
  }

  void _onInit(_Init event, Emitter<MapViewState> emit) {
    emit(const MapViewState());
  }

  void _onUpdateLocation(
    _UpdateLocation event,
    Emitter<MapViewState> emit,
  ) {
    emit(state.copyWith(
      currentLatitude: event.latitude,
      currentLongitude: event.longitude,
    ));
  }

  Future<void> _onReverseGeocodeLocation(
    _ReverseGeocodeLocation event,
    Emitter<MapViewState> emit,
  ) async {
    emit(state.copyWith(
      geocodeStatus: GenericStatus.loading,
      geocodeErrorMessage: null,
    ));

    try {
      final results = await Future.wait([
        _safeReverseGeocode(event.latitude, event.longitude),
        _plusCodeRepository.encodePlusCode(
          latitude: event.latitude,
          longitude: event.longitude,
        ),
      ]);

      final locationResult = results[0] as LocationResult?;
      final plusCode = results[1] as PlusCode?;

      if (plusCode != null) {
        emit(state.copyWith(
          geocodeStatus: GenericStatus.success,
          locationResult: locationResult,
          selectedPlusCode: plusCode,
          currentLatitude: event.latitude,
          currentLongitude: event.longitude,
        ));
      } else {
        emit(state.copyWith(
          geocodeStatus: GenericStatus.failure,
          geocodeErrorMessage: LocalizationService.localization.operationError,
        ));
      }
    } catch (e) {
      log('Error encoding Plus Code: $e');
      emit(state.copyWith(
        geocodeStatus: GenericStatus.failure,
        geocodeErrorMessage: LocalizationService.localization.operationError,
      ));
    }
  }

  /// Reverse geocode without throwing — a timeout or network error returns null
  /// so the plus code can still be displayed.
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
      log('Geocoding failed (non-fatal): $e');
      return null;
    }
  }

  void _onFocusOnLocation(
    _FocusOnLocation event,
    Emitter<MapViewState> emit,
  ) {
    emit(state.copyWith(
      geocodeStatus: GenericStatus.success,
      currentLatitude: event.latitude,
      currentLongitude: event.longitude,
      selectedPlusCode: event.plusCode,
      locationResult: event.locationResult,
      focusToken: state.focusToken + 1,
    ));
  }

  void _onReset(_Reset event, Emitter<MapViewState> emit) {
    emit(const MapViewState());
  }

  void _onToggleMapType(
    _ToggleMapType event,
    Emitter<MapViewState> emit,
  ) {
    final nextMapType = switch (state.mapType) {
      MapType.normal => MapType.satellite,
      MapType.satellite => MapType.terrain,
      _ => MapType.normal,
    };
    emit(state.copyWith(mapType: nextMapType));
  }

  void _onSetDetailCardExpanded(
    _SetDetailCardExpanded event,
    Emitter<MapViewState> emit,
  ) {
    emit(state.copyWith(isDetailCardExpanded: event.expanded));
  }
}
