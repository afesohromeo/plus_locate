import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'generate_event.dart';
part 'generate_state.dart';
part 'generate_bloc.freezed.dart';

class GenerateBloc extends Bloc<GenerateEvent, GenerateState> {
  final PlusCodeRepository _repository;

  GenerateBloc({required PlusCodeRepository repository})
      : _repository = repository,
        super(const GenerateState()) {
    on<_Init>(_onInit);
    on<_GenerateFromCoordinates>(_onGenerateFromCoordinates);
    on<_Reset>(_onReset);
  }

  void _onInit(_Init event, Emitter<GenerateState> emit) {
    emit(const GenerateState());
  }

  Future<void> _onGenerateFromCoordinates(
    _GenerateFromCoordinates event,
    Emitter<GenerateState> emit,
  ) async {
    emit(state.copyWith(
      generateStatus: GenericStatus.loading,
      generateErrorMessage: null,
    ));

    try {
      final result = await _repository.encodePlusCode(
        latitude: event.latitude,
        longitude: event.longitude,
      );

      if (result != null) {
        emit(state.copyWith(
          generateStatus: GenericStatus.success,
          generatedCode: result,
        ));
      } else {
        emit(state.copyWith(
          generateStatus: GenericStatus.failure,
          generateErrorMessage:
              LocalizationService.localization.operationError,
        ));
      }
    } catch (e) {
      log('Error generating Plus Code: $e');
      emit(state.copyWith(
        generateStatus: GenericStatus.failure,
        generateErrorMessage:
            LocalizationService.localization.operationError,
      ));
    }
  }

  void _onReset(_Reset event, Emitter<GenerateState> emit) {
    emit(const GenerateState());
  }
}
