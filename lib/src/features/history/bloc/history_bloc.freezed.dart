// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is HistoryEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent()';
  }
}

/// @nodoc
class $HistoryEventCopyWith<$Res> {
  $HistoryEventCopyWith(HistoryEvent _, $Res Function(HistoryEvent) __);
}

/// Adds pattern-matching-related methods to [HistoryEvent].
extension HistoryEventPatterns on HistoryEvent {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(_Init value)? init,
    TResult Function(_FetchSavedCodes value)? fetchSavedCodes,
    TResult Function(_SaveCode value)? saveCode,
    TResult Function(_DeleteCode value)? deleteCode,
    TResult Function(_SearchCodes value)? searchCodes,
    TResult Function(_ResetFlowStep value)? resetFlowStep,
    TResult Function(_Reset value)? reset,
    TResult Function(_EnterSelectionMode value)? enterSelectionMode,
    TResult Function(_ToggleItemSelection value)? toggleItemSelection,
    TResult Function(_SelectAllCodes value)? selectAllCodes,
    TResult Function(_ExitSelectionMode value)? exitSelectionMode,
    TResult Function(_DeleteSelectedCodes value)? deleteSelectedCodes,
    TResult Function(_ExportSavedCodes value)? exportSavedCodes,
    TResult Function(_ImportSavedCodes value)? importSavedCodes,
    TResult Function(_UpdateLabel value)? updateLabel,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _FetchSavedCodes() when fetchSavedCodes != null:
        return fetchSavedCodes(_that);
      case _SaveCode() when saveCode != null:
        return saveCode(_that);
      case _DeleteCode() when deleteCode != null:
        return deleteCode(_that);
      case _SearchCodes() when searchCodes != null:
        return searchCodes(_that);
      case _ResetFlowStep() when resetFlowStep != null:
        return resetFlowStep(_that);
      case _Reset() when reset != null:
        return reset(_that);
      case _EnterSelectionMode() when enterSelectionMode != null:
        return enterSelectionMode(_that);
      case _ToggleItemSelection() when toggleItemSelection != null:
        return toggleItemSelection(_that);
      case _SelectAllCodes() when selectAllCodes != null:
        return selectAllCodes(_that);
      case _ExitSelectionMode() when exitSelectionMode != null:
        return exitSelectionMode(_that);
      case _DeleteSelectedCodes() when deleteSelectedCodes != null:
        return deleteSelectedCodes(_that);
      case _ExportSavedCodes() when exportSavedCodes != null:
        return exportSavedCodes(_that);
      case _ImportSavedCodes() when importSavedCodes != null:
        return importSavedCodes(_that);
      case _UpdateLabel() when updateLabel != null:
        return updateLabel(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(_Init value) init,
    required TResult Function(_FetchSavedCodes value) fetchSavedCodes,
    required TResult Function(_SaveCode value) saveCode,
    required TResult Function(_DeleteCode value) deleteCode,
    required TResult Function(_SearchCodes value) searchCodes,
    required TResult Function(_ResetFlowStep value) resetFlowStep,
    required TResult Function(_Reset value) reset,
    required TResult Function(_EnterSelectionMode value) enterSelectionMode,
    required TResult Function(_ToggleItemSelection value) toggleItemSelection,
    required TResult Function(_SelectAllCodes value) selectAllCodes,
    required TResult Function(_ExitSelectionMode value) exitSelectionMode,
    required TResult Function(_DeleteSelectedCodes value) deleteSelectedCodes,
    required TResult Function(_ExportSavedCodes value) exportSavedCodes,
    required TResult Function(_ImportSavedCodes value) importSavedCodes,
    required TResult Function(_UpdateLabel value) updateLabel,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init(_that);
      case _FetchSavedCodes():
        return fetchSavedCodes(_that);
      case _SaveCode():
        return saveCode(_that);
      case _DeleteCode():
        return deleteCode(_that);
      case _SearchCodes():
        return searchCodes(_that);
      case _ResetFlowStep():
        return resetFlowStep(_that);
      case _Reset():
        return reset(_that);
      case _EnterSelectionMode():
        return enterSelectionMode(_that);
      case _ToggleItemSelection():
        return toggleItemSelection(_that);
      case _SelectAllCodes():
        return selectAllCodes(_that);
      case _ExitSelectionMode():
        return exitSelectionMode(_that);
      case _DeleteSelectedCodes():
        return deleteSelectedCodes(_that);
      case _ExportSavedCodes():
        return exportSavedCodes(_that);
      case _ImportSavedCodes():
        return importSavedCodes(_that);
      case _UpdateLabel():
        return updateLabel(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(_Init value)? init,
    TResult? Function(_FetchSavedCodes value)? fetchSavedCodes,
    TResult? Function(_SaveCode value)? saveCode,
    TResult? Function(_DeleteCode value)? deleteCode,
    TResult? Function(_SearchCodes value)? searchCodes,
    TResult? Function(_ResetFlowStep value)? resetFlowStep,
    TResult? Function(_Reset value)? reset,
    TResult? Function(_EnterSelectionMode value)? enterSelectionMode,
    TResult? Function(_ToggleItemSelection value)? toggleItemSelection,
    TResult? Function(_SelectAllCodes value)? selectAllCodes,
    TResult? Function(_ExitSelectionMode value)? exitSelectionMode,
    TResult? Function(_DeleteSelectedCodes value)? deleteSelectedCodes,
    TResult? Function(_ExportSavedCodes value)? exportSavedCodes,
    TResult? Function(_ImportSavedCodes value)? importSavedCodes,
    TResult? Function(_UpdateLabel value)? updateLabel,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _FetchSavedCodes() when fetchSavedCodes != null:
        return fetchSavedCodes(_that);
      case _SaveCode() when saveCode != null:
        return saveCode(_that);
      case _DeleteCode() when deleteCode != null:
        return deleteCode(_that);
      case _SearchCodes() when searchCodes != null:
        return searchCodes(_that);
      case _ResetFlowStep() when resetFlowStep != null:
        return resetFlowStep(_that);
      case _Reset() when reset != null:
        return reset(_that);
      case _EnterSelectionMode() when enterSelectionMode != null:
        return enterSelectionMode(_that);
      case _ToggleItemSelection() when toggleItemSelection != null:
        return toggleItemSelection(_that);
      case _SelectAllCodes() when selectAllCodes != null:
        return selectAllCodes(_that);
      case _ExitSelectionMode() when exitSelectionMode != null:
        return exitSelectionMode(_that);
      case _DeleteSelectedCodes() when deleteSelectedCodes != null:
        return deleteSelectedCodes(_that);
      case _ExportSavedCodes() when exportSavedCodes != null:
        return exportSavedCodes(_that);
      case _ImportSavedCodes() when importSavedCodes != null:
        return importSavedCodes(_that);
      case _UpdateLabel() when updateLabel != null:
        return updateLabel(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? init,
    TResult Function()? fetchSavedCodes,
    TResult Function(SavedCode code)? saveCode,
    TResult Function(String id)? deleteCode,
    TResult Function(String query)? searchCodes,
    TResult Function()? resetFlowStep,
    TResult Function()? reset,
    TResult Function(String id)? enterSelectionMode,
    TResult Function(String id)? toggleItemSelection,
    TResult Function()? selectAllCodes,
    TResult Function()? exitSelectionMode,
    TResult Function()? deleteSelectedCodes,
    TResult Function(Set<String>? ids)? exportSavedCodes,
    TResult Function(String content)? importSavedCodes,
    TResult Function(String id, String? label)? updateLabel,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _FetchSavedCodes() when fetchSavedCodes != null:
        return fetchSavedCodes();
      case _SaveCode() when saveCode != null:
        return saveCode(_that.code);
      case _DeleteCode() when deleteCode != null:
        return deleteCode(_that.id);
      case _SearchCodes() when searchCodes != null:
        return searchCodes(_that.query);
      case _ResetFlowStep() when resetFlowStep != null:
        return resetFlowStep();
      case _Reset() when reset != null:
        return reset();
      case _EnterSelectionMode() when enterSelectionMode != null:
        return enterSelectionMode(_that.id);
      case _ToggleItemSelection() when toggleItemSelection != null:
        return toggleItemSelection(_that.id);
      case _SelectAllCodes() when selectAllCodes != null:
        return selectAllCodes();
      case _ExitSelectionMode() when exitSelectionMode != null:
        return exitSelectionMode();
      case _DeleteSelectedCodes() when deleteSelectedCodes != null:
        return deleteSelectedCodes();
      case _ExportSavedCodes() when exportSavedCodes != null:
        return exportSavedCodes(_that.ids);
      case _ImportSavedCodes() when importSavedCodes != null:
        return importSavedCodes(_that.content);
      case _UpdateLabel() when updateLabel != null:
        return updateLabel(_that.id, _that.label);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() init,
    required TResult Function() fetchSavedCodes,
    required TResult Function(SavedCode code) saveCode,
    required TResult Function(String id) deleteCode,
    required TResult Function(String query) searchCodes,
    required TResult Function() resetFlowStep,
    required TResult Function() reset,
    required TResult Function(String id) enterSelectionMode,
    required TResult Function(String id) toggleItemSelection,
    required TResult Function() selectAllCodes,
    required TResult Function() exitSelectionMode,
    required TResult Function() deleteSelectedCodes,
    required TResult Function(Set<String>? ids) exportSavedCodes,
    required TResult Function(String content) importSavedCodes,
    required TResult Function(String id, String? label) updateLabel,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init();
      case _FetchSavedCodes():
        return fetchSavedCodes();
      case _SaveCode():
        return saveCode(_that.code);
      case _DeleteCode():
        return deleteCode(_that.id);
      case _SearchCodes():
        return searchCodes(_that.query);
      case _ResetFlowStep():
        return resetFlowStep();
      case _Reset():
        return reset();
      case _EnterSelectionMode():
        return enterSelectionMode(_that.id);
      case _ToggleItemSelection():
        return toggleItemSelection(_that.id);
      case _SelectAllCodes():
        return selectAllCodes();
      case _ExitSelectionMode():
        return exitSelectionMode();
      case _DeleteSelectedCodes():
        return deleteSelectedCodes();
      case _ExportSavedCodes():
        return exportSavedCodes(_that.ids);
      case _ImportSavedCodes():
        return importSavedCodes(_that.content);
      case _UpdateLabel():
        return updateLabel(_that.id, _that.label);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? init,
    TResult? Function()? fetchSavedCodes,
    TResult? Function(SavedCode code)? saveCode,
    TResult? Function(String id)? deleteCode,
    TResult? Function(String query)? searchCodes,
    TResult? Function()? resetFlowStep,
    TResult? Function()? reset,
    TResult? Function(String id)? enterSelectionMode,
    TResult? Function(String id)? toggleItemSelection,
    TResult? Function()? selectAllCodes,
    TResult? Function()? exitSelectionMode,
    TResult? Function()? deleteSelectedCodes,
    TResult? Function(Set<String>? ids)? exportSavedCodes,
    TResult? Function(String content)? importSavedCodes,
    TResult? Function(String id, String? label)? updateLabel,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _FetchSavedCodes() when fetchSavedCodes != null:
        return fetchSavedCodes();
      case _SaveCode() when saveCode != null:
        return saveCode(_that.code);
      case _DeleteCode() when deleteCode != null:
        return deleteCode(_that.id);
      case _SearchCodes() when searchCodes != null:
        return searchCodes(_that.query);
      case _ResetFlowStep() when resetFlowStep != null:
        return resetFlowStep();
      case _Reset() when reset != null:
        return reset();
      case _EnterSelectionMode() when enterSelectionMode != null:
        return enterSelectionMode(_that.id);
      case _ToggleItemSelection() when toggleItemSelection != null:
        return toggleItemSelection(_that.id);
      case _SelectAllCodes() when selectAllCodes != null:
        return selectAllCodes();
      case _ExitSelectionMode() when exitSelectionMode != null:
        return exitSelectionMode();
      case _DeleteSelectedCodes() when deleteSelectedCodes != null:
        return deleteSelectedCodes();
      case _ExportSavedCodes() when exportSavedCodes != null:
        return exportSavedCodes(_that.ids);
      case _ImportSavedCodes() when importSavedCodes != null:
        return importSavedCodes(_that.content);
      case _UpdateLabel() when updateLabel != null:
        return updateLabel(_that.id, _that.label);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Init implements HistoryEvent {
  const _Init();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Init);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent.init()';
  }
}

/// @nodoc

class _FetchSavedCodes implements HistoryEvent {
  const _FetchSavedCodes();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _FetchSavedCodes);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent.fetchSavedCodes()';
  }
}

