// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'map_view_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MapViewEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is MapViewEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'MapViewEvent()';
  }
}

/// @nodoc
class $MapViewEventCopyWith<$Res> {
  $MapViewEventCopyWith(MapViewEvent _, $Res Function(MapViewEvent) __);
}

/// Adds pattern-matching-related methods to [MapViewEvent].
extension MapViewEventPatterns on MapViewEvent {
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
    TResult Function(_UpdateLocation value)? updateLocation,
    TResult Function(_ReverseGeocodeLocation value)? reverseGeocodeLocation,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _UpdateLocation() when updateLocation != null:
        return updateLocation(_that);
      case _ReverseGeocodeLocation() when reverseGeocodeLocation != null:
        return reverseGeocodeLocation(_that);
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
    required TResult Function(_UpdateLocation value) updateLocation,
    required TResult Function(_ReverseGeocodeLocation value)
        reverseGeocodeLocation,
    required TResult Function(_Reset value) reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init(_that);
      case _UpdateLocation():
        return updateLocation(_that);
      case _ReverseGeocodeLocation():
        return reverseGeocodeLocation(_that);
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
    TResult? Function(_UpdateLocation value)? updateLocation,
    TResult? Function(_ReverseGeocodeLocation value)? reverseGeocodeLocation,
    TResult? Function(_Reset value)? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _UpdateLocation() when updateLocation != null:
        return updateLocation(_that);
      case _ReverseGeocodeLocation() when reverseGeocodeLocation != null:
        return reverseGeocodeLocation(_that);
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
    TResult Function(double latitude, double longitude)? updateLocation,
    TResult Function(double latitude, double longitude)? reverseGeocodeLocation,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _UpdateLocation() when updateLocation != null:
        return updateLocation(_that.latitude, _that.longitude);
      case _ReverseGeocodeLocation() when reverseGeocodeLocation != null:
        return reverseGeocodeLocation(_that.latitude, _that.longitude);
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
    required TResult Function(double latitude, double longitude) updateLocation,
    required TResult Function(double latitude, double longitude)
        reverseGeocodeLocation,
    required TResult Function() reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init();
      case _UpdateLocation():
        return updateLocation(_that.latitude, _that.longitude);
      case _ReverseGeocodeLocation():
        return reverseGeocodeLocation(_that.latitude, _that.longitude);
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
    TResult? Function(double latitude, double longitude)? updateLocation,
    TResult? Function(double latitude, double longitude)?
        reverseGeocodeLocation,
    TResult? Function()? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _UpdateLocation() when updateLocation != null:
        return updateLocation(_that.latitude, _that.longitude);
      case _ReverseGeocodeLocation() when reverseGeocodeLocation != null:
        return reverseGeocodeLocation(_that.latitude, _that.longitude);
      case _Reset() when reset != null:
        return reset();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Init implements MapViewEvent {
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
    return 'MapViewEvent.init()';
  }
}

/// @nodoc

