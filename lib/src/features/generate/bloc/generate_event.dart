part of 'generate_bloc.dart';

@freezed
class GenerateEvent with _$GenerateEvent {
  const factory GenerateEvent.init() = _Init;
  const factory GenerateEvent.generateFromCoordinates({
    required double latitude,
    required double longitude,
  }) = _GenerateFromCoordinates;
  const factory GenerateEvent.reset() = _Reset;
}
