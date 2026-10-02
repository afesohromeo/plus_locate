// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
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
    TResult Function(_QueryChanged value)? queryChanged,
    TResult Function(_SuggestionSelected value)? suggestionSelected,
    TResult Function(_SubmitQuery value)? submitQuery,
    TResult Function(_Reset value)? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that);
      case _SuggestionSelected() when suggestionSelected != null:
        return suggestionSelected(_that);
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
    required TResult Function(_QueryChanged value) queryChanged,
    required TResult Function(_SuggestionSelected value) suggestionSelected,
    required TResult Function(_SubmitQuery value) submitQuery,
    required TResult Function(_Reset value) reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init(_that);
      case _QueryChanged():
        return queryChanged(_that);
      case _SuggestionSelected():
        return suggestionSelected(_that);
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
    TResult? Function(_QueryChanged value)? queryChanged,
    TResult? Function(_SuggestionSelected value)? suggestionSelected,
    TResult? Function(_SubmitQuery value)? submitQuery,
    TResult? Function(_Reset value)? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init(_that);
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that);
      case _SuggestionSelected() when suggestionSelected != null:
        return suggestionSelected(_that);
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
    TResult Function(String query)? queryChanged,
    TResult Function(PlaceSuggestion suggestion)? suggestionSelected,
    TResult Function(String query)? submitQuery,
    TResult Function()? reset,
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that.query);
      case _SuggestionSelected() when suggestionSelected != null:
        return suggestionSelected(_that.suggestion);
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
    required TResult Function(String query) queryChanged,
    required TResult Function(PlaceSuggestion suggestion) suggestionSelected,
    required TResult Function(String query) submitQuery,
    required TResult Function() reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init():
        return init();
      case _QueryChanged():
        return queryChanged(_that.query);
      case _SuggestionSelected():
        return suggestionSelected(_that.suggestion);
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
    TResult? Function(String query)? queryChanged,
    TResult? Function(PlaceSuggestion suggestion)? suggestionSelected,
    TResult? Function(String query)? submitQuery,
    TResult? Function()? reset,
  }) {
    final _that = this;
    switch (_that) {
      case _Init() when init != null:
        return init();
      case _QueryChanged() when queryChanged != null:
        return queryChanged(_that.query);
      case _SuggestionSelected() when suggestionSelected != null:
        return suggestionSelected(_that.suggestion);
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

class _QueryChanged implements SearchEvent {
  const _QueryChanged({required this.query});

  final String query;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$QueryChangedCopyWith<_QueryChanged> get copyWith =>
      __$QueryChangedCopyWithImpl<_QueryChanged>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _QueryChanged &&
            (identical(other.query, query) || other.query == query));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, query);
  }

  @override
  String toString() {
    return 'SearchEvent.queryChanged(query: $query)';
  }
}

/// @nodoc
abstract mixin class _$QueryChangedCopyWith<$Res>
    implements $SearchEventCopyWith<$Res> {
  factory _$QueryChangedCopyWith(
          _QueryChanged value, $Res Function(_QueryChanged) _then) =
      __$QueryChangedCopyWithImpl;
  @useResult
  $Res call({String query});
}

/// @nodoc
class __$QueryChangedCopyWithImpl<$Res>
    implements _$QueryChangedCopyWith<$Res> {
  __$QueryChangedCopyWithImpl(this._self, this._then);

  final _QueryChanged _self;
  final $Res Function(_QueryChanged) _then;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? query = null,
  }) {
    return _then(_QueryChanged(
      query: null == query
          ? _self.query
          : query // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _SuggestionSelected implements SearchEvent {
  const _SuggestionSelected({required this.suggestion});

  final PlaceSuggestion suggestion;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$SuggestionSelectedCopyWith<_SuggestionSelected> get copyWith =>
      __$SuggestionSelectedCopyWithImpl<_SuggestionSelected>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _SuggestionSelected &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, suggestion);
  }

  @override
  String toString() {
    return 'SearchEvent.suggestionSelected(suggestion: $suggestion)';
  }
}