/// @nodoc

class _SaveCode implements HistoryEvent {
  const _SaveCode({required this.code});

  final SavedCode code;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SaveCodeCopyWith<_SaveCode> get copyWith =>
      __$SaveCodeCopyWithImpl<_SaveCode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SaveCode &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, code);
  }

  @override
  String toString() {
    return 'HistoryEvent.saveCode(code: $code)';
  }
}

/// @nodoc
abstract mixin class _$SaveCodeCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$SaveCodeCopyWith(_SaveCode value, $Res Function(_SaveCode) _then) =
      __$SaveCodeCopyWithImpl;
  @useResult
  $Res call({SavedCode code});

  $SavedCodeCopyWith<$Res> get code;
}

/// @nodoc
class __$SaveCodeCopyWithImpl<$Res> implements _$SaveCodeCopyWith<$Res> {
  __$SaveCodeCopyWithImpl(this._self, this._then);

  final _SaveCode _self;
  final $Res Function(_SaveCode) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
  }) {
    return _then(_SaveCode(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as SavedCode,
    ));
  }

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $SavedCodeCopyWith<$Res> get code {
    return $SavedCodeCopyWith<$Res>(_self.code, (value) {
      return _then(_self.copyWith(code: value));
    });
  }
}

/// @nodoc

class _DeleteCode implements HistoryEvent {
  const _DeleteCode({required this.id});

