// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint, type=warning, deprecated_member_use, deprecated_member_use_from_same_package
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_suggestion.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceSuggestion {
  /// Place ID used to fetch the place details
  String get placeId;

  /// Full prediction text, e.g. "Douala, Cameroon"
  String? get fullText;

  /// Primary line, e.g. "Douala"
  String? get mainText;

  /// Secondary line, e.g. "Cameroon"
  String? get secondaryText;

  /// Create a copy of PlaceSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $PlaceSuggestionCopyWith<PlaceSuggestion> get copyWith =>
      _$PlaceSuggestionCopyWithImpl<PlaceSuggestion>(
          this as PlaceSuggestion, _$identity);

  @override
  bool operator ==(Object other) {
    final _this = this as PlaceSuggestion;
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is PlaceSuggestion &&
            (identical(other.placeId, _this.placeId) ||
                other.placeId == _this.placeId) &&
            (identical(other.fullText, _this.fullText) ||
                other.fullText == _this.fullText) &&
            (identical(other.mainText, _this.mainText) ||
                other.mainText == _this.mainText) &&
            (identical(other.secondaryText, _this.secondaryText) ||
                other.secondaryText == _this.secondaryText));
  }

  @override
  int get hashCode {
    final _this = this as PlaceSuggestion;
    return Object.hash(runtimeType, _this.placeId, _this.fullText,
        _this.mainText, _this.secondaryText);
  }

  @override
  String toString() {
    final _this = this as PlaceSuggestion;
    return 'PlaceSuggestion(placeId: ${_this.placeId}, fullText: ${_this.fullText}, mainText: ${_this.mainText}, secondaryText: ${_this.secondaryText})';
  }
}

/// @nodoc
abstract mixin class $PlaceSuggestionCopyWith<$Res> {
  factory $PlaceSuggestionCopyWith(
          PlaceSuggestion value, $Res Function(PlaceSuggestion) _then) =
      _$PlaceSuggestionCopyWithImpl;
  @useResult
  $Res call(
      {String placeId,
      String? fullText,
      String? mainText,
      String? secondaryText});
}

/// @nodoc
class _$PlaceSuggestionCopyWithImpl<$Res>
    implements $PlaceSuggestionCopyWith<$Res> {
  _$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final PlaceSuggestion _self;
  final $Res Function(PlaceSuggestion) _then;

  /// Create a copy of PlaceSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? placeId = null,
    Object? fullText = freezed,
    Object? mainText = freezed,
    Object? secondaryText = freezed,
  }) {
    return _then(PlaceSuggestion(
      placeId: null == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      fullText: freezed == fullText
          ? _self.fullText
          : fullText // ignore: cast_nullable_to_non_nullable
              as String?,
      mainText: freezed == mainText
          ? _self.mainText
          : mainText // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryText: freezed == secondaryText
          ? _self.secondaryText
          : secondaryText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [PlaceSuggestion].
extension PlaceSuggestionPatterns on PlaceSuggestion {
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
    TResult Function(_PlaceSuggestion value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaceSuggestion() when $default != null:
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
    TResult Function(_PlaceSuggestion value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaceSuggestion():
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
    TResult? Function(_PlaceSuggestion value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaceSuggestion() when $default != null:
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
    TResult Function(String placeId, String? fullText, String? mainText,
            String? secondaryText)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _PlaceSuggestion() when $default != null:
        return $default(
            _that.placeId, _that.fullText, _that.mainText, _that.secondaryText);
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
    TResult Function(String placeId, String? fullText, String? mainText,
            String? secondaryText)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaceSuggestion():
        return $default(
            _that.placeId, _that.fullText, _that.mainText, _that.secondaryText);
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
    TResult? Function(String placeId, String? fullText, String? mainText,
            String? secondaryText)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _PlaceSuggestion() when $default != null:
        return $default(
            _that.placeId, _that.fullText, _that.mainText, _that.secondaryText);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _PlaceSuggestion extends PlaceSuggestion {
  const _PlaceSuggestion(
      {required this.placeId, this.fullText, this.mainText, this.secondaryText})
      : super._();

  /// Place ID used to fetch the place details
  @override
  final String placeId;

  /// Full prediction text, e.g. "Douala, Cameroon"
  @override
  final String? fullText;

  /// Primary line, e.g. "Douala"
  @override
  final String? mainText;

  /// Secondary line, e.g. "Cameroon"
  @override
  final String? secondaryText;

  /// Create a copy of PlaceSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$PlaceSuggestionCopyWith<_PlaceSuggestion> get copyWith =>
      __$PlaceSuggestionCopyWithImpl<_PlaceSuggestion>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _PlaceSuggestion &&
            (identical(other.placeId, placeId) || other.placeId == placeId) &&
            (identical(other.fullText, fullText) ||
                other.fullText == fullText) &&
            (identical(other.mainText, mainText) ||
                other.mainText == mainText) &&
            (identical(other.secondaryText, secondaryText) ||
                other.secondaryText == secondaryText));
  }

  @override
  int get hashCode {
    return Object.hash(runtimeType, placeId, fullText, mainText, secondaryText);
  }

  @override
  String toString() {
    return 'PlaceSuggestion(placeId: $placeId, fullText: $fullText, mainText: $mainText, secondaryText: $secondaryText)';
  }
}

/// @nodoc
abstract mixin class _$PlaceSuggestionCopyWith<$Res>
    implements $PlaceSuggestionCopyWith<$Res> {
  factory _$PlaceSuggestionCopyWith(
          _PlaceSuggestion value, $Res Function(_PlaceSuggestion) _then) =
      __$PlaceSuggestionCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String placeId,
      String? fullText,
      String? mainText,
      String? secondaryText});
}

/// @nodoc
class __$PlaceSuggestionCopyWithImpl<$Res>
    implements _$PlaceSuggestionCopyWith<$Res> {
  __$PlaceSuggestionCopyWithImpl(this._self, this._then);

  final _PlaceSuggestion _self;
  final $Res Function(_PlaceSuggestion) _then;

  /// Create a copy of PlaceSuggestion
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? placeId = null,
    Object? fullText = freezed,
    Object? mainText = freezed,
    Object? secondaryText = freezed,
  }) {
    return _then(_PlaceSuggestion(
      placeId: null == placeId
          ? _self.placeId
          : placeId // ignore: cast_nullable_to_non_nullable
              as String,
      fullText: freezed == fullText
          ? _self.fullText
          : fullText // ignore: cast_nullable_to_non_nullable
              as String?,
      mainText: freezed == mainText
          ? _self.mainText
          : mainText // ignore: cast_nullable_to_non_nullable
              as String?,
      secondaryText: freezed == secondaryText
          ? _self.secondaryText
          : secondaryText // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
