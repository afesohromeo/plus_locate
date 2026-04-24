part of 'history_bloc.dart';

@freezed
sealed class HistoryState with _$HistoryState {
  const factory HistoryState({
    @Default([]) List<SavedCode> savedCodes,

    // --- Status fields (scoped per RULE-006) ---
    @Default(GenericStatus.initial) GenericStatus historyStatus,
    @Default(GenericStatus.initial) GenericStatus historyActionStatus,

    // --- Flow step (for CRUD per RULE-004) ---
    @Default(GenericFlowStep.none) GenericFlowStep flowStep,

    // --- Error messages (per RULE-007) ---
    String? historyErrorMessage,
    String? historyActionErrorMessage,
  }) = _HistoryState;
}
