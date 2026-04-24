part of 'history_bloc.dart';

@freezed
class HistoryEvent with _$HistoryEvent {
  const factory HistoryEvent.init() = _Init;
  const factory HistoryEvent.fetchSavedCodes() = _FetchSavedCodes;
  const factory HistoryEvent.saveCode({
    required SavedCode code,
  }) = _SaveCode;
  const factory HistoryEvent.deleteCode({
    required String id,
  }) = _DeleteCode;
  const factory HistoryEvent.searchCodes({
    required String query,
  }) = _SearchCodes;
  const factory HistoryEvent.resetFlowStep() = _ResetFlowStep;
  const factory HistoryEvent.reset() = _Reset;
}
