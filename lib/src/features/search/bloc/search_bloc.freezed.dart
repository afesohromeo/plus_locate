// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SearchEvent {
  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is SearchEvent);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  String toString() {
    return 'SearchEvent()';
  }
}

/// @nodoc
class $SearchEventCopyWith<$Res> {
  $SearchEventCopyWith(SearchEvent _, $Res Function(SearchEvent) __);
}

/// Adds pattern-matching-related methods to [SearchEvent].
extension SearchEventPatterns on SearchEvent {
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
    TResult Function(_PlaceSelected value)? placeSelected,
    TResult Function(_SubmitQuery value)? submitQuery,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _PlaceSelected() when placeSelected != null:
        return placeSelected(_that);
      case _SubmitQuery() when submitQuery != null:
        return submitQuery(_that);
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
    required TResult Function(_PlaceSelected value) placeSelected,
    required TResult Function(_SubmitQuery value) submitQuery,
    required TResult Function(_Reset value) reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init(_that);
      case _PlaceSelected():
        return placeSelected(_that);
      case _SubmitQuery():
        return submitQuery(_that);
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
    TResult? Function(_PlaceSelected value)? placeSelected,
    TResult? Function(_SubmitQuery value)? submitQuery,
    TResult? Function(_Reset value)? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _PlaceSelected() when placeSelected != null:
        return placeSelected(_that);
      case _SubmitQuery() when submitQuery != null:
        return submitQuery(_that);
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
    TResult Function(String description, double latitude, double longitude)?
        placeSelected,
    TResult Function(String query)? submitQuery,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _PlaceSelected() when placeSelected != null:
        return placeSelected(
            _that.description, _that.latitude, _that.longitude);
      case _SubmitQuery() when submitQuery != null:
        return submitQuery(_that.query);
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
    required TResult Function(
            String description, double latitude, double longitude)
        placeSelected,
    required TResult Function(String query) submitQuery,
    required TResult Function() reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init();
      case _PlaceSelected():
        return placeSelected(
            _that.description, _that.latitude, _that.longitude);
      case _SubmitQuery():
        return submitQuery(_that.query);
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
    TResult? Function(String description, double latitude, double longitude)?
        placeSelected,
    TResult? Function(String query)? submitQuery,
    TResult? Function()? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _PlaceSelected() when placeSelected != null:
        return placeSelected(
            _that.description, _that.latitude, _that.longitude);
      case _SubmitQuery() when submitQuery != null:
        return submitQuery(_that.query);
      case _Reset() when reset != null:
        return reset();
      case _:
        return null;
    }
  }
}

/// @nodoc

class _Init implements SearchEvent {
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
    return 'SearchEvent.init()';
  }
}

/// @nodoc

class _PlaceSelected implements SearchEvent {
  const _PlaceSelected(
      {required this.description,
      required this.latitude,
      required this.longitude});

  final String description;
  final double latitude;
  final double longitude;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlaceSelectedCopyWith<_PlaceSelected> get copyWith =>
      __$PlaceSelectedCopyWithImpl<_PlaceSelected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlaceSelected &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, description, latitude, longitude);

  @override
  String toString() {
    return 'SearchEvent.placeSelected(description: $description, latitude: $latitude, longitude: $longitude)';
  }
}

/// @nodoc
abstract mixin class _$PlaceSelectedCopyWith<$Res>
    implements $SearchEventCopyWith<$Res> {
  factory _$PlaceSelectedCopyWith(
          _PlaceSelected value, $Res Function(_PlaceSelected) _then) =
      __$PlaceSelectedCopyWithImpl;
  @useResult
  $Res call({String description, double latitude, double longitude});
}

