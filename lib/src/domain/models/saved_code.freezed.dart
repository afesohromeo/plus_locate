// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_code.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedCode {
  /// Unique identifier (UUID or timestamp-based)
  String? get id;

  /// The full global Plus Code
  String? get globalCode;

  /// The short local Plus Code
  String? get localCode;

  /// Latitude of the code location
  double? get latitude;

  /// Longitude of the code location
  double? get longitude;

  /// User-assigned label / note
  String? get label;

  /// Locality name
  String? get locality;

  /// Address name
  String? get address;

  /// When the code was saved
  DateTime? get savedAt;

  /// Create a copy of SavedCode
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SavedCodeCopyWith<SavedCode> get copyWith =>
      _$SavedCodeCopyWithImpl<SavedCode>(this as SavedCode, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as SavedCode;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SavedCode &&
            (identical(other.id, _this.id) || other.id == _this.id) &&
            (identical(other.globalCode, _this.globalCode) ||
                other.globalCode == _this.globalCode) &&
            (identical(other.localCode, _this.localCode) ||
                other.localCode == _this.localCode) &&
            (identical(other.latitude, _this.latitude) ||
                other.latitude == _this.latitude) &&
            (identical(other.longitude, _this.longitude) ||
                other.longitude == _this.longitude) &&
            (identical(other.label, _this.label) ||
                other.label == _this.label) &&
            (identical(other.locality, _this.locality) ||
                other.locality == _this.locality) &&
            (identical(other.address, _this.address) ||
                other.address == _this.address) &&
            (identical(other.savedAt, _this.savedAt) ||
                other.savedAt == _this.savedAt));
  }

  @override
  int get hashCode {
    final _this = this as SavedCode;
    return Object.hash(
        runtimeType,
        _this.id,
        _this.globalCode,
        _this.localCode,
        _this.latitude,
        _this.longitude,
        _this.label,
        _this.locality,
        _this.address,
        _this.savedAt);
  }

  @override
  String toString() {
    final _this = this as SavedCode;
    return 'SavedCode(id: ${_this.id}, globalCode: ${_this.globalCode}, localCode: ${_this.localCode}, latitude: ${_this.latitude}, longitude: ${_this.longitude}, label: ${_this.label}, locality: ${_this.locality}, address: ${_this.address}, savedAt: ${_this.savedAt})';
  }
}

/// @nodoc
abstract mixin class $SavedCodeCopyWith<$Res> {
  factory $SavedCodeCopyWith(SavedCode value, $Res Function(SavedCode) _then) =
      _$SavedCodeCopyWithImpl;
  @useResult
  $Res call(
      {String? id,
      String? globalCode,
      String? localCode,
      double? latitude,
      double? longitude,
      String? label,
      String? locality,
      String? address,
      DateTime? savedAt});
}

/// @nodoc
class _$SavedCodeCopyWithImpl<$Res> implements $SavedCodeCopyWith<$Res> {
  _$SavedCodeCopyWithImpl(this._self, this._then);

  final SavedCode _self;
  final $Res Function(SavedCode) _then;

