// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'network_log.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NetworkLog {
  String get id;
  String get url;
  String get method;
  DateTime get timestamp;
  Map<String, dynamic>? get requestHeaders;
  dynamic get requestBody;
  int? get statusCode;
  Map<String, dynamic>? get responseHeaders;
  dynamic get responseBody;
  int? get durationMs;
  String? get errorMessage;
  @JsonKey(includeFromJson: false, includeToJson: false)
  StackTrace? get stackTrace;

  /// Create a copy of NetworkLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $NetworkLogCopyWith<NetworkLog> get copyWith =>
      _$NetworkLogCopyWithImpl<NetworkLog>(this as NetworkLog, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is NetworkLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other.requestHeaders, requestHeaders) &&
            const DeepCollectionEquality()
                .equals(other.requestBody, requestBody) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality()
                .equals(other.responseHeaders, responseHeaders) &&
            const DeepCollectionEquality()
                .equals(other.responseBody, responseBody) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      method,
      timestamp,
      const DeepCollectionEquality().hash(requestHeaders),
      const DeepCollectionEquality().hash(requestBody),
      statusCode,
      const DeepCollectionEquality().hash(responseHeaders),
      const DeepCollectionEquality().hash(responseBody),
      durationMs,
      errorMessage,
      stackTrace);

  @override
  String toString() {
    return 'NetworkLog(id: $id, url: $url, method: $method, timestamp: $timestamp, requestHeaders: $requestHeaders, requestBody: $requestBody, statusCode: $statusCode, responseHeaders: $responseHeaders, responseBody: $responseBody, durationMs: $durationMs, errorMessage: $errorMessage, stackTrace: $stackTrace)';
  }
}

/// @nodoc
abstract mixin class $NetworkLogCopyWith<$Res> {
  factory $NetworkLogCopyWith(
          NetworkLog value, $Res Function(NetworkLog) _then) =
      _$NetworkLogCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      String url,
      String method,
      DateTime timestamp,
      Map<String, dynamic>? requestHeaders,
      dynamic requestBody,
      int? statusCode,
      Map<String, dynamic>? responseHeaders,
      dynamic responseBody,
      int? durationMs,
      String? errorMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      StackTrace? stackTrace});
}

/// @nodoc
class _$NetworkLogCopyWithImpl<$Res> implements $NetworkLogCopyWith<$Res> {
  _$NetworkLogCopyWithImpl(this._self, this._then);

  final NetworkLog _self;
  final $Res Function(NetworkLog) _then;

