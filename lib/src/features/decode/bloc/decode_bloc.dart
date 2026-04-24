import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:plus_locate/src/domain/models/plus_code.dart';
import 'package:plus_locate/src/domain/repository/plus_code_repository.dart';
import 'package:plus_locate/src/shared/utils/localization_service.dart';
import 'package:plus_locate/src/shared/utils/status.dart';

part 'decode_event.dart';
part 'decode_state.dart';
part 'decode_bloc.freezed.dart';

class DecodeBloc extends Bloc<DecodeEvent, DecodeState> {
  final PlusCodeRepository _repository;

  DecodeBloc({required PlusCodeRepository repository})
      : _repository = repository,
        super(const DecodeState()) {
    on<_Init>(_onInit);
    on<_DecodePlusCode>(_onDecodePlusCode);
    on<_Reset>(_onReset);
  }

  void _onInit(_Init event, Emitter<DecodeState> emit) {
    emit(const DecodeState());
  }

  Future<void> _onDecodePlusCode(
    _DecodePlusCode event,
    Emitter<DecodeState> emit,
  ) async {
    emit(state.copyWith(
      decodeStatus: GenericStatus.loading,
      decodeErrorMessage: null,
    ));

    try {
      final result = await _repository.decodePlusCode(code: event.code);

      if (result != null) {
        emit(state.copyWith(
          decodeStatus: GenericStatus.success,
          decodedResult: result,
        ));
      } else {
        emit(state.copyWith(
          decodeStatus: GenericStatus.failure,
          decodeErrorMessage:
              LocalizationService.localization.operationError,
        ));
      }
    } catch (e) {
      log('Error decoding Plus Code: $e');
      emit(state.copyWith(
        decodeStatus: GenericStatus.failure,
        decodeErrorMessage:
            LocalizationService.localization.operationError,
      ));
    }
  }

  void _onReset(_Reset event, Emitter<DecodeState> emit) {
    emit(const DecodeState());
  }
}
