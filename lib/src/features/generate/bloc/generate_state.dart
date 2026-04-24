part of 'generate_bloc.dart';

@freezed
sealed class GenerateState with _$GenerateState {
  const factory GenerateState({
    @Default(GenericStatus.initial) GenericStatus generateStatus,
    PlusCode? generatedCode,
    String? generateErrorMessage,
  }) = _GenerateState;
}
