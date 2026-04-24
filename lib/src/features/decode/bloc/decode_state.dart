part of 'decode_bloc.dart';

@freezed
sealed class DecodeState with _$DecodeState {
  const factory DecodeState({
    @Default(GenericStatus.initial) GenericStatus decodeStatus,
    PlusCode? decodedResult,
    String? decodeErrorMessage,
  }) = _DecodeState;
}