  final String id;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DeleteCodeCopyWith<_DeleteCode> get copyWith =>
      __$DeleteCodeCopyWithImpl<_DeleteCode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DeleteCode &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id);
  }

  @override
  String toString() {
    return 'HistoryEvent.deleteCode(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$DeleteCodeCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$DeleteCodeCopyWith(
          _DeleteCode value, $Res Function(_DeleteCode) _then) =
      __$DeleteCodeCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$DeleteCodeCopyWithImpl<$Res> implements _$DeleteCodeCopyWith<$Res> {
  __$DeleteCodeCopyWithImpl(this._self, this._then);

  final _DeleteCode _self;
  final $Res Function(_DeleteCode) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_DeleteCode(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _SearchCodes implements HistoryEvent {
  const _SearchCodes({required this.query});

  final String query;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchCodesCopyWith<_SearchCodes> get copyWith =>
      __$SearchCodesCopyWithImpl<_SearchCodes>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchCodes &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, query);
  }

  @override
  String toString() {
    return 'HistoryEvent.searchCodes(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$SearchCodesCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$SearchCodesCopyWith(
          _SearchCodes value, $Res Function(_SearchCodes) _then) =
      __$SearchCodesCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$SearchCodesCopyWithImpl<$Res> implements _$SearchCodesCopyWith<$Res> {
  __$SearchCodesCopyWithImpl(this._self, this._then);

  final _SearchCodes _self;
  final $Res Function(_SearchCodes) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_SearchCodes(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ResetFlowStep implements HistoryEvent {
  const _ResetFlowStep();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ResetFlowStep);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent.resetFlowStep()';
  }
}

/// @nodoc

class _Reset implements HistoryEvent {
  const _Reset();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _Reset);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent.reset()';
  }
}

