// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'decode_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DecodeEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is DecodeEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'DecodeEvent()';
  }
}

/// @nodoc
class $DecodeEventCopyWith<$Res> {
  $DecodeEventCopyWith(DecodeEvent _, $Res Function(DecodeEvent) __);
}

/// Adds pattern-matching-related methods to [DecodeEvent].
extension DecodeEventPatterns on DecodeEvent {
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
    TResult Function(_DecodePlusCode value)? decodePlusCode,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _DecodePlusCode() when decodePlusCode != null:
        return decodePlusCode(_that);
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
    required TResult Function(_DecodePlusCode value) decodePlusCode,
    required TResult Function(_Reset value) reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init(_that);
      case _DecodePlusCode():
        return decodePlusCode(_that);
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
    TResult? Function(_DecodePlusCode value)? decodePlusCode,
    TResult? Function(_Reset value)? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _DecodePlusCode() when decodePlusCode != null:
        return decodePlusCode(_that);
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
    TResult Function(String code)? decodePlusCode,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _DecodePlusCode() when decodePlusCode != null:
        return decodePlusCode(_that.code);
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
    required TResult Function(String code) decodePlusCode,
    required TResult Function() reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init();
      case _DecodePlusCode():
        return decodePlusCode(_that.code);
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
    TResult? Function(String code)? decodePlusCode,
    TResult? Function()? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _DecodePlusCode() when decodePlusCode != null:
        return decodePlusCode(_that.code);
      case _Reset() when reset != null:
        return reset();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Init implements DecodeEvent {
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
    return 'DecodeEvent.init()';
  }
}

/// @nodoc

class _DecodePlusCode implements DecodeEvent {
  const _DecodePlusCode({required this.code});

  final String code;

  /// Create a copy of DecodeEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DecodePlusCodeCopyWith<_DecodePlusCode> get copyWith =>
      __$DecodePlusCodeCopyWithImpl<_DecodePlusCode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DecodePlusCode &&
            (identical(other.code, code) || other.code == code));
  }

  @override
  int get hashCode => Object.hash(runtimeType, code);

  @override
  String toString() {
    return 'DecodeEvent.decodePlusCode(code: $code)';
  }
}

/// @nodoc
abstract mixin class _$DecodePlusCodeCopyWith<$Res>
    implements $DecodeEventCopyWith<$Res> {
  factory _$DecodePlusCodeCopyWith(
          _DecodePlusCode value, $Res Function(_DecodePlusCode) _then) =
      __$DecodePlusCodeCopyWithImpl;
  @useResult
  $Res call({String code});
}

