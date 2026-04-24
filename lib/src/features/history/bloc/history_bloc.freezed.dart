// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

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
  int get hashCode => Object.hash(runtimeType, code);

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
  int get hashCode => Object.hash(runtimeType, id);

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
  int get hashCode => Object.hash(runtimeType, query);

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
mixin _$HistoryState {
  List<SavedCode> get savedCodes; // --- Status fields (scoped per RULE-006) ---
  GenericStatus get historyStatus;
  GenericStatus
      get historyActionStatus; // --- Flow step (for CRUD per RULE-004) ---
  GenericFlowStep get flowStep; // --- Error messages (per RULE-007) ---
  String? get historyErrorMessage;
  String? get historyActionErrorMessage;

  /// Create a copy of HistoryState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $HistoryStateCopyWith<HistoryState> get copyWith =>
      _$HistoryStateCopyWithImpl<HistoryState>(
          this as HistoryState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is HistoryState &&
            const DeepCollectionEquality()
                .equals(other.savedCodes, savedCodes) &&
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
                other.historyActionErrorMessage == historyActionErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(savedCodes),
      historyStatus,
      historyActionStatus,
      flowStep,
      historyErrorMessage,
      historyActionErrorMessage);

  @override
  String toString() {
    return 'HistoryState(savedCodes: $savedCodes, historyStatus: $historyStatus, historyActionStatus: $historyActionStatus, flowStep: $flowStep, historyErrorMessage: $historyErrorMessage, historyActionErrorMessage: $historyActionErrorMessage)';
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
      String? historyActionErrorMessage});
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
  }) {
    return _then(_self.copyWith(
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
            String? historyActionErrorMessage)?
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
            _that.historyActionErrorMessage);
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
            String? historyActionErrorMessage)
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
            _that.historyActionErrorMessage);
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
            String? historyActionErrorMessage)?
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
            _that.historyActionErrorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _HistoryState implements HistoryState {
  const _HistoryState(
      {final List<SavedCode> savedCodes = const [],
      this.historyStatus = GenericStatus.initial,
      this.historyActionStatus = GenericStatus.initial,
      this.flowStep = GenericFlowStep.none,
      this.historyErrorMessage,
      this.historyActionErrorMessage})
      : _savedCodes = savedCodes;

  final List<SavedCode> _savedCodes;
  @override
  @JsonKey()
  List<SavedCode> get savedCodes {
    if (_savedCodes is EqualUnmodifiableListView) return _savedCodes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_savedCodes);
  }

// --- Status fields (scoped per RULE-006) ---
  @override
  @JsonKey()
  final GenericStatus historyStatus;
  @override
  @JsonKey()
  final GenericStatus historyActionStatus;
// --- Flow step (for CRUD per RULE-004) ---
  @override
  @JsonKey()
  final GenericFlowStep flowStep;
// --- Error messages (per RULE-007) ---
  @override
  final String? historyErrorMessage;
  @override
  final String? historyActionErrorMessage;

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
                .equals(other._savedCodes, _savedCodes) &&
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
                other.historyActionErrorMessage == historyActionErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_savedCodes),
      historyStatus,
      historyActionStatus,
      flowStep,
      historyErrorMessage,
      historyActionErrorMessage);

  @override
  String toString() {
    return 'HistoryState(savedCodes: $savedCodes, historyStatus: $historyStatus, historyActionStatus: $historyActionStatus, flowStep: $flowStep, historyErrorMessage: $historyErrorMessage, historyActionErrorMessage: $historyActionErrorMessage)';
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
      String? historyActionErrorMessage});
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
    ));
  }
}

// dart format on