/// @nodoc

class _EnterSelectionMode implements HistoryEvent {
  const _EnterSelectionMode({required this.id});

  final String id;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$EnterSelectionModeCopyWith<_EnterSelectionMode> get copyWith =>
      __$EnterSelectionModeCopyWithImpl<_EnterSelectionMode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _EnterSelectionMode &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id);
  }

  @override
  String toString() {
    return 'HistoryEvent.enterSelectionMode(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$EnterSelectionModeCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$EnterSelectionModeCopyWith(
          _EnterSelectionMode value, $Res Function(_EnterSelectionMode) _then) =
      __$EnterSelectionModeCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$EnterSelectionModeCopyWithImpl<$Res>
    implements _$EnterSelectionModeCopyWith<$Res> {
  __$EnterSelectionModeCopyWithImpl(this._self, this._then);

  final _EnterSelectionMode _self;
  final $Res Function(_EnterSelectionMode) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_EnterSelectionMode(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _ToggleItemSelection implements HistoryEvent {
  const _ToggleItemSelection({required this.id});

  final String id;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ToggleItemSelectionCopyWith<_ToggleItemSelection> get copyWith =>
      __$ToggleItemSelectionCopyWithImpl<_ToggleItemSelection>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ToggleItemSelection &&
            (identical(other.id, id) || other.id == id));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id);
  }

  @override
  String toString() {
    return 'HistoryEvent.toggleItemSelection(id: $id)';
  }
}

/// @nodoc
abstract mixin class _$ToggleItemSelectionCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$ToggleItemSelectionCopyWith(_ToggleItemSelection value,
          $Res Function(_ToggleItemSelection) _then) =
      __$ToggleItemSelectionCopyWithImpl;
  @useResult
  $Res call({String id});
}

/// @nodoc
class __$ToggleItemSelectionCopyWithImpl<$Res>
    implements _$ToggleItemSelectionCopyWith<$Res> {
  __$ToggleItemSelectionCopyWithImpl(this._self, this._then);

  final _ToggleItemSelection _self;
  final $Res Function(_ToggleItemSelection) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
  }) {
    return _then(_ToggleItemSelection(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _SelectAllCodes implements HistoryEvent {
  const _SelectAllCodes();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _SelectAllCodes);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent.selectAllCodes()';
  }
}

/// @nodoc

class _ExitSelectionMode implements HistoryEvent {
  const _ExitSelectionMode();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _ExitSelectionMode);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent.exitSelectionMode()';
  }
}

/// @nodoc

class _DeleteSelectedCodes implements HistoryEvent {
  const _DeleteSelectedCodes();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _DeleteSelectedCodes);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'HistoryEvent.deleteSelectedCodes()';
  }
}

/// @nodoc

class _ExportSavedCodes implements HistoryEvent {
  const _ExportSavedCodes({Set<String>? ids}) : _ids = ids;

  final Set<String>? _ids;
  Set<String>? get ids {
    final value = _ids;
    if (value == null) return null;
    if (_ids is EqualUnmodifiableSetView) return _ids;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(value);
  }

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ExportSavedCodesCopyWith<_ExportSavedCodes> get copyWith =>
      __$ExportSavedCodesCopyWithImpl<_ExportSavedCodes>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ExportSavedCodes &&
            const DeepCollectionEquality().equals(other.ids, _ids));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, const DeepCollectionEquality().hash(_ids));
  }

  @override
  String toString() {
    return 'HistoryEvent.exportSavedCodes(ids: $ids)';
  }
}

/// @nodoc
abstract mixin class _$ExportSavedCodesCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$ExportSavedCodesCopyWith(
          _ExportSavedCodes value, $Res Function(_ExportSavedCodes) _then) =
      __$ExportSavedCodesCopyWithImpl;
  @useResult
  $Res call({Set<String>? ids});
}

