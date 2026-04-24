part of 'decode_bloc.dart';

@freezed
class DecodeEvent with _$DecodeEvent {
  const factory DecodeEvent.init() = _Init;
  const factory DecodeEvent.decodePlusCode({
    required String code,
  }) = _DecodePlusCode;
  const factory DecodeEvent.reset() = _Reset;
}