  /// Create a copy of SavedCode
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? globalCode = freezed,
    Object? localCode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? label = freezed,
    Object? locality = freezed,
    Object? address = freezed,
    Object? savedAt = freezed,
  }) {
    return _then(SavedCode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      locality: freezed == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      savedAt: freezed == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [SavedCode].
extension SavedCodePatterns on SavedCode {
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
    TResult Function(_SavedCode value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedCode() when $default != null:
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
    TResult Function(_SavedCode value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedCode():
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
    TResult? Function(_SavedCode value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedCode() when $default != null:
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
            String? id,
            String? globalCode,
            String? localCode,
            double? latitude,
            double? longitude,
            String? label,
            String? locality,
            String? address,
            DateTime? savedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SavedCode() when $default != null:
        return $default(
            _that.id,
            _that.globalCode,
            _that.localCode,
            _that.latitude,
            _that.longitude,
            _that.label,
            _that.locality,
            _that.address,
            _that.savedAt);
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
            String? id,
            String? globalCode,
            String? localCode,
            double? latitude,
            double? longitude,
            String? label,
            String? locality,
            String? address,
            DateTime? savedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedCode():
        return $default(
            _that.id,
            _that.globalCode,
            _that.localCode,
            _that.latitude,
            _that.longitude,
            _that.label,
            _that.locality,
            _that.address,
            _that.savedAt);
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
            String? id,
            String? globalCode,
            String? localCode,
            double? latitude,
            double? longitude,
            String? label,
            String? locality,
            String? address,
            DateTime? savedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SavedCode() when $default != null:
        return $default(
            _that.id,
            _that.globalCode,
            _that.localCode,
            _that.latitude,
            _that.longitude,
            _that.label,
            _that.locality,
            _that.address,
            _that.savedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SavedCode extends SavedCode {
  const _SavedCode(
      {this.id,
      this.globalCode,
      this.localCode,
      this.latitude,
      this.longitude,
      this.label,
      this.locality,
      this.address,
      this.savedAt})
      : super._();

  /// Unique identifier (UUID or timestamp-based)
  @override
  final String? id;

  /// The full global Plus Code
  @override
  final String? globalCode;

  /// The short local Plus Code
  @override
  final String? localCode;

  /// Latitude of the code location
  @override
  final double? latitude;

  /// Longitude of the code location
  @override
  final double? longitude;

  /// User-assigned label / note
  @override
  final String? label;

  /// Locality name
  @override
  final String? locality;

  /// Address name
  @override
  final String? address;

  /// When the code was saved
  @override
  final DateTime? savedAt;

  /// Create a copy of SavedCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SavedCodeCopyWith<_SavedCode> get copyWith =>
      __$SavedCodeCopyWithImpl<_SavedCode>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SavedCode &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.globalCode, globalCode) ||
                other.globalCode == globalCode) &&
            (identical(other.localCode, localCode) ||
                other.localCode == localCode) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.label, label) || other.label == label) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.address, address) || other.address == address) &&
            (identical(other.savedAt, savedAt) || other.savedAt == savedAt));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, id, globalCode, localCode, latitude,
        longitude, label, locality, address, savedAt);
  }

  @override
  String toString() {
    return 'SavedCode(id: $id, globalCode: $globalCode, localCode: $localCode, latitude: $latitude, longitude: $longitude, label: $label, locality: $locality, address: $address, savedAt: $savedAt)';
  }
}

/// @nodoc
abstract mixin class _$SavedCodeCopyWith<$Res>
    implements $SavedCodeCopyWith<$Res> {
  factory _$SavedCodeCopyWith(
          _SavedCode value, $Res Function(_SavedCode) _then) =
      __$SavedCodeCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? id,
      String? globalCode,
      String? localCode,
      double? latitude,
      double? longitude,
      String? label,
      String? locality,
      String? address,
      DateTime? savedAt});
}

/// @nodoc
class __$SavedCodeCopyWithImpl<$Res> implements _$SavedCodeCopyWith<$Res> {
  __$SavedCodeCopyWithImpl(this._self, this._then);

  final _SavedCode _self;
  final $Res Function(_SavedCode) _then;

  /// Create a copy of SavedCode
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = freezed,
    Object? globalCode = freezed,
    Object? localCode = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? label = freezed,
    Object? locality = freezed,
    Object? address = freezed,
    Object? savedAt = freezed,
  }) {
    return _then(_SavedCode(
      id: freezed == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
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
      label: freezed == label
          ? _self.label
          : label // ignore: cast_nullable_to_non_nullable
              as String?,
      locality: freezed == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _self.address
          : address // ignore: cast_nullable_to_non_nullable
              as String?,
      savedAt: freezed == savedAt
          ? _self.savedAt
          : savedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
