import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/domain/models/location_result.dart';
import 'package:plus_locate/src/domain/repository/geocoding_repository.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'map_view_event.dart';
part 'map_view_state.dart';
part 'map_view_bloc.freezed.dart';

class MapViewBloc extends Bloc<MapViewEvent, MapViewState> {
  final GeocodingRepository _geocodingRepository;

  MapViewBloc({required GeocodingRepository geocodingRepository})
      : _geocodingRepository = geocodingRepository,
        super(const MapViewState()) {
    on<_Init>(_onInit);
    on<_UpdateLocation>(_onUpdateLocation);
    on<_ReverseGeocodeLocation>(_onReverseGeocodeLocation);
    on<_Reset>(_onReset);
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
      final result = await _geocodingRepository.reverseGeocode(
        latitude: event.latitude,
        longitude: event.longitude,
      );

      if (result != null) {
        emit(state.copyWith(
          geocodeStatus: GenericStatus.success,
          locationResult: result,
          currentLatitude: event.latitude,
          currentLongitude: event.longitude,
        ));
      } else {
        emit(state.copyWith(
          geocodeStatus: GenericStatus.failure,
          geocodeErrorMessage:
              LocalizationService.localization.operationError,
        ));
      }
    } catch (e) {
      log('Error reverse geocoding: $e');
      emit(state.copyWith(
        geocodeStatus: GenericStatus.failure,
        geocodeErrorMessage:
            LocalizationService.localization.operationError,
      ));
    }
  }

  void _onReset(_Reset event, Emitter<MapViewState> emit) {
    emit(const MapViewState());
  }
}