/// @nodoc
class __$PlaceSelectedCopyWithImpl<$Res>
    implements _$PlaceSelectedCopyWith<$Res> {
  __$PlaceSelectedCopyWithImpl(this._self, this._then);

  final _PlaceSelected _self;
  final $Res Function(_PlaceSelected) _then;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? description = null,
    Object? latitude = null,
    Object? longitude = null,
  }) {
    return _then(_PlaceSelected(
      description: null == description
          ? _self.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
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

class _SubmitQuery implements SearchEvent {
  const _SubmitQuery({required this.query});

  final String query;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SubmitQueryCopyWith<_SubmitQuery> get copyWith =>
      __$SubmitQueryCopyWithImpl<_SubmitQuery>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SubmitQuery &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode => Object.hash(runtimeType, query);

  @override
  String toString() {
    return 'SearchEvent.submitQuery(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$SubmitQueryCopyWith<$Res>
    implements $SearchEventCopyWith<$Res> {
  factory _$SubmitQueryCopyWith(
          _SubmitQuery value, $Res Function(_SubmitQuery) _then) =
      __$SubmitQueryCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$SubmitQueryCopyWithImpl<$Res> implements _$SubmitQueryCopyWith<$Res> {
  __$SubmitQueryCopyWithImpl(this._self, this._then);

  final _SubmitQuery _self;
  final $Res Function(_SubmitQuery) _then;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_SubmitQuery(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _Reset implements SearchEvent {
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
    return 'SearchEvent.reset()';
  }
}

/// @nodoc
mixin _$SearchState {
  GenericStatus get searchStatus;
  SearchMode get searchMode;
  LocationResult? get locationResult;
  PlusCode? get plusCode;
  String? get searchErrorMessage;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchStateCopyWith<SearchState> get copyWith =>
      _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchState &&
            (identical(other.searchStatus, searchStatus) ||
                other.searchStatus == searchStatus) &&
            (identical(other.searchMode, searchMode) ||
                other.searchMode == searchMode) &&
            (identical(other.locationResult, locationResult) ||
                other.locationResult == locationResult) &&
            (identical(other.plusCode, plusCode) ||
                other.plusCode == plusCode) &&
            (identical(other.searchErrorMessage, searchErrorMessage) ||
                other.searchErrorMessage == searchErrorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchStatus, searchMode,
      locationResult, plusCode, searchErrorMessage);

  @override
  String toString() {
    return 'SearchState(searchStatus: $searchStatus, searchMode: $searchMode, locationResult: $locationResult, plusCode: $plusCode, searchErrorMessage: $searchErrorMessage)';
  }
}

/// @nodoc
abstract mixin class $SearchStateCopyWith<$Res> {
  factory $SearchStateCopyWith(
          SearchState value, $Res Function(SearchState) _then) =
      _$SearchStateCopyWithImpl;
  @useResult
  $Res call(
      {GenericStatus searchStatus,
      SearchMode searchMode,
      LocationResult? locationResult,
      PlusCode? plusCode,
      String? searchErrorMessage});

  $LocationResultCopyWith<$Res>? get locationResult;
  $PlusCodeCopyWith<$Res>? get plusCode;
}

/// @nodoc
class _$SearchStateCopyWithImpl<$Res> implements $SearchStateCopyWith<$Res> {
  _$SearchStateCopyWithImpl(this._self, this._then);

  final SearchState _self;
  final $Res Function(SearchState) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? searchStatus = null,
    Object? searchMode = null,
    Object? locationResult = freezed,
    Object? plusCode = freezed,
    Object? searchErrorMessage = freezed,
  }) {
    return _then(_self.copyWith(
      searchStatus: null == searchStatus
          ? _self.searchStatus
          : searchStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      searchMode: null == searchMode
          ? _self.searchMode
          : searchMode // ignore: cast_nullable_to_non_nullable
              as SearchMode,
      locationResult: freezed == locationResult
          ? _self.locationResult
          : locationResult // ignore: cast_nullable_to_non_nullable
              as LocationResult?,
      plusCode: freezed == plusCode
          ? _self.plusCode
          : plusCode // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      searchErrorMessage: freezed == searchErrorMessage
          ? _self.searchErrorMessage
          : searchErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of SearchState
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

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get plusCode {
    if (_self.plusCode == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.plusCode!, (value) {
      return _then(_self.copyWith(plusCode: value));
    });
  }
}

/// Adds pattern-matching-related methods to [SearchState].
extension SearchStatePatterns on SearchState {
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
    TResult Function(_SearchState value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
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
    TResult Function(_SearchState value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState():
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
    TResult? Function(_SearchState value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
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
            GenericStatus searchStatus,
            SearchMode searchMode,
            LocationResult? locationResult,
            PlusCode? plusCode,
            String? searchErrorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
        return $default(_that.searchStatus, _that.searchMode,
            _that.locationResult, _that.plusCode, _that.searchErrorMessage);
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
            GenericStatus searchStatus,
            SearchMode searchMode,
            LocationResult? locationResult,
            PlusCode? plusCode,
            String? searchErrorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState():
        return $default(_that.searchStatus, _that.searchMode,
            _that.locationResult, _that.plusCode, _that.searchErrorMessage);
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
            GenericStatus searchStatus,
            SearchMode searchMode,
            LocationResult? locationResult,
            PlusCode? plusCode,
            String? searchErrorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
        return $default(_that.searchStatus, _that.searchMode,
            _that.locationResult, _that.plusCode, _that.searchErrorMessage);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _SearchState extends SearchState {
  const _SearchState(
      {this.searchStatus = GenericStatus.initial,
      this.searchMode = SearchMode.autocomplete,
      this.locationResult,
      this.plusCode,
      this.searchErrorMessage})
      : super._();

  @override
  @JsonKey()
  final GenericStatus searchStatus;
  @override
  @JsonKey()
  final SearchMode searchMode;
  @override
  final LocationResult? locationResult;
  @override
  final PlusCode? plusCode;
  @override
  final String? searchErrorMessage;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SearchStateCopyWith<_SearchState> get copyWith =>
      __$SearchStateCopyWithImpl<_SearchState>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SearchState &&
            (identical(other.searchStatus, searchStatus) ||
                other.searchStatus == searchStatus) &&
            (identical(other.searchMode, searchMode) ||
                other.searchMode == searchMode) &&
            (identical(other.locationResult, locationResult) ||
                other.locationResult == locationResult) &&
            (identical(other.plusCode, plusCode) ||
                other.plusCode == plusCode) &&
            (identical(other.searchErrorMessage, searchErrorMessage) ||
                other.searchErrorMessage == searchErrorMessage));
  }

  @override
  int get hashCode => Object.hash(runtimeType, searchStatus, searchMode,
      locationResult, plusCode, searchErrorMessage);

  @override
  String toString() {
    return 'SearchState(searchStatus: $searchStatus, searchMode: $searchMode, locationResult: $locationResult, plusCode: $plusCode, searchErrorMessage: $searchErrorMessage)';
  }
}

/// @nodoc
abstract mixin class _$SearchStateCopyWith<$Res>
    implements $SearchStateCopyWith<$Res> {
  factory _$SearchStateCopyWith(
          _SearchState value, $Res Function(_SearchState) _then) =
      __$SearchStateCopyWithImpl;
  @override
  @useResult
  $Res call(
      {GenericStatus searchStatus,
      SearchMode searchMode,
      LocationResult? locationResult,
      PlusCode? plusCode,
      String? searchErrorMessage});

  @override
  $LocationResultCopyWith<$Res>? get locationResult;
  @override
  $PlusCodeCopyWith<$Res>? get plusCode;
}

/// @nodoc
class __$SearchStateCopyWithImpl<$Res> implements _$SearchStateCopyWith<$Res> {
  __$SearchStateCopyWithImpl(this._self, this._then);

  final _SearchState _self;
  final $Res Function(_SearchState) _then;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? searchStatus = null,
    Object? searchMode = null,
    Object? locationResult = freezed,
    Object? plusCode = freezed,
    Object? searchErrorMessage = freezed,
  }) {
    return _then(_SearchState(
      searchStatus: null == searchStatus
          ? _self.searchStatus
          : searchStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      searchMode: null == searchMode
          ? _self.searchMode
          : searchMode // ignore: cast_nullable_to_non_nullable
              as SearchMode,
      locationResult: freezed == locationResult
          ? _self.locationResult
          : locationResult // ignore: cast_nullable_to_non_nullable
              as LocationResult?,
      plusCode: freezed == plusCode
          ? _self.plusCode
          : plusCode // ignore: cast_nullable_to_non_nullable
              as PlusCode?,
      searchErrorMessage: freezed == searchErrorMessage
          ? _self.searchErrorMessage
          : searchErrorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }

  /// Create a copy of SearchState
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

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlusCodeCopyWith<$Res>? get plusCode {
    if (_self.plusCode == null) {
      return null;
    }

    return $PlusCodeCopyWith<$Res>(_self.plusCode!, (value) {
      return _then(_self.copyWith(plusCode: value));
    });
  }
}

// dart format on