  /// Create a copy of NetworkLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? method = null,
    Object? timestamp = null,
    Object? requestHeaders = freezed,
    Object? requestBody = freezed,
    Object? statusCode = freezed,
    Object? responseHeaders = freezed,
    Object? responseBody = freezed,
    Object? durationMs = freezed,
    Object? errorMessage = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestHeaders: freezed == requestHeaders
          ? _self.requestHeaders
          : requestHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      requestBody: freezed == requestBody
          ? _self.requestBody
          : requestBody // ignore: cast_nullable_to_non_nullable
              as dynamic,
      statusCode: freezed == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      responseHeaders: freezed == responseHeaders
          ? _self.responseHeaders
          : responseHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      responseBody: freezed == responseBody
          ? _self.responseBody
          : responseBody // ignore: cast_nullable_to_non_nullable
              as dynamic,
      durationMs: freezed == durationMs
          ? _self.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      stackTrace: freezed == stackTrace
          ? _self.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

/// Adds pattern-matching-related methods to [NetworkLog].
extension NetworkLogPatterns on NetworkLog {
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
    TResult Function(_NetworkLog value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NetworkLog() when $default != null:
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
    TResult Function(_NetworkLog value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NetworkLog():
        return $default(_that);
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
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_NetworkLog value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NetworkLog() when $default != null:
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
            String id,
            String url,
            String method,
            DateTime timestamp,
            Map<String, dynamic>? requestHeaders,
            dynamic requestBody,
            int? statusCode,
            Map<String, dynamic>? responseHeaders,
            dynamic responseBody,
            int? durationMs,
            String? errorMessage,
            @JsonKey(includeFromJson: false, includeToJson: false)
            StackTrace? stackTrace)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _NetworkLog() when $default != null:
        return $default(
            _that.id,
            _that.url,
            _that.method,
            _that.timestamp,
            _that.requestHeaders,
            _that.requestBody,
            _that.statusCode,
            _that.responseHeaders,
            _that.responseBody,
            _that.durationMs,
            _that.errorMessage,
            _that.stackTrace);
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
            String id,
            String url,
            String method,
            DateTime timestamp,
            Map<String, dynamic>? requestHeaders,
            dynamic requestBody,
            int? statusCode,
            Map<String, dynamic>? responseHeaders,
            dynamic responseBody,
            int? durationMs,
            String? errorMessage,
            @JsonKey(includeFromJson: false, includeToJson: false)
            StackTrace? stackTrace)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NetworkLog():
        return $default(
            _that.id,
            _that.url,
            _that.method,
            _that.timestamp,
            _that.requestHeaders,
            _that.requestBody,
            _that.statusCode,
            _that.responseHeaders,
            _that.responseBody,
            _that.durationMs,
            _that.errorMessage,
            _that.stackTrace);
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
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            String url,
            String method,
            DateTime timestamp,
            Map<String, dynamic>? requestHeaders,
            dynamic requestBody,
            int? statusCode,
            Map<String, dynamic>? responseHeaders,
            dynamic responseBody,
            int? durationMs,
            String? errorMessage,
            @JsonKey(includeFromJson: false, includeToJson: false)
            StackTrace? stackTrace)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _NetworkLog() when $default != null:
        return $default(
            _that.id,
            _that.url,
            _that.method,
            _that.timestamp,
            _that.requestHeaders,
            _that.requestBody,
            _that.statusCode,
            _that.responseHeaders,
            _that.responseBody,
            _that.durationMs,
            _that.errorMessage,
            _that.stackTrace);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _NetworkLog extends NetworkLog {
  const _NetworkLog(
      {required this.id,
      required this.url,
      required this.method,
      required this.timestamp,
      final Map<String, dynamic>? requestHeaders,
      this.requestBody,
      this.statusCode,
      final Map<String, dynamic>? responseHeaders,
      this.responseBody,
      this.durationMs,
      this.errorMessage,
      @JsonKey(includeFromJson: false, includeToJson: false) this.stackTrace})
      : _requestHeaders = requestHeaders,
        _responseHeaders = responseHeaders,
        super._();

  @override
  final String id;
  @override
  final String url;
  @override
  final String method;
  @override
  final DateTime timestamp;
  final Map<String, dynamic>? _requestHeaders;
  @override
  Map<String, dynamic>? get requestHeaders {
    final value = _requestHeaders;
    if (value == null) return null;
    if (_requestHeaders is EqualUnmodifiableMapView) return _requestHeaders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final dynamic requestBody;
  @override
  final int? statusCode;
  final Map<String, dynamic>? _responseHeaders;
  @override
  Map<String, dynamic>? get responseHeaders {
    final value = _responseHeaders;
    if (value == null) return null;
    if (_responseHeaders is EqualUnmodifiableMapView) return _responseHeaders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final dynamic responseBody;
  @override
  final int? durationMs;
  @override
  final String? errorMessage;
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  final StackTrace? stackTrace;

  /// Create a copy of NetworkLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$NetworkLogCopyWith<_NetworkLog> get copyWith =>
      __$NetworkLogCopyWithImpl<_NetworkLog>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _NetworkLog &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.method, method) || other.method == method) &&
            (identical(other.timestamp, timestamp) ||
                other.timestamp == timestamp) &&
            const DeepCollectionEquality()
                .equals(other._requestHeaders, _requestHeaders) &&
            const DeepCollectionEquality()
                .equals(other.requestBody, requestBody) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality()
                .equals(other._responseHeaders, _responseHeaders) &&
            const DeepCollectionEquality()
                .equals(other.responseBody, responseBody) &&
            (identical(other.durationMs, durationMs) ||
                other.durationMs == durationMs) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.stackTrace, stackTrace) ||
                other.stackTrace == stackTrace));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      url,
      method,
      timestamp,
      const DeepCollectionEquality().hash(_requestHeaders),
      const DeepCollectionEquality().hash(requestBody),
      statusCode,
      const DeepCollectionEquality().hash(_responseHeaders),
      const DeepCollectionEquality().hash(responseBody),
      durationMs,
      errorMessage,
      stackTrace);

  @override
  String toString() {
    return 'NetworkLog(id: $id, url: $url, method: $method, timestamp: $timestamp, requestHeaders: $requestHeaders, requestBody: $requestBody, statusCode: $statusCode, responseHeaders: $responseHeaders, responseBody: $responseBody, durationMs: $durationMs, errorMessage: $errorMessage, stackTrace: $stackTrace)';
  }
}