/// @nodoc
class __$ExportSavedCodesCopyWithImpl<$Res>
    implements _$ExportSavedCodesCopyWith<$Res> {
  __$ExportSavedCodesCopyWithImpl(this._self, this._then);

  final _ExportSavedCodes _self;
  final $Res Function(_ExportSavedCodes) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? ids = freezed,
  }) {
    return _then(_ExportSavedCodes(
      ids: freezed == ids
          ? _self._ids
          : ids // ignore: cast_nullable_to_non_nullable
              as Set<String>?,
    ));
  }
}

/// @nodoc

class _ImportSavedCodes implements HistoryEvent {
  const _ImportSavedCodes({required this.content});

  final String content;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ImportSavedCodesCopyWith<_ImportSavedCodes> get copyWith =>
      __$ImportSavedCodesCopyWithImpl<_ImportSavedCodes>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ImportSavedCodes &&
            (identical(other.content, content) || other.content == content));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, content);
  }

  @override
  String toString() {
    return 'HistoryEvent.importSavedCodes(content: $content)';
  }
}

/// @nodoc
abstract mixin class _$ImportSavedCodesCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$ImportSavedCodesCopyWith(
          _ImportSavedCodes value, $Res Function(_ImportSavedCodes) _then) =
      __$ImportSavedCodesCopyWithImpl;
  @useResult
  $Res call({String content});
}

/// @nodoc
class __$ImportSavedCodesCopyWithImpl<$Res>
    implements _$ImportSavedCodesCopyWith<$Res> {
  __$ImportSavedCodesCopyWithImpl(this._self, this._then);

  final _ImportSavedCodes _self;
  final $Res Function(_ImportSavedCodes) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? content = null,
  }) {
    return _then(_ImportSavedCodes(
      content: null == content
          ? _self.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _UpdateLabel implements HistoryEvent {
  const _UpdateLabel({required this.id, this.label});

  final String id;
  final String? label;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateLabelCopyWith<_UpdateLabel> get copyWith =>
      __$UpdateLabelCopyWithImpl<_UpdateLabel>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateLabel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.label, label) || other.label == label));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, label);
  }

  @override
  String toString() {
    return 'HistoryEvent.updateLabel(id: $id, label: $label)';
  }
}

/// @nodoc
abstract mixin class _$UpdateLabelCopyWith<$Res>
    implements $HistoryEventCopyWith<$Res> {
  factory _$UpdateLabelCopyWith(
          _UpdateLabel value, $Res Function(_UpdateLabel) _then) =
      __$UpdateLabelCopyWithImpl;
  @useResult
  $Res call({String id, String? label});
}

/// @nodoc
class __$UpdateLabelCopyWithImpl<$Res> implements _$UpdateLabelCopyWith<$Res> {
  __$UpdateLabelCopyWithImpl(this._self, this._then);

  final _UpdateLabel _self;
  final $Res Function(_UpdateLabel) _then;

  /// Create a copy of HistoryEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? label = freezed,
  }) {
    return _then(_UpdateLabel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
mixin _$HistoryState {
  List<SavedCode> get savedCodes;
  GenericStatus get historyStatus;
  GenericStatus get historyActionStatus;
  GenericFlowStep get flowStep;
  String? get historyErrorMessage;
  String? get historyActionErrorMessage;
  bool get isSelectionMode;
  Set<String> get selectedIds;
  int? get lastDeletedCount;

  /// Path of the file written by the last export, ready to share.
  String? get exportFilePath;
  int? get lastImportAdded;
  int? get lastImportSkipped;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HistoryStateCopyWith<HistoryState> get copyWith =>
      _$HistoryStateCopyWithImpl<HistoryState>(
          this as HistoryState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as HistoryState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HistoryState &&
            const DeepCollectionEquality()
                .equals(other.savedCodes, _this.savedCodes) &&
            (identical(other.historyStatus, _this.historyStatus) ||
                other.historyStatus == _this.historyStatus) &&
            (identical(other.historyActionStatus, _this.historyActionStatus) ||
                other.historyActionStatus == _this.historyActionStatus) &&
            (identical(other.flowStep, _this.flowStep) ||
                other.flowStep == _this.flowStep) &&
            (identical(other.historyErrorMessage, _this.historyErrorMessage) ||
                other.historyErrorMessage == _this.historyErrorMessage) &&
            (identical(other.historyActionErrorMessage,
                    _this.historyActionErrorMessage) ||
                other.historyActionErrorMessage ==
                    _this.historyActionErrorMessage) &&
            (identical(other.isSelectionMode, _this.isSelectionMode) ||
                other.isSelectionMode == _this.isSelectionMode) &&
            const DeepCollectionEquality()
                .equals(other.selectedIds, _this.selectedIds) &&
            (identical(other.lastDeletedCount, _this.lastDeletedCount) ||
                other.lastDeletedCount == _this.lastDeletedCount) &&
            (identical(other.exportFilePath, _this.exportFilePath) ||
                other.exportFilePath == _this.exportFilePath) &&
            (identical(other.lastImportAdded, _this.lastImportAdded) ||
                other.lastImportAdded == _this.lastImportAdded) &&
            (identical(other.lastImportSkipped, _this.lastImportSkipped) ||
                other.lastImportSkipped == _this.lastImportSkipped));
  }

  @override
  int get hashCode {
    final _this = this as HistoryState;
    return Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_this.savedCodes),
        _this.historyStatus,
        _this.historyActionStatus,
        _this.flowStep,
        _this.historyErrorMessage,
        _this.historyActionErrorMessage,
        _this.isSelectionMode,
        const DeepCollectionEquality().hash(_this.selectedIds),
        _this.lastDeletedCount,
        _this.exportFilePath,
        _this.lastImportAdded,
        _this.lastImportSkipped);
  }

  @override
  String toString() {
    final _this = this as HistoryState;
    return 'HistoryState(savedCodes: ${_this.savedCodes}, historyStatus: ${_this.historyStatus}, historyActionStatus: ${_this.historyActionStatus}, flowStep: ${_this.flowStep}, historyErrorMessage: ${_this.historyErrorMessage}, historyActionErrorMessage: ${_this.historyActionErrorMessage}, isSelectionMode: ${_this.isSelectionMode}, selectedIds: ${_this.selectedIds}, lastDeletedCount: ${_this.lastDeletedCount}, exportFilePath: ${_this.exportFilePath}, lastImportAdded: ${_this.lastImportAdded}, lastImportSkipped: ${_this.lastImportSkipped})';
  }
}

