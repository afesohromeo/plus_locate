// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'generate_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GenerateEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is GenerateEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'GenerateEvent()';
  }
}

/// @nodoc
class $GenerateEventCopyWith<$Res> {
  $GenerateEventCopyWith(GenerateEvent _, $Res Function(GenerateEvent) __);
}

/// Adds pattern-matching-related methods to [GenerateEvent].
extension GenerateEventPatterns on GenerateEvent {
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
    TResult Function(_GenerateFromCoordinates value)? generateFromCoordinates,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _GenerateFromCoordinates() when generateFromCoordinates != null:
        return generateFromCoordinates(_that);
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
    required TResult Function(_GenerateFromCoordinates value)
        generateFromCoordinates,
    required TResult Function(_Reset value) reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init(_that);
      case _GenerateFromCoordinates():
        return generateFromCoordinates(_that);
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
    TResult? Function(_GenerateFromCoordinates value)? generateFromCoordinates,
    TResult? Function(_Reset value)? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _GenerateFromCoordinates() when generateFromCoordinates != null:
        return generateFromCoordinates(_that);
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
    TResult Function(double latitude, double longitude)?
        generateFromCoordinates,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _GenerateFromCoordinates() when generateFromCoordinates != null:
        return generateFromCoordinates(_that.latitude, _that.longitude);
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
    required TResult Function(double latitude, double longitude)
        generateFromCoordinates,
    required TResult Function() reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init();
      case _GenerateFromCoordinates():
        return generateFromCoordinates(_that.latitude, _that.longitude);
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
    TResult? Function(double latitude, double longitude)?
        generateFromCoordinates,
    TResult? Function()? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _GenerateFromCoordinates() when generateFromCoordinates != null:
        return generateFromCoordinates(_that.latitude, _that.longitude);
      case _Reset() when reset != null:
        return reset();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Init implements GenerateEvent {
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
    return 'GenerateEvent.init()';
  }
}

/// @nodoc

