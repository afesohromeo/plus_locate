// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'plus_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlusCode {
  /// The full (global) Plus Code, e.g. "8FVC9G8F+6W"
  String? get globalCode;

  /// The short (local) Plus Code relative to a locality, e.g. "9G8F+6W Zurich"
  String? get localCode;

  /// Latitude of the Plus Code center
  double? get latitude;

  /// Longitude of the Plus Code center
  double? get longitude;

  /// Locality name associated with the short code
  String? get locality;

  /// Create a copy of PlusCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<PlusCode> get copyWith =>
      _$PlusCodeCopyWithImpl<PlusCode>(this as PlusCode, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlusCode &&
            (identical(other.globalCode, globalCode) ||
                other.globalCode == globalCode) &&
            (identical(other.localCode, localCode) ||
                other.localCode == localCode) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.locality, locality) ||
                other.locality == locality));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, globalCode, localCode, latitude, longitude, locality);

  @override
  String toString() {
    return 'PlusCode(globalCode: $globalCode, localCode: $localCode, latitude: $latitude, longitude: $longitude, locality: $locality)';
  }
}

/// @nodoc
abstract mixin class $PlusCodeCopyWith<$Res> {
  factory $PlusCodeCopyWith(PlusCode value, $Res Function(PlusCode) _then) =
      _$PlusCodeCopyWithImpl;
  @useResult
  $Res call(
      {String? globalCode,
      String? localCode,
      double? latitude,
      double? longitude,
      String? locality});
}

/// @nodoc
class _$PlusCodeCopyWithImpl<$Res> implements $PlusCodeCopyWith<$Res> {
  _$PlusCodeCopyWithImpl(this._self, this._then);

  final PlusCode _self;
  final $Res Function(PlusCode) _then;

  /// Create a copy of PlusCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? globalCode = freezed,
    Object? localCode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? locality = freezed,
  }) {
    return _then(_self.copyWith(
      globalCode: freezed == globalCode
          ? _self.globalCode
          : globalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      localCode: freezed == localCode
          ? _self.localCode
          : localCode // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locality: freezed == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlusCode].
extension PlusCodePatterns on PlusCode {
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
    TResult Function(_PlusCode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlusCode() when $default != null:
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
    TResult Function(_PlusCode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlusCode():
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
    TResult? Function(_PlusCode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlusCode() when $default != null:
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
    TResult Function(String? globalCode, String? localCode, double? latitude,
            double? longitude, String? locality)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlusCode() when $default != null:
        return $default(_that.globalCode, _that.localCode, _that.latitude,
            _that.longitude, _that.locality);
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
    TResult Function(String? globalCode, String? localCode, double? latitude,
            double? longitude, String? locality)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlusCode():
        return $default(_that.globalCode, _that.localCode, _that.latitude,
            _that.longitude, _that.locality);
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
    TResult? Function(String? globalCode, String? localCode, double? latitude,
            double? longitude, String? locality)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlusCode() when $default != null:
        return $default(_that.globalCode, _that.localCode, _that.latitude,
            _that.longitude, _that.locality);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PlusCode extends PlusCode {
  const _PlusCode(
      {this.globalCode,
      this.localCode,
      this.latitude,
      this.longitude,
      this.locality})
      : super._();

  /// The full (global) Plus Code, e.g. "8FVC9G8F+6W"
  @override
  final String? globalCode;

  /// The short (local) Plus Code relative to a locality, e.g. "9G8F+6W Zurich"
  @override
  final String? localCode;

  /// Latitude of the Plus Code center
  @override
  final double? latitude;

  /// Longitude of the Plus Code center
  @override
  final double? longitude;

  /// Locality name associated with the short code
  @override
  final String? locality;

  /// Create a copy of PlusCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlusCodeCopyWith<_PlusCode> get copyWith =>
      __$PlusCodeCopyWithImpl<_PlusCode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlusCode &&
            (identical(other.globalCode, globalCode) ||
                other.globalCode == globalCode) &&
            (identical(other.localCode, localCode) ||
                other.localCode == localCode) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.locality, locality) ||
                other.locality == locality));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, globalCode, localCode, latitude, longitude, locality);

  @override
  String toString() {
    return 'PlusCode(globalCode: $globalCode, localCode: $localCode, latitude: $latitude, longitude: $longitude, locality: $locality)';
  }
}

/// @nodoc
abstract mixin class _$PlusCodeCopyWith<$Res>
    implements $PlusCodeCopyWith<$Res> {
  factory _$PlusCodeCopyWith(_PlusCode value, $Res Function(_PlusCode) _then) =
      __$PlusCodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? globalCode,
      String? localCode,
      double? latitude,
      double? longitude,
      String? locality});
}

/// @nodoc
class __$PlusCodeCopyWithImpl<$Res> implements _$PlusCodeCopyWith<$Res> {
  __$PlusCodeCopyWithImpl(this._self, this._then);

  final _PlusCode _self;
  final $Res Function(_PlusCode) _then;

  /// Create a copy of PlusCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? globalCode = freezed,
    Object? localCode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? locality = freezed,
  }) {
    return _then(_PlusCode(
      globalCode: freezed == globalCode
          ? _self.globalCode
          : globalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      localCode: freezed == localCode
          ? _self.localCode
          : localCode // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      locality: freezed == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
