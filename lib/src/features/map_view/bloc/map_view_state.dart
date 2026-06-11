part of 'map_view_bloc.dart';

@freezed
sealed class MapViewState with _$MapViewState {
  const factory MapViewState({
    @Default(GenericStatus.initial) GenericStatus geocodeStatus,
    LocationResult? locationResult,
    PlusCode? selectedPlusCode,
    double? currentLatitude,
    double? currentLongitude,
    String? geocodeErrorMessage,
    @Default(MapType.normal) MapType mapType,
    @Default(0) int focusToken,
  }) = _MapViewState;
}