/// @nodoc
abstract mixin class _$SuggestionSelectedCopyWith<$Res>
    implements $SearchEventCopyWith<$Res> {
  factory _$SuggestionSelectedCopyWith(
          _SuggestionSelected value, $Res Function(_SuggestionSelected) _then) =
      __$SuggestionSelectedCopyWithImpl;
  @useResult
  $Res call({PlaceSuggestion suggestion});

  $PlaceSuggestionCopyWith<$Res> get suggestion;
}

/// @nodoc
class __$SuggestionSelectedCopyWithImpl<$Res>
    implements _$SuggestionSelectedCopyWith<$Res> {
  __$SuggestionSelectedCopyWithImpl(this._self, this._then);

  final _SuggestionSelected _self;
  final $Res Function(_SuggestionSelected) _then;

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  $Res call({
    Object? suggestion = null,
  }) {
    return _then(_SuggestionSelected(
      suggestion: null == suggestion
          ? _self.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as PlaceSuggestion,
    ));
  }

  /// Create a copy of SearchEvent
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $PlaceSuggestionCopyWith<$Res> get suggestion {
    return $PlaceSuggestionCopyWith<$Res>(_self.suggestion, (value) {
      return _then(_self.copyWith(suggestion: value));
    });
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
  int get hashCode {
    return Object.hash(runtimeType, query);
  }

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
  GenericStatus get suggestionsStatus;
  List<PlaceSuggestion> get suggestions;
  String? get suggestionsErrorMessage;

  /// Create a copy of SearchState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $SearchStateCopyWith<SearchState> get copyWith =>
      _$SearchStateCopyWithImpl<SearchState>(this as SearchState, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as SearchState;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is SearchState &&
            (identical(other.searchStatus, _this.searchStatus) ||
                other.searchStatus == _this.searchStatus) &&
            (identical(other.searchMode, _this.searchMode) ||
                other.searchMode == _this.searchMode) &&
            (identical(other.locationResult, _this.locationResult) ||
                other.locationResult == _this.locationResult) &&
            (identical(other.plusCode, _this.plusCode) ||
                other.plusCode == _this.plusCode) &&
            (identical(other.searchErrorMessage, _this.searchErrorMessage) ||
                other.searchErrorMessage == _this.searchErrorMessage) &&
            (identical(other.suggestionsStatus, _this.suggestionsStatus) ||
                other.suggestionsStatus == _this.suggestionsStatus) &&
            const DeepCollectionEquality()
                .equals(other.suggestions, _this.suggestions) &&
            (identical(other.suggestionsErrorMessage,
                    _this.suggestionsErrorMessage) ||
                other.suggestionsErrorMessage ==
                    _this.suggestionsErrorMessage));
  }

  @override
  int get hashCode {
    final _this = this as SearchState;
    return Object.hash(
        runtimeType,
        _this.searchStatus,
        _this.searchMode,
        _this.locationResult,
        _this.plusCode,
        _this.searchErrorMessage,
        _this.suggestionsStatus,
        const DeepCollectionEquality().hash(_this.suggestions),
        _this.suggestionsErrorMessage);
  }

  @override
  String toString() {
    final _this = this as SearchState;
    return 'SearchState(searchStatus: ${_this.searchStatus}, searchMode: ${_this.searchMode}, locationResult: ${_this.locationResult}, plusCode: ${_this.plusCode}, searchErrorMessage: ${_this.searchErrorMessage}, suggestionsStatus: ${_this.suggestionsStatus}, suggestions: ${_this.suggestions}, suggestionsErrorMessage: ${_this.suggestionsErrorMessage})';
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
      String? searchErrorMessage,
      GenericStatus suggestionsStatus,
      List<PlaceSuggestion> suggestions,
      String? suggestionsErrorMessage});

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
    Object? suggestionsStatus = null,
    Object? suggestions = null,
    Object? suggestionsErrorMessage = freezed,
  }) {
    return _then(SearchState(
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
      suggestionsStatus: null == suggestionsStatus
          ? _self.suggestionsStatus
          : suggestionsStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      suggestions: null == suggestions
          ? _self.suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<PlaceSuggestion>,
      suggestionsErrorMessage: freezed == suggestionsErrorMessage
          ? _self.suggestionsErrorMessage
          : suggestionsErrorMessage // ignore: cast_nullable_to_non_nullable
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
            String? searchErrorMessage,
            GenericStatus suggestionsStatus,
            List<PlaceSuggestion> suggestions,
            String? suggestionsErrorMessage)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
        return $default(
            _that.searchStatus,
            _that.searchMode,
            _that.locationResult,
            _that.plusCode,
            _that.searchErrorMessage,
            _that.suggestionsStatus,
            _that.suggestions,
            _that.suggestionsErrorMessage);
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
            String? searchErrorMessage,
            GenericStatus suggestionsStatus,
            List<PlaceSuggestion> suggestions,
            String? suggestionsErrorMessage)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState():
        return $default(
            _that.searchStatus,
            _that.searchMode,
            _that.locationResult,
            _that.plusCode,
            _that.searchErrorMessage,
            _that.suggestionsStatus,
            _that.suggestions,
            _that.suggestionsErrorMessage);
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
            String? searchErrorMessage,
            GenericStatus suggestionsStatus,
            List<PlaceSuggestion> suggestions,
            String? suggestionsErrorMessage)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _SearchState() when $default != null:
        return $default(
            _that.searchStatus,
            _that.searchMode,
            _that.locationResult,
            _that.plusCode,
            _that.searchErrorMessage,
            _that.suggestionsStatus,
            _that.suggestions,
            _that.suggestionsErrorMessage);
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
      this.searchErrorMessage,
      this.suggestionsStatus = GenericStatus.initial,
      List<PlaceSuggestion> suggestions = const <PlaceSuggestion>[],
      this.suggestionsErrorMessage})
      : _suggestions = suggestions,
        super._();

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
  @override
  @JsonKey()
  final GenericStatus suggestionsStatus;
  final List<PlaceSuggestion> _suggestions;
  @override
  @JsonKey()
  List<PlaceSuggestion> get suggestions {
    if (_suggestions is EqualUnmodifiableListView) return _suggestions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_suggestions);
  }

  @override
  final String? suggestionsErrorMessage;

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
                other.searchErrorMessage == searchErrorMessage) &&
            (identical(other.suggestionsStatus, suggestionsStatus) ||
                other.suggestionsStatus == suggestionsStatus) &&
            const DeepCollectionEquality()
                .equals(other.suggestions, _suggestions) &&
            (identical(
                    other.suggestionsErrorMessage, suggestionsErrorMessage) ||
                other.suggestionsErrorMessage == suggestionsErrorMessage));
  }

  @override
  int get hashCode {
    return Object.hash(
        runtimeType,
        searchStatus,
        searchMode,
        locationResult,
        plusCode,
        searchErrorMessage,
        suggestionsStatus,
        const DeepCollectionEquality().hash(_suggestions),
        suggestionsErrorMessage);
  }

  @override
  String toString() {
    return 'SearchState(searchStatus: $searchStatus, searchMode: $searchMode, locationResult: $locationResult, plusCode: $plusCode, searchErrorMessage: $searchErrorMessage, suggestionsStatus: $suggestionsStatus, suggestions: $suggestions, suggestionsErrorMessage: $suggestionsErrorMessage)';
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
      String? searchErrorMessage,
      GenericStatus suggestionsStatus,
      List<PlaceSuggestion> suggestions,
      String? suggestionsErrorMessage});

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
    Object? suggestionsStatus = null,
    Object? suggestions = null,
    Object? suggestionsErrorMessage = freezed,
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
      suggestionsStatus: null == suggestionsStatus
          ? _self.suggestionsStatus
          : suggestionsStatus // ignore: cast_nullable_to_non_nullable
              as GenericStatus,
      suggestions: null == suggestions
          ? _self._suggestions
          : suggestions // ignore: cast_nullable_to_non_nullable
              as List<PlaceSuggestion>,
      suggestionsErrorMessage: freezed == suggestionsErrorMessage
          ? _self.suggestionsErrorMessage
          : suggestionsErrorMessage // ignore: cast_nullable_to_non_nullable
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