/// @nodoc
abstract mixin class $HistoryStateCopyWith<$Res> {
  factory $HistoryStateCopyWith(
          HistoryState value, $Res Function(HistoryState) _then) =
      _$HistoryStateCopyWithImpl;
  @useResult
  $Res call(
      {List<SavedCode> savedCodes,
      GenericStatus historyStatus,
      GenericStatus historyActionStatus,
      GenericFlowStep flowStep,
      String? historyErrorMessage,
      String? historyActionErrorMessage,
      bool isSelectionMode,
      Set<String> selectedIds,
      int? lastDeletedCount,
      String? exportFilePath,
      int? lastImportAdded,
      int? lastImportSkipped});
}

/// @nodoc
class _$HistoryStateCopyWithImpl<$Res> implements $HistoryStateCopyWith<$Res> {
  _$HistoryStateCopyWithImpl(this._self, this._then);

  final HistoryState _self;
  final $Res Function(HistoryState) _then;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? savedCodes = null,
    Object? historyStatus = null,
    Object? historyActionStatus = null,
    Object? flowStep = null,
    Object? historyErrorMessage = freezed,
    Object? historyActionErrorMessage = freezed,
    Object? isSelectionMode = null,
    Object? selectedIds = null,
    Object? lastDeletedCount = freezed,
    Object? exportFilePath = freezed,
    Object? lastImportAdded = freezed,
    Object? lastImportSkipped = freezed,
  }) {
    return _then(HistoryState(
      savedCodes: null == savedCodes
          ? _self.savedCodes
          : savedCodes // ignore: cast_nullable_to_non_nullable
              as List<SavedCode>,
      historyStatus: null == historyStatus
          ? _self.historyStatus
          : historyStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      historyActionStatus: null == historyActionStatus
          ? _self.historyActionStatus
          : historyActionStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      flowStep: null == flowStep
          ? _self.flowStep
          : flowStep // ignore: cast_nullable_to_non_nullable
              as GenericFlowStep,
      historyErrorMessage: freezed == historyErrorMessage
          ? _self.historyErrorMessage
          : historyErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      historyActionErrorMessage: freezed == historyActionErrorMessage
          ? _self.historyActionErrorMessage
          : historyActionErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSelectionMode: null == isSelectionMode
          ? _self.isSelectionMode
          : isSelectionMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedIds: null == selectedIds
          ? _self.selectedIds
          : selectedIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      lastDeletedCount: freezed == lastDeletedCount
          ? _self.lastDeletedCount
          : lastDeletedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      exportFilePath: freezed == exportFilePath
          ? _self.exportFilePath
          : exportFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      lastImportAdded: freezed == lastImportAdded
          ? _self.lastImportAdded
          : lastImportAdded // ignore: cast_nullable_to_non_nullable
              as int?,
      lastImportSkipped: freezed == lastImportSkipped
          ? _self.lastImportSkipped
          : lastImportSkipped // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// Adds pattern-matching-related methods to [HistoryState].
extension HistoryStatePatterns on HistoryState {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_HistoryState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HistoryState() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_HistoryState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HistoryState():
        return $default(_that);
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_HistoryState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HistoryState() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            List<SavedCode> savedCodes,
            GenericStatus historyStatus,
            GenericStatus historyActionStatus,
            GenericFlowStep flowStep,
            String? historyErrorMessage,
            String? historyActionErrorMessage,
            bool isSelectionMode,
            Set<String> selectedIds,
            int? lastDeletedCount,
            String? exportFilePath,
            int? lastImportAdded,
            int? lastImportSkipped)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _HistoryState() when $default != null:
        return $default(
            _that.savedCodes,
            _that.historyStatus,
            _that.historyActionStatus,
            _that.flowStep,
            _that.historyErrorMessage,
            _that.historyActionErrorMessage,
            _that.isSelectionMode,
            _that.selectedIds,
            _that.lastDeletedCount,
            _that.exportFilePath,
            _that.lastImportAdded,
            _that.lastImportSkipped);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            List<SavedCode> savedCodes,
            GenericStatus historyStatus,
            GenericStatus historyActionStatus,
            GenericFlowStep flowStep,
            String? historyErrorMessage,
            String? historyActionErrorMessage,
            bool isSelectionMode,
            Set<String> selectedIds,
            int? lastDeletedCount,
            String? exportFilePath,
            int? lastImportAdded,
            int? lastImportSkipped)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HistoryState():
        return $default(
            _that.savedCodes,
            _that.historyStatus,
            _that.historyActionStatus,
            _that.flowStep,
            _that.historyErrorMessage,
            _that.historyActionErrorMessage,
            _that.isSelectionMode,
            _that.selectedIds,
            _that.lastDeletedCount,
            _that.exportFilePath,
            _that.lastImportAdded,
            _that.lastImportSkipped);
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            List<SavedCode> savedCodes,
            GenericStatus historyStatus,
            GenericStatus historyActionStatus,
            GenericFlowStep flowStep,
            String? historyErrorMessage,
            String? historyActionErrorMessage,
            bool isSelectionMode,
            Set<String> selectedIds,
            int? lastDeletedCount,
            String? exportFilePath,
            int? lastImportAdded,
            int? lastImportSkipped)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _HistoryState() when $default != null:
        return $default(
            _that.savedCodes,
            _that.historyStatus,
            _that.historyActionStatus,
            _that.flowStep,
            _that.historyErrorMessage,
            _that.historyActionErrorMessage,
            _that.isSelectionMode,
            _that.selectedIds,
            _that.lastDeletedCount,
            _that.exportFilePath,
            _that.lastImportAdded,
            _that.lastImportSkipped);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HistoryState implements HistoryState {
  const _HistoryState(
      {List<SavedCode> savedCodes = const [],
      this.historyStatus = GenericStatus.initial,
      this.historyActionStatus = GenericStatus.initial,
      this.flowStep = GenericFlowStep.none,
      this.historyErrorMessage,
      this.historyActionErrorMessage,
      this.isSelectionMode = false,
      Set<String> selectedIds = const <String>{},
      this.lastDeletedCount,
      this.exportFilePath,
      this.lastImportAdded,
      this.lastImportSkipped})
      : _savedCodes = savedCodes,
        _selectedIds = selectedIds;

  final List<SavedCode> _savedCodes;
  @override
  @JsonKey()
  List<SavedCode> get savedCodes {
    if (_savedCodes is EqualUnmodifiableListView) return _savedCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedCodes);
  }

  @override
  @JsonKey()
  final GenericStatus historyStatus;
  @override
  @JsonKey()
  final GenericStatus historyActionStatus;
  @override
  @JsonKey()
  final GenericFlowStep flowStep;
  @override
  final String? historyErrorMessage;
  @override
  final String? historyActionErrorMessage;
  @override
  @JsonKey()
  final bool isSelectionMode;
  final Set<String> _selectedIds;
  @override
  @JsonKey()
  Set<String> get selectedIds {
    if (_selectedIds is EqualUnmodifiableSetView) return _selectedIds;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableSetView(_selectedIds);
  }

  @override
  final int? lastDeletedCount;

  /// Path of the file written by the last export, ready to share.
  @override
  final String? exportFilePath;
  @override
  final int? lastImportAdded;
  @override
  final int? lastImportSkipped;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$HistoryStateCopyWith<_HistoryState> get copyWith =>
      __$HistoryStateCopyWithImpl<_HistoryState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _HistoryState &&
            const DeepCollectionEquality()
                .equals(other.savedCodes, _savedCodes) &&
            (identical(other.historyStatus, historyStatus) ||
                other.historyStatus == historyStatus) &&
            (identical(other.historyActionStatus, historyActionStatus) ||
                other.historyActionStatus == historyActionStatus) &&
            (identical(other.flowStep, flowStep) ||
                other.flowStep == flowStep) &&
            (identical(other.historyErrorMessage, historyErrorMessage) ||
                other.historyErrorMessage == historyErrorMessage) &&
            (identical(other.historyActionErrorMessage,
                    historyActionErrorMessage) ||
                other.historyActionErrorMessage == historyActionErrorMessage) &&
            (identical(other.isSelectionMode, isSelectionMode) ||
                other.isSelectionMode == isSelectionMode) &&
            const DeepCollectionEquality()
                .equals(other.selectedIds, _selectedIds) &&
            (identical(other.lastDeletedCount, lastDeletedCount) ||
                other.lastDeletedCount == lastDeletedCount) &&
            (identical(other.exportFilePath, exportFilePath) ||
                other.exportFilePath == exportFilePath) &&
            (identical(other.lastImportAdded, lastImportAdded) ||
                other.lastImportAdded == lastImportAdded) &&
            (identical(other.lastImportSkipped, lastImportSkipped) ||
                other.lastImportSkipped == lastImportSkipped));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        const DeepCollectionEquality().hash(_savedCodes),
        historyStatus,
        historyActionStatus,
        flowStep,
        historyErrorMessage,
        historyActionErrorMessage,
        isSelectionMode,
        const DeepCollectionEquality().hash(_selectedIds),
        lastDeletedCount,
        exportFilePath,
        lastImportAdded,
        lastImportSkipped);
  }

  @override
  String toString() {
    return 'HistoryState(savedCodes: $savedCodes, historyStatus: $historyStatus, historyActionStatus: $historyActionStatus, flowStep: $flowStep, historyErrorMessage: $historyErrorMessage, historyActionErrorMessage: $historyActionErrorMessage, isSelectionMode: $isSelectionMode, selectedIds: $selectedIds, lastDeletedCount: $lastDeletedCount, exportFilePath: $exportFilePath, lastImportAdded: $lastImportAdded, lastImportSkipped: $lastImportSkipped)';
  }
}