/// @nodoc
abstract mixin class _$NetworkLogCopyWith<$Res>
    implements $NetworkLogCopyWith<$Res> {
  factory _$NetworkLogCopyWith(
          _NetworkLog value, $Res Function(_NetworkLog) _then) =
      __$NetworkLogCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      String url,
      String method,
      DateTime timestamp,
      Map<String, dynamic>? requestHeaders,
      dynamic requestBody,
      int? statusCode,
      Map<String, dynamic>? responseHeaders,
      dynamic responseBody,
      int? durationMs,
      String? errorMessage,
      @JsonKey(includeFromJson: false, includeToJson: false)
      StackTrace? stackTrace});
}

/// @nodoc
class __$NetworkLogCopyWithImpl<$Res> implements _$NetworkLogCopyWith<$Res> {
  __$NetworkLogCopyWithImpl(this._self, this._then);

  final _NetworkLog _self;
  final $Res Function(_NetworkLog) _then;

  /// Create a copy of NetworkLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? url = null,
    Object? method = null,
    Object? timestamp = null,
    Object? requestHeaders = freezed,
    Object? requestBody = freezed,
    Object? statusCode = freezed,
    Object? responseHeaders = freezed,
    Object? responseBody = freezed,
    Object? durationMs = freezed,
    Object? errorMessage = freezed,
    Object? stackTrace = freezed,
  }) {
    return _then(_NetworkLog(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      url: null == url
          ? _self.url
          : url // ignore: cast_nullable_to_non_nullable
              as String,
      method: null == method
          ? _self.method
          : method // ignore: cast_nullable_to_non_nullable
              as String,
      timestamp: null == timestamp
          ? _self.timestamp
          : timestamp // ignore: cast_nullable_to_non_nullable
              as DateTime,
      requestHeaders: freezed == requestHeaders
          ? _self._requestHeaders
          : requestHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      requestBody: freezed == requestBody
          ? _self.requestBody
          : requestBody // ignore: cast_nullable_to_non_nullable
              as dynamic,
      statusCode: freezed == statusCode
          ? _self.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      responseHeaders: freezed == responseHeaders
          ? _self._responseHeaders
          : responseHeaders // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>?,
      responseBody: freezed == responseBody
          ? _self.responseBody
          : responseBody // ignore: cast_nullable_to_non_nullable
              as dynamic,
      durationMs: freezed == durationMs
          ? _self.durationMs
          : durationMs // ignore: cast_nullable_to_non_nullable
              as int?,
      errorMessage: freezed == errorMessage
          ? _self.errorMessage
          : errorMessage // ignore: cast_nullable_to_non_nullable
              as String?,
      stackTrace: freezed == stackTrace
          ? _self.stackTrace
          : stackTrace // ignore: cast_nullable_to_non_nullable
              as StackTrace?,
    ));
  }
}

// dart format on
