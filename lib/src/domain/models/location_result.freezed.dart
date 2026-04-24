// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationResult {
  /// Formatted address string
  String? get formattedAddress;

  /// Latitude
  double? get latitude;

  /// Longitude
  double? get longitude;

  /// Place ID from Google APIs
  String? get placeId;

  /// Short locality name (city/town)
  String? get locality;

  /// Country name
  String? get country;

  /// Create a copy of LocationResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LocationResultCopyWith<LocationResult> get copyWith =>
      _$LocationResultCopyWithImpl<LocationResult>(
          this as LocationResult, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LocationResult &&
            (identical(other.formattedAddress, formattedAddress) ||
                other.formattedAddress == formattedAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.country, country) || other.country == country));
  }

  @override
  int get hashCode => Object.hash(runtimeType, formattedAddress, latitude,
      longitude, placeId, locality, country);

  @override
  String toString() {
    return 'LocationResult(formattedAddress: $formattedAddress, latitude: $latitude, longitude: $longitude, placeId: $placeId, locality: $locality, country: $country)';
  }
}

/// @nodoc
abstract mixin class $LocationResultCopyWith<$Res> {
  factory $LocationResultCopyWith(
          LocationResult value, $Res Function(LocationResult) _then) =
      _$LocationResultCopyWithImpl;
  @useResult
  $Res call(
      {String? formattedAddress,
      double? latitude,
      double? longitude,
      String? placeId,
      String? locality,
      String? country});
}

/// @nodoc
class _$LocationResultCopyWithImpl<$Res>
    implements $LocationResultCopyWith<$Res> {
  _$LocationResultCopyWithImpl(this._self, this._then);

  final LocationResult _self;
  final $Res Function(LocationResult) _then;

  /// Create a copy of LocationResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? formattedAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? placeId = freezed,
    Object? locality = freezed,
    Object? country = freezed,
  }) {
    return _then(_self.copyWith(
      formattedAddress: freezed == formattedAddress
          ? _self.formattedAddress
          : formattedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      placeId: freezed == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      locality: freezed == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [LocationResult].
extension LocationResultPatterns on LocationResult {
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
    TResult Function(_LocationResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationResult() when $default != null:
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
    TResult Function(_LocationResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationResult():
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
    TResult? Function(_LocationResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationResult() when $default != null:
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
            String? formattedAddress,
            double? latitude,
            double? longitude,
            String? placeId,
            String? locality,
            String? country)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LocationResult() when $default != null:
        return $default(_that.formattedAddress, _that.latitude, _that.longitude,
            _that.placeId, _that.locality, _that.country);
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
            String? formattedAddress,
            double? latitude,
            double? longitude,
            String? placeId,
            String? locality,
            String? country)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationResult():
        return $default(_that.formattedAddress, _that.latitude, _that.longitude,
            _that.placeId, _that.locality, _that.country);
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
            String? formattedAddress,
            double? latitude,
            double? longitude,
            String? placeId,
            String? locality,
            String? country)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LocationResult() when $default != null:
        return $default(_that.formattedAddress, _that.latitude, _that.longitude,
            _that.placeId, _that.locality, _that.country);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _LocationResult extends LocationResult {
  const _LocationResult(
      {this.formattedAddress,
      this.latitude,
      this.longitude,
      this.placeId,
      this.locality,
      this.country})
      : super._();

  /// Formatted address string
  @override
  final String? formattedAddress;

  /// Latitude
  @override
  final double? latitude;

  /// Longitude
  @override
  final double? longitude;

  /// Place ID from Google APIs
  @override
  final String? placeId;

  /// Short locality name (city/town)
  @override
  final String? locality;

  /// Country name
  @override
  final String? country;

  /// Create a copy of LocationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LocationResultCopyWith<_LocationResult> get copyWith =>
      __$LocationResultCopyWithImpl<_LocationResult>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LocationResult &&
            (identical(other.formattedAddress, formattedAddress) ||
                other.formattedAddress == formattedAddress) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.locality, locality) ||
                other.locality == locality) &&
            (identical(other.country, country) || other.country == country));
  }

  @override
  int get hashCode => Object.hash(runtimeType, formattedAddress, latitude,
      longitude, placeId, locality, country);

  @override
  String toString() {
    return 'LocationResult(formattedAddress: $formattedAddress, latitude: $latitude, longitude: $longitude, placeId: $placeId, locality: $locality, country: $country)';
  }
}

/// @nodoc
abstract mixin class _$LocationResultCopyWith<$Res>
    implements $LocationResultCopyWith<$Res> {
  factory _$LocationResultCopyWith(
          _LocationResult value, $Res Function(_LocationResult) _then) =
      __$LocationResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String? formattedAddress,
      double? latitude,
      double? longitude,
      String? placeId,
      String? locality,
      String? country});
}

/// @nodoc
class __$LocationResultCopyWithImpl<$Res>
    implements _$LocationResultCopyWith<$Res> {
  __$LocationResultCopyWithImpl(this._self, this._then);

  final _LocationResult _self;
  final $Res Function(_LocationResult) _then;

  /// Create a copy of LocationResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? formattedAddress = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
    Object? placeId = freezed,
    Object? locality = freezed,
    Object? country = freezed,
  }) {
    return _then(_LocationResult(
      formattedAddress: freezed == formattedAddress
          ? _self.formattedAddress
          : formattedAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _self.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _self.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
      placeId: freezed == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String?,
      locality: freezed == locality
          ? _self.locality
          : locality // ignore: cast_nullable_to_non_nullable
              as String?,
      country: freezed == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