/// @nodoc
class __$DecodePlusCodeCopyWithImpl<$Res>
    implements _$DecodePlusCodeCopyWith<$Res> {
  __$DecodePlusCodeCopyWithImpl(this._self, this._then);

  final _DecodePlusCode _self;
  final $Res Function(_DecodePlusCode) _then;

  /// Create a copy of DecodeEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? code = null,
  }) {
    return _then(_DecodePlusCode(
      code: null == code
          ? _self.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Reset implements DecodeEvent {
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
    return 'DecodeEvent.reset()';
  }
}

/// @nodoc
mixin _$DecodeState {
  GenericStatus get decodeStatus;
  PlusCode? get decodedResult;
  String? get decodeErrorMessage;

  /// Create a copy of DecodeState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DecodeStateCopyWith<DecodeState> get copyWith =>
      _$DecodeStateCopyWithImpl<DecodeState>(this as DecodeState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DecodeState &&
            (identical(other.decodeStatus, decodeStatus) ||
                other.decodeStatus == decodeStatus) &&
            (identical(other.decodedResult, decodedResult) ||
                other.decodedResult == decodedResult) &&
            (identical(other.decodeErrorMessage, decodeErrorMessage) ||
                other.decodeErrorMessage == decodeErrorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, decodeStatus, decodedResult, decodeErrorMessage);

  @override
  String toString() {
    return 'DecodeState(decodeStatus: $decodeStatus, decodedResult: $decodedResult, decodeErrorMessage: $decodeErrorMessage)';
  }
}

/// @nodoc
abstract mixin class $DecodeStateCopyWith<$Res> {
  factory $DecodeStateCopyWith(
          DecodeState value, $Res Function(DecodeState) _then) =
      _$DecodeStateCopyWithImpl;
  @useResult
  $Res call(
      {GenericStatus decodeStatus,
      PlusCode? decodedResult,
      String? decodeErrorMessage});

  $PlusCodeCopyWith<$Res>? get decodedResult;
}

/// @nodoc
class _$DecodeStateCopyWithImpl<$Res> implements $DecodeStateCopyWith<$Res> {
  _$DecodeStateCopyWithImpl(this._self, this._then);

  final DecodeState _self;
  final $Res Function(DecodeState) _then;

  /// Create a copy of DecodeState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? decodeStatus = null,
    Object? decodedResult = freezed,
    Object? decodeErrorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      decodeStatus: null == decodeStatus
          ? _self.decodeStatus
          : decodeStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      decodedResult: freezed == decodedResult
          ? _self.decodedResult
          : decodedResult // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      decodeErrorMessage: freezed == decodeErrorMessage
          ? _self.decodeErrorMessage
          : decodeErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of DecodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get decodedResult {
    if (_self.decodedResult == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.decodedResult!, (value) {
      return _then(_self.copyWith(decodedResult: value));
    });
  }
}

/// Adds pattern-matching-related methods to [DecodeState].
extension DecodeStatePatterns on DecodeState {
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
    TResult Function(_DecodeState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DecodeState() when $default != null:
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
    TResult Function(_DecodeState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DecodeState():
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
    TResult? Function(_DecodeState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DecodeState() when $default != null:
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
    TResult Function(GenericStatus decodeStatus, PlusCode? decodedResult,
            String? decodeErrorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DecodeState() when $default != null:
        return $default(
            _that.decodeStatus, _that.decodedResult, _that.decodeErrorMessage);
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
    TResult Function(GenericStatus decodeStatus, PlusCode? decodedResult,
            String? decodeErrorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DecodeState():
        return $default(
            _that.decodeStatus, _that.decodedResult, _that.decodeErrorMessage);
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
    TResult? Function(GenericStatus decodeStatus, PlusCode? decodedResult,
            String? decodeErrorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DecodeState() when $default != null:
        return $default(
            _that.decodeStatus, _that.decodedResult, _that.decodeErrorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DecodeState implements DecodeState {
  const _DecodeState(
      {this.decodeStatus = GenericStatus.initial,
      this.decodedResult,
      this.decodeErrorMessage});

  @override
  @JsonKey()
  final GenericStatus decodeStatus;
  @override
  final PlusCode? decodedResult;
  @override
  final String? decodeErrorMessage;

  /// Create a copy of DecodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DecodeStateCopyWith<_DecodeState> get copyWith =>
      __$DecodeStateCopyWithImpl<_DecodeState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DecodeState &&
            (identical(other.decodeStatus, decodeStatus) ||
                other.decodeStatus == decodeStatus) &&
            (identical(other.decodedResult, decodedResult) ||
                other.decodedResult == decodedResult) &&
            (identical(other.decodeErrorMessage, decodeErrorMessage) ||
                other.decodeErrorMessage == decodeErrorMessage));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, decodeStatus, decodedResult, decodeErrorMessage);

  @override
  String toString() {
    return 'DecodeState(decodeStatus: $decodeStatus, decodedResult: $decodedResult, decodeErrorMessage: $decodeErrorMessage)';
  }
}

/// @nodoc
abstract mixin class _$DecodeStateCopyWith<$Res>
    implements $DecodeStateCopyWith<$Res> {
  factory _$DecodeStateCopyWith(
          _DecodeState value, $Res Function(_DecodeState) _then) =
      __$DecodeStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {GenericStatus decodeStatus,
      PlusCode? decodedResult,
      String? decodeErrorMessage});

  @override
  $PlusCodeCopyWith<$Res>? get decodedResult;
}

/// @nodoc
class __$DecodeStateCopyWithImpl<$Res> implements _$DecodeStateCopyWith<$Res> {
  __$DecodeStateCopyWithImpl(this._self, this._then);

  final _DecodeState _self;
  final $Res Function(_DecodeState) _then;

  /// Create a copy of DecodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? decodeStatus = null,
    Object? decodedResult = freezed,
    Object? decodeErrorMessage = freezed,
  }) {
    return _then(_DecodeState(
      decodeStatus: null == decodeStatus
          ? _self.decodeStatus
          : decodeStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      decodedResult: freezed == decodedResult
          ? _self.decodedResult
          : decodedResult // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      decodeErrorMessage: freezed == decodeErrorMessage
          ? _self.decodeErrorMessage
          : decodeErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of DecodeState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get decodedResult {
    if (_self.decodedResult == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.decodedResult!, (value) {
      return _then(_self.copyWith(decodedResult: value));
    });
  }
}

// dart format on