class _UpdateLocation implements MapViewEvent {
  const _UpdateLocation({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  /// Create a copy of MapViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UpdateLocationCopyWith<_UpdateLocation> get copyWith =>
      __$UpdateLocationCopyWithImpl<_UpdateLocation>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UpdateLocation &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @override
  String toString() {
    return 'MapViewEvent.updateLocation(latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$UpdateLocationCopyWith<$Res>
    implements $MapViewEventCopyWith<$Res> {
  factory _$UpdateLocationCopyWith(
          _UpdateLocation value, $Res Function(_UpdateLocation) _then) =
      __$UpdateLocationCopyWithImpl;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$UpdateLocationCopyWithImpl<$Res>
    implements _$UpdateLocationCopyWith<$Res> {
  __$UpdateLocationCopyWithImpl(this._self, this._then);

  final _UpdateLocation _self;
  final $Res Function(_UpdateLocation) _then;

  /// Create a copy of MapViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_UpdateLocation(
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

class _ReverseGeocodeLocation implements MapViewEvent {
  const _ReverseGeocodeLocation(
      {required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  /// Create a copy of MapViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$ReverseGeocodeLocationCopyWith<_ReverseGeocodeLocation> get copyWith =>
      __$ReverseGeocodeLocationCopyWithImpl<_ReverseGeocodeLocation>(
          this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _ReverseGeocodeLocation &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode => Object.hash(runtimeType, latitude, longitude);

  @override
  String toString() {
    return 'MapViewEvent.reverseGeocodeLocation(latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$ReverseGeocodeLocationCopyWith<$Res>
    implements $MapViewEventCopyWith<$Res> {
  factory _$ReverseGeocodeLocationCopyWith(_ReverseGeocodeLocation value,
          $Res Function(_ReverseGeocodeLocation) _then) =
      __$ReverseGeocodeLocationCopyWithImpl;
  @useResult
  $Res call({double latitude, double longitude});
}

/// @nodoc
class __$ReverseGeocodeLocationCopyWithImpl<$Res>
    implements _$ReverseGeocodeLocationCopyWith<$Res> {
  __$ReverseGeocodeLocationCopyWithImpl(this._self, this._then);

  final _ReverseGeocodeLocation _self;
  final $Res Function(_ReverseGeocodeLocation) _then;

  /// Create a copy of MapViewEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_ReverseGeocodeLocation(
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

class _Reset implements MapViewEvent {
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
    return 'MapViewEvent.reset()';
  }
}

/// @nodoc
mixin _$MapViewState {
  GenericStatus get geocodeStatus;
  LocationResult? get locationResult;
  PlusCode? get selectedPlusCode;
  double? get currentLatitude;
  double? get currentLongitude;
  String? get geocodeErrorMessage;

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $MapViewStateCopyWith<MapViewState> get copyWith =>
      _$MapViewStateCopyWithImpl<MapViewState>(
          this as MapViewState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is MapViewState &&
            (identical(other.geocodeStatus, geocodeStatus) ||
                other.geocodeStatus == geocodeStatus) &&
            (identical(other.locationResult, locationResult) ||
                other.locationResult == locationResult) &&
            (identical(other.selectedPlusCode, selectedPlusCode) ||
                other.selectedPlusCode == selectedPlusCode) &&
            (identical(other.currentLatitude, currentLatitude) ||
                other.currentLatitude == currentLatitude) &&
            (identical(other.currentLongitude, currentLongitude) ||
                other.currentLongitude == currentLongitude) &&
            (identical(other.geocodeErrorMessage, geocodeErrorMessage) ||
                other.geocodeErrorMessage == geocodeErrorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, geocodeStatus, locationResult,
      selectedPlusCode, currentLatitude, currentLongitude, geocodeErrorMessage);

  @override
  String toString() {
    return 'MapViewState(geocodeStatus: $geocodeStatus, locationResult: $locationResult, selectedPlusCode: $selectedPlusCode, currentLatitude: $currentLatitude, currentLongitude: $currentLongitude, geocodeErrorMessage: $geocodeErrorMessage)';
  }
}

/// @nodoc
abstract mixin class $MapViewStateCopyWith<$Res> {
  factory $MapViewStateCopyWith(
          MapViewState value, $Res Function(MapViewState) _then) =
      _$MapViewStateCopyWithImpl;
  @useResult
  $Res call(
      {GenericStatus geocodeStatus,
      LocationResult? locationResult,
      PlusCode? selectedPlusCode,
      double? currentLatitude,
      double? currentLongitude,
      String? geocodeErrorMessage});

  $LocationResultCopyWith<$Res>? get locationResult;
  $PlusCodeCopyWith<$Res>? get selectedPlusCode;
}

/// @nodoc
class _$MapViewStateCopyWithImpl<$Res> implements $MapViewStateCopyWith<$Res> {
  _$MapViewStateCopyWithImpl(this._self, this._then);

  final MapViewState _self;
  final $Res Function(MapViewState) _then;

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? geocodeStatus = null,
    Object? locationResult = freezed,
    Object? selectedPlusCode = freezed,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? geocodeErrorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      geocodeStatus: null == geocodeStatus
          ? _self.geocodeStatus
          : geocodeStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      locationResult: freezed == locationResult
          ? _self.locationResult
          : locationResult // ignore: cast_nullable_to_non_nullable
              as LocationResult?,
      selectedPlusCode: freezed == selectedPlusCode
          ? _self.selectedPlusCode
          : selectedPlusCode // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      currentLatitude: freezed == currentLatitude
          ? _self.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _self.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      geocodeErrorMessage: freezed == geocodeErrorMessage
          ? _self.geocodeErrorMessage
          : geocodeErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationResultCopyWith<$Res>? get locationResult {
    if (_self.locationResult == null) {
      return null;
    }

    return $LocationResultCopyWith<$Res>(_self.locationResult!, (value) {
      return _then(_self.copyWith(locationResult: value));
    });
  }

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get selectedPlusCode {
    if (_self.selectedPlusCode == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.selectedPlusCode!, (value) {
      return _then(_self.copyWith(selectedPlusCode: value));
    });
  }
}

/// Adds pattern-matching-related methods to [MapViewState].
extension MapViewStatePatterns on MapViewState {
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
    TResult Function(_MapViewState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapViewState() when $default != null:
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
    TResult Function(_MapViewState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapViewState():
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
    TResult? Function(_MapViewState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapViewState() when $default != null:
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
            GenericStatus geocodeStatus,
            LocationResult? locationResult,
            PlusCode? selectedPlusCode,
            double? currentLatitude,
            double? currentLongitude,
            String? geocodeErrorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _MapViewState() when $default != null:
        return $default(
            _that.geocodeStatus,
            _that.locationResult,
            _that.selectedPlusCode,
            _that.currentLatitude,
            _that.currentLongitude,
            _that.geocodeErrorMessage);
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
            GenericStatus geocodeStatus,
            LocationResult? locationResult,
            PlusCode? selectedPlusCode,
            double? currentLatitude,
            double? currentLongitude,
            String? geocodeErrorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapViewState():
        return $default(
            _that.geocodeStatus,
            _that.locationResult,
            _that.selectedPlusCode,
            _that.currentLatitude,
            _that.currentLongitude,
            _that.geocodeErrorMessage);
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
            GenericStatus geocodeStatus,
            LocationResult? locationResult,
            PlusCode? selectedPlusCode,
            double? currentLatitude,
            double? currentLongitude,
            String? geocodeErrorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _MapViewState() when $default != null:
        return $default(
            _that.geocodeStatus,
            _that.locationResult,
            _that.selectedPlusCode,
            _that.currentLatitude,
            _that.currentLongitude,
            _that.geocodeErrorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _MapViewState implements MapViewState {
  const _MapViewState(
      {this.geocodeStatus = GenericStatus.initial,
      this.locationResult,
      this.selectedPlusCode,
      this.currentLatitude,
      this.currentLongitude,
      this.geocodeErrorMessage});

  @override
  @JsonKey()
  final GenericStatus geocodeStatus;
  @override
  final LocationResult? locationResult;
  @override
  final PlusCode? selectedPlusCode;
  @override
  final double? currentLatitude;
  @override
  final double? currentLongitude;
  @override
  final String? geocodeErrorMessage;

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$MapViewStateCopyWith<_MapViewState> get copyWith =>
      __$MapViewStateCopyWithImpl<_MapViewState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _MapViewState &&
            (identical(other.geocodeStatus, geocodeStatus) ||
                other.geocodeStatus == geocodeStatus) &&
            (identical(other.locationResult, locationResult) ||
                other.locationResult == locationResult) &&
            (identical(other.selectedPlusCode, selectedPlusCode) ||
                other.selectedPlusCode == selectedPlusCode) &&
            (identical(other.currentLatitude, currentLatitude) ||
                other.currentLatitude == currentLatitude) &&
            (identical(other.currentLongitude, currentLongitude) ||
                other.currentLongitude == currentLongitude) &&
            (identical(other.geocodeErrorMessage, geocodeErrorMessage) ||
                other.geocodeErrorMessage == geocodeErrorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, geocodeStatus, locationResult,
      selectedPlusCode, currentLatitude, currentLongitude, geocodeErrorMessage);

  @override
  String toString() {
    return 'MapViewState(geocodeStatus: $geocodeStatus, locationResult: $locationResult, selectedPlusCode: $selectedPlusCode, currentLatitude: $currentLatitude, currentLongitude: $currentLongitude, geocodeErrorMessage: $geocodeErrorMessage)';
  }
}

/// @nodoc
abstract mixin class _$MapViewStateCopyWith<$Res>
    implements $MapViewStateCopyWith<$Res> {
  factory _$MapViewStateCopyWith(
          _MapViewState value, $Res Function(_MapViewState) _then) =
      __$MapViewStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {GenericStatus geocodeStatus,
      LocationResult? locationResult,
      PlusCode? selectedPlusCode,
      double? currentLatitude,
      double? currentLongitude,
      String? geocodeErrorMessage});

  @override
  $LocationResultCopyWith<$Res>? get locationResult;
  @override
  $PlusCodeCopyWith<$Res>? get selectedPlusCode;
}

/// @nodoc
class __$MapViewStateCopyWithImpl<$Res>
    implements _$MapViewStateCopyWith<$Res> {
  __$MapViewStateCopyWithImpl(this._self, this._then);

  final _MapViewState _self;
  final $Res Function(_MapViewState) _then;

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? geocodeStatus = null,
    Object? locationResult = freezed,
    Object? selectedPlusCode = freezed,
    Object? currentLatitude = freezed,
    Object? currentLongitude = freezed,
    Object? geocodeErrorMessage = freezed,
  }) {
    return _then(_MapViewState(
      geocodeStatus: null == geocodeStatus
          ? _self.geocodeStatus
          : geocodeStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      locationResult: freezed == locationResult
          ? _self.locationResult
          : locationResult // ignore: cast_nullable_to_non_nullable
              as LocationResult?,
      selectedPlusCode: freezed == selectedPlusCode
          ? _self.selectedPlusCode
          : selectedPlusCode // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      currentLatitude: freezed == currentLatitude
          ? _self.currentLatitude
          : currentLatitude // ignore: cast_nullable_to_non_nullable
              as double?,
      currentLongitude: freezed == currentLongitude
          ? _self.currentLongitude
          : currentLongitude // ignore: cast_nullable_to_non_nullable
              as double?,
      geocodeErrorMessage: freezed == geocodeErrorMessage
          ? _self.geocodeErrorMessage
          : geocodeErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $LocationResultCopyWith<$Res>? get locationResult {
    if (_self.locationResult == null) {
      return null;
    }

    return $LocationResultCopyWith<$Res>(_self.locationResult!, (value) {
      return _then(_self.copyWith(locationResult: value));
    });
  }

  /// Create a copy of MapViewState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get selectedPlusCode {
    if (_self.selectedPlusCode == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.selectedPlusCode!, (value) {
      return _then(_self.copyWith(selectedPlusCode: value));
    });
  }
}

// dart format on