/// @nodoc
abstract mixin class _$HistoryStateCopyWith<$Res>
    implements $HistoryStateCopyWith<$Res> {
  factory _$HistoryStateCopyWith(
          _HistoryState value, $Res Function(_HistoryState) _then) =
      __$HistoryStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {List<SavedCode> savedCodes,
      GenericStatus historyStatus,
      GenericStatus historyActionStatus,
      GenericFlowStep flowStep,
      String? historyErrorMessage,
      String? historyActionErrorMessage,
      bool isSelectionMode,
      Set<String> selectedIds,
      int? lastDeletedCount,
      String? exportFilePath,
      int? lastImportAdded,
      int? lastImportSkipped});
}

/// @nodoc
class __$HistoryStateCopyWithImpl<$Res>
    implements _$HistoryStateCopyWith<$Res> {
  __$HistoryStateCopyWithImpl(this._self, this._then);

  final _HistoryState _self;
  final $Res Function(_HistoryState) _then;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? savedCodes = null,
    Object? historyStatus = null,
    Object? historyActionStatus = null,
    Object? flowStep = null,
    Object? historyErrorMessage = freezed,
    Object? historyActionErrorMessage = freezed,
    Object? isSelectionMode = null,
    Object? selectedIds = null,
    Object? lastDeletedCount = freezed,
    Object? exportFilePath = freezed,
    Object? lastImportAdded = freezed,
    Object? lastImportSkipped = freezed,
  }) {
    return _then(_HistoryState(
      savedCodes: null == savedCodes
          ? _self._savedCodes
          : savedCodes // ignore: cast_nullable_to_non_nullable
              as List<SavedCode>,
      historyStatus: null == historyStatus
          ? _self.historyStatus
          : historyStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      historyActionStatus: null == historyActionStatus
          ? _self.historyActionStatus
          : historyActionStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      flowStep: null == flowStep
          ? _self.flowStep
          : flowStep // ignore: cast_nullable_to_non_nullable
              as GenericFlowStep,
      historyErrorMessage: freezed == historyErrorMessage
          ? _self.historyErrorMessage
          : historyErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      historyActionErrorMessage: freezed == historyActionErrorMessage
          ? _self.historyActionErrorMessage
          : historyActionErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      isSelectionMode: null == isSelectionMode
          ? _self.isSelectionMode
          : isSelectionMode // ignore: cast_nullable_to_non_nullable
              as bool,
      selectedIds: null == selectedIds
          ? _self._selectedIds
          : selectedIds // ignore: cast_nullable_to_non_nullable
              as Set<String>,
      lastDeletedCount: freezed == lastDeletedCount
          ? _self.lastDeletedCount
          : lastDeletedCount // ignore: cast_nullable_to_non_nullable
              as int?,
      exportFilePath: freezed == exportFilePath
          ? _self.exportFilePath
          : exportFilePath // ignore: cast_nullable_to_non_nullable
              as String?,
      lastImportAdded: freezed == lastImportAdded
          ? _self.lastImportAdded
          : lastImportAdded // ignore: cast_nullable_to_non_nullable
              as int?,
      lastImportSkipped: freezed == lastImportSkipped
          ? _self.lastImportSkipped
          : lastImportSkipped // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

// dart format on
