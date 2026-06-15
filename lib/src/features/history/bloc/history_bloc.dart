import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:plus_locate/src/domain/models/saved_code.dart';
import 'package:plus_locate/src/domain/repository/saved_codes_repository.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'history_event.dart';
part 'history_state.dart';
part 'history_bloc.freezed.dart';

class HistoryBloc extends Bloc<HistoryEvent, HistoryState> {
  final SavedCodesRepository _repository;

  HistoryBloc({required SavedCodesRepository repository})
      : _repository = repository,
        super(const HistoryState()) {
    on<_Init>(_onInit);
    on<_FetchSavedCodes>(_onFetchSavedCodes);
    on<_SaveCode>(_onSaveCode);
    on<_DeleteCode>(_onDeleteCode);
    on<_SearchCodes>(_onSearchCodes);
    on<_ResetFlowStep>(_onResetFlowStep);
    on<_Reset>(_onReset);
    on<_EnterSelectionMode>(_onEnterSelectionMode);
    on<_ToggleItemSelection>(_onToggleItemSelection);
    on<_SelectAllCodes>(_onSelectAllCodes);
    on<_ExitSelectionMode>(_onExitSelectionMode);
    on<_DeleteSelectedCodes>(_onDeleteSelectedCodes);
  }

  void _onInit(_Init event, Emitter<HistoryState> emit) {
    add(const HistoryEvent.fetchSavedCodes());
  }

  Future<void> _onFetchSavedCodes(
    _FetchSavedCodes event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(
      historyStatus: GenericStatus.loading,
      historyErrorMessage: null,
    ));

    try {
      final codes = await _repository.fetchAllSavedCodes();
      emit(state.copyWith(
        historyStatus: GenericStatus.success,
        savedCodes: codes,
      ));
    } catch (e) {
      log('Error fetching saved codes: $e');
      emit(state.copyWith(
        historyStatus: GenericStatus.failure,
        historyErrorMessage:
            LocalizationService.localization.operationError,
      ));
    }
  }

  Future<void> _onSaveCode(
    _SaveCode event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(
      flowStep: GenericFlowStep.creatingItem,
      historyActionStatus: GenericStatus.loading,
      historyActionErrorMessage: null,
    ));

    try {
      final result = await _repository.saveCode(event.code);
      if (result != null) {
        emit(state.copyWith(
          historyActionStatus: GenericStatus.success,
        ));
        // Refresh the list
        add(const HistoryEvent.fetchSavedCodes());
      } else {
        emit(state.copyWith(
          historyActionStatus: GenericStatus.failure,
          historyActionErrorMessage:
              LocalizationService.localization.operationError,
        ));
      }
    } catch (e) {
      log('Error saving code: $e');
      emit(state.copyWith(
        historyActionStatus: GenericStatus.failure,
        historyActionErrorMessage:
            LocalizationService.localization.operationError,
      ));
    }
  }

  Future<void> _onDeleteCode(
    _DeleteCode event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(
      flowStep: GenericFlowStep.deletingItem,
      historyActionStatus: GenericStatus.loading,
      historyActionErrorMessage: null,
    ));

    try {
      await _repository.deleteCode(event.id);
      emit(state.copyWith(
        historyActionStatus: GenericStatus.success,
      ));
      // Refresh the list
      add(const HistoryEvent.fetchSavedCodes());
    } catch (e) {
      log('Error deleting code: $e');
      emit(state.copyWith(
        historyActionStatus: GenericStatus.failure,
        historyActionErrorMessage:
            LocalizationService.localization.operationError,
      ));
    }
  }

  Future<void> _onSearchCodes(
    _SearchCodes event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(
      historyStatus: GenericStatus.filtering,
    ));

    try {
      final codes = await _repository.searchCodes(event.query);
      emit(state.copyWith(
        historyStatus: GenericStatus.success,
        savedCodes: codes,
      ));
    } catch (e) {
      log('Error searching codes: $e');
      emit(state.copyWith(
        historyStatus: GenericStatus.failure,
        historyErrorMessage:
            LocalizationService.localization.operationError,
      ));
    }
  }

  void _onResetFlowStep(
    _ResetFlowStep event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(
      flowStep: GenericFlowStep.none,
      historyActionStatus: GenericStatus.initial,
      historyActionErrorMessage: null,
      lastDeletedCount: null,
    ));
  }

  void _onReset(_Reset event, Emitter<HistoryState> emit) {
    emit(const HistoryState());
  }

  void _onEnterSelectionMode(
    _EnterSelectionMode event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: true,
      selectedIds: {event.id},
    ));
  }

  void _onToggleItemSelection(
    _ToggleItemSelection event,
    Emitter<HistoryState> emit,
  ) {
    final selectedIds = Set<String>.from(state.selectedIds);
    if (selectedIds.contains(event.id)) {
      selectedIds.remove(event.id);
    } else {
      selectedIds.add(event.id);
    }

    emit(state.copyWith(
      isSelectionMode: selectedIds.isNotEmpty,
      selectedIds: selectedIds,
    ));
  }

  void _onSelectAllCodes(
    _SelectAllCodes event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: true,
      selectedIds: state.savedCodes
          .where((code) => code.id != null)
          .map((code) => code.id!)
          .toSet(),
    ));
  }

  void _onExitSelectionMode(
    _ExitSelectionMode event,
    Emitter<HistoryState> emit,
  ) {
    emit(state.copyWith(
      isSelectionMode: false,
      selectedIds: {},
    ));
  }

  Future<void> _onDeleteSelectedCodes(
    _DeleteSelectedCodes event,
    Emitter<HistoryState> emit,
  ) async {
    emit(state.copyWith(
      flowStep: GenericFlowStep.deletingItem,
      historyActionStatus: GenericStatus.loading,
      historyActionErrorMessage: null,
    ));

    try {
      final deletedCount = state.selectedIds.length;
      await _repository.deleteCodes(state.selectedIds.toList());
      emit(state.copyWith(
        historyActionStatus: GenericStatus.success,
        isSelectionMode: false,
        selectedIds: {},
        lastDeletedCount: deletedCount,
      ));
      // Refresh the list
      add(const HistoryEvent.fetchSavedCodes());
    } catch (e) {
      log('Error deleting selected codes: $e');
      emit(state.copyWith(
        historyActionStatus: GenericStatus.failure,
        historyActionErrorMessage:
            LocalizationService.localization.errorDeletingSelectedCodes,
      ));
    }
  }
}
