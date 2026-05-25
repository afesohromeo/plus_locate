part of 'map_view_bloc.dart';

@freezed
class MapViewEvent with _$MapViewEvent {
  const factory MapViewEvent.init() = _Init;
  const factory MapViewEvent.updateLocation({
    required double latitude,
    required double longitude,
  }) = _UpdateLocation;
  const factory MapViewEvent.reverseGeocodeLocation({
    required double latitude,
    required double longitude,
  }) = _ReverseGeocodeLocation;
  const factory MapViewEvent.reset() = _Reset;
  const factory MapViewEvent.toggleMapType() = _ToggleMapType;
}