class _GenerateFromCoordinates implements GenerateEvent {
  const _GenerateFromCoordinates(
      {required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  /// Create a copy of GenerateEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenerateFromCoordinatesCopyWith<_GenerateFromCoordinates> get copyWith =>
      __$GenerateFromCoordinatesCopyWithImpl<_GenerateFromCoordinates>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenerateFromCoordinates &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @override
  String toString() {
    return 'GenerateEvent.generateFromCoordinates(latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$GenerateFromCoordinatesCopyWith<$Res>
    implements $GenerateEventCopyWith<$Res> {
  factory _$GenerateFromCoordinatesCopyWith(_GenerateFromCoordinates value,
          $Res Function(_GenerateFromCoordinates) _then) =
      __$GenerateFromCoordinatesCopyWithImpl;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$GenerateFromCoordinatesCopyWithImpl<$Res>
    implements _$GenerateFromCoordinatesCopyWith<$Res> {
  __$GenerateFromCoordinatesCopyWithImpl(this._self, this._then);

  final _GenerateFromCoordinates _self;
  final $Res Function(_GenerateFromCoordinates) _then;

  /// Create a copy of GenerateEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_GenerateFromCoordinates(
      latitude: null == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc

class _Reset implements GenerateEvent {
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
    return 'GenerateEvent.reset()';
  }
}

/// @nodoc
mixin _$GenerateState {
  GenericStatus get generateStatus;
  PlusCode? get generatedCode;
  String? get generateErrorMessage;

  /// Create a copy of GenerateState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GenerateStateCopyWith<GenerateState> get copyWith =>
      _$GenerateStateCopyWithImpl<GenerateState>(
          this as GenerateState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GenerateState &&
            (identical(other.generateStatus, generateStatus) ||
                other.generateStatus == generateStatus) &&
            (identical(other.generatedCode, generatedCode) ||
                other.generatedCode == generatedCode) &&
            (identical(other.generateErrorMessage, generateErrorMessage) ||
                other.generateErrorMessage == generateErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, generateStatus, generatedCode, generateErrorMessage);

  @override
  String toString() {
    return 'GenerateState(generateStatus: $generateStatus, generatedCode: $generatedCode, generateErrorMessage: $generateErrorMessage)';
  }
}

/// @nodoc
abstract mixin class $GenerateStateCopyWith<$Res> {
  factory $GenerateStateCopyWith(
          GenerateState value, $Res Function(GenerateState) _then) =
      _$GenerateStateCopyWithImpl;
  @useResult
  $Res call(
      {GenericStatus generateStatus,
      PlusCode? generatedCode,
      String? generateErrorMessage});

  $PlusCodeCopyWith<$Res>? get generatedCode;
}

/// @nodoc
class _$GenerateStateCopyWithImpl<$Res>
    implements $GenerateStateCopyWith<$Res> {
  _$GenerateStateCopyWithImpl(this._self, this._then);

  final GenerateState _self;
  final $Res Function(GenerateState) _then;

  /// Create a copy of GenerateState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? generateStatus = null,
    Object? generatedCode = freezed,
    Object? generateErrorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      generateStatus: null == generateStatus
          ? _self.generateStatus
          : generateStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      generatedCode: freezed == generatedCode
          ? _self.generatedCode
          : generatedCode // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      generateErrorMessage: freezed == generateErrorMessage
          ? _self.generateErrorMessage
          : generateErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of GenerateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get generatedCode {
    if (_self.generatedCode == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.generatedCode!, (value) {
      return _then(_self.copyWith(generatedCode: value));
    });
  }
}

/// Adds pattern-matching-related methods to [GenerateState].
extension GenerateStatePatterns on GenerateState {
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
    TResult Function(_GenerateState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateState() when $default != null:
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
    TResult Function(_GenerateState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerateState():
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
    TResult? Function(_GenerateState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerateState() when $default != null:
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
    TResult Function(GenericStatus generateStatus, PlusCode? generatedCode,
            String? generateErrorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GenerateState() when $default != null:
        return $default(_that.generateStatus, _that.generatedCode,
            _that.generateErrorMessage);
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
    TResult Function(GenericStatus generateStatus, PlusCode? generatedCode,
            String? generateErrorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerateState():
        return $default(_that.generateStatus, _that.generatedCode,
            _that.generateErrorMessage);
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
    TResult? Function(GenericStatus generateStatus, PlusCode? generatedCode,
            String? generateErrorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GenerateState() when $default != null:
        return $default(_that.generateStatus, _that.generatedCode,
            _that.generateErrorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _GenerateState implements GenerateState {
  const _GenerateState(
      {this.generateStatus = GenericStatus.initial,
      this.generatedCode,
      this.generateErrorMessage});

  @override
  @JsonKey()
  final GenericStatus generateStatus;
  @override
  final PlusCode? generatedCode;
  @override
  final String? generateErrorMessage;

  /// Create a copy of GenerateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GenerateStateCopyWith<_GenerateState> get copyWith =>
      __$GenerateStateCopyWithImpl<_GenerateState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GenerateState &&
            (identical(other.generateStatus, generateStatus) ||
                other.generateStatus == generateStatus) &&
            (identical(other.generatedCode, generatedCode) ||
                other.generatedCode == generatedCode) &&
            (identical(other.generateErrorMessage, generateErrorMessage) ||
                other.generateErrorMessage == generateErrorMessage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, generateStatus, generatedCode, generateErrorMessage);

  @override
  String toString() {
    return 'GenerateState(generateStatus: $generateStatus, generatedCode: $generatedCode, generateErrorMessage: $generateErrorMessage)';
  }
}

/// @nodoc
abstract mixin class _$GenerateStateCopyWith<$Res>
    implements $GenerateStateCopyWith<$Res> {
  factory _$GenerateStateCopyWith(
          _GenerateState value, $Res Function(_GenerateState) _then) =
      __$GenerateStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {GenericStatus generateStatus,
      PlusCode? generatedCode,
      String? generateErrorMessage});

  @override
  $PlusCodeCopyWith<$Res>? get generatedCode;
}

/// @nodoc
class __$GenerateStateCopyWithImpl<$Res>
    implements _$GenerateStateCopyWith<$Res> {
  __$GenerateStateCopyWithImpl(this._self, this._then);

  final _GenerateState _self;
  final $Res Function(_GenerateState) _then;

  /// Create a copy of GenerateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? generateStatus = null,
    Object? generatedCode = freezed,
    Object? generateErrorMessage = freezed,
  }) {
    return _then(_GenerateState(
      generateStatus: null == generateStatus
          ? _self.generateStatus
          : generateStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      generatedCode: freezed == generatedCode
          ? _self.generatedCode
          : generatedCode // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      generateErrorMessage: freezed == generateErrorMessage
          ? _self.generateErrorMessage
          : generateErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of GenerateState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get generatedCode {
    if (_self.generatedCode == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.generatedCode!, (value) {
      return _then(_self.copyWith(generatedCode: value));
    });
  }
}

// dart format on
