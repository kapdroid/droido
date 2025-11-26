// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'droido_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DroidoConfig {
  /// Maximum number of logs to keep in memory
  int get maxLogs;

  /// Enable persistent notification
  bool get enableNotification;

  /// Notification title
  String get notificationTitle;

  /// Notification channel ID (Android)
  String get notificationChannelId;

  /// Notification channel name (Android)
  String get notificationChannelName;

  /// Make notification non-dismissable (ongoing)
  ///
  /// When true, the notification cannot be swiped away and will persist
  /// until the app is closed or Droido is disposed. Useful for ensuring
  /// debug panel is always accessible.
  bool get notificationOngoing;

  /// External FlutterLocalNotificationsPlugin instance
  ///
  /// Provide this if your app already has a notification plugin instance
  /// to avoid conflicts. When provided, Droido will use this instance instead
  /// of creating its own. You'll need to route notification taps to Droido manually.
  FlutterLocalNotificationsPlugin? get externalNotificationPlugin;

  /// Include request headers in logs
  bool get includeRequestHeaders;

  /// Include response headers in logs
  bool get includeResponseHeaders;

  /// Include request body in logs
  bool get includeRequestBody;

  /// Include response body in logs
  bool get includeResponseBody;

  /// Maximum body size to log (in bytes). Set to null for unlimited.
  int? get maxBodySize; // 1MB default
  /// Auto-clear logs on app restart
  bool get autoClearOnRestart;

  /// Create a copy of DroidoConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $DroidoConfigCopyWith<DroidoConfig> get copyWith =>
      _$DroidoConfigCopyWithImpl<DroidoConfig>(
          this as DroidoConfig, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is DroidoConfig &&
            (identical(other.maxLogs, maxLogs) || other.maxLogs == maxLogs) &&
            (identical(other.enableNotification, enableNotification) ||
                other.enableNotification == enableNotification) &&
            (identical(other.notificationTitle, notificationTitle) ||
                other.notificationTitle == notificationTitle) &&
            (identical(other.notificationChannelId, notificationChannelId) ||
                other.notificationChannelId == notificationChannelId) &&
            (identical(
                    other.notificationChannelName, notificationChannelName) ||
                other.notificationChannelName == notificationChannelName) &&
            (identical(other.notificationOngoing, notificationOngoing) ||
                other.notificationOngoing == notificationOngoing) &&
            (identical(other.externalNotificationPlugin,
                    externalNotificationPlugin) ||
                other.externalNotificationPlugin ==
                    externalNotificationPlugin) &&
            (identical(other.includeRequestHeaders, includeRequestHeaders) ||
                other.includeRequestHeaders == includeRequestHeaders) &&
            (identical(other.includeResponseHeaders, includeResponseHeaders) ||
                other.includeResponseHeaders == includeResponseHeaders) &&
            (identical(other.includeRequestBody, includeRequestBody) ||
                other.includeRequestBody == includeRequestBody) &&
            (identical(other.includeResponseBody, includeResponseBody) ||
                other.includeResponseBody == includeResponseBody) &&
            (identical(other.maxBodySize, maxBodySize) ||
                other.maxBodySize == maxBodySize) &&
            (identical(other.autoClearOnRestart, autoClearOnRestart) ||
                other.autoClearOnRestart == autoClearOnRestart));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      maxLogs,
      enableNotification,
      notificationTitle,
      notificationChannelId,
      notificationChannelName,
      notificationOngoing,
      externalNotificationPlugin,
      includeRequestHeaders,
      includeResponseHeaders,
      includeRequestBody,
      includeResponseBody,
      maxBodySize,
      autoClearOnRestart);

  @override
  String toString() {
    return 'DroidoConfig(maxLogs: $maxLogs, enableNotification: $enableNotification, notificationTitle: $notificationTitle, notificationChannelId: $notificationChannelId, notificationChannelName: $notificationChannelName, notificationOngoing: $notificationOngoing, externalNotificationPlugin: $externalNotificationPlugin, includeRequestHeaders: $includeRequestHeaders, includeResponseHeaders: $includeResponseHeaders, includeRequestBody: $includeRequestBody, includeResponseBody: $includeResponseBody, maxBodySize: $maxBodySize, autoClearOnRestart: $autoClearOnRestart)';
  }
}

/// @nodoc
abstract mixin class $DroidoConfigCopyWith<$Res> {
  factory $DroidoConfigCopyWith(
          DroidoConfig value, $Res Function(DroidoConfig) _then) =
      _$DroidoConfigCopyWithImpl;
  @useResult
  $Res call(
      {int maxLogs,
      bool enableNotification,
      String notificationTitle,
      String notificationChannelId,
      String notificationChannelName,
      bool notificationOngoing,
      FlutterLocalNotificationsPlugin? externalNotificationPlugin,
      bool includeRequestHeaders,
      bool includeResponseHeaders,
      bool includeRequestBody,
      bool includeResponseBody,
      int? maxBodySize,
      bool autoClearOnRestart});
}

/// @nodoc
class _$DroidoConfigCopyWithImpl<$Res> implements $DroidoConfigCopyWith<$Res> {
  _$DroidoConfigCopyWithImpl(this._self, this._then);

  final DroidoConfig _self;
  final $Res Function(DroidoConfig) _then;

  /// Create a copy of DroidoConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? maxLogs = null,
    Object? enableNotification = null,
    Object? notificationTitle = null,
    Object? notificationChannelId = null,
    Object? notificationChannelName = null,
    Object? notificationOngoing = null,
    Object? externalNotificationPlugin = freezed,
    Object? includeRequestHeaders = null,
    Object? includeResponseHeaders = null,
    Object? includeRequestBody = null,
    Object? includeResponseBody = null,
    Object? maxBodySize = freezed,
    Object? autoClearOnRestart = null,
  }) {
    return _then(_self.copyWith(
      maxLogs: null == maxLogs
          ? _self.maxLogs
          : maxLogs // ignore: cast_nullable_to_non_nullable
              as int,
      enableNotification: null == enableNotification
          ? _self.enableNotification
          : enableNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationTitle: null == notificationTitle
          ? _self.notificationTitle
          : notificationTitle // ignore: cast_nullable_to_non_nullable
              as String,
      notificationChannelId: null == notificationChannelId
          ? _self.notificationChannelId
          : notificationChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationChannelName: null == notificationChannelName
          ? _self.notificationChannelName
          : notificationChannelName // ignore: cast_nullable_to_non_nullable
              as String,
      notificationOngoing: null == notificationOngoing
          ? _self.notificationOngoing
          : notificationOngoing // ignore: cast_nullable_to_non_nullable
              as bool,
      externalNotificationPlugin: freezed == externalNotificationPlugin
          ? _self.externalNotificationPlugin
          : externalNotificationPlugin // ignore: cast_nullable_to_non_nullable
              as FlutterLocalNotificationsPlugin?,
      includeRequestHeaders: null == includeRequestHeaders
          ? _self.includeRequestHeaders
          : includeRequestHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      includeResponseHeaders: null == includeResponseHeaders
          ? _self.includeResponseHeaders
          : includeResponseHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      includeRequestBody: null == includeRequestBody
          ? _self.includeRequestBody
          : includeRequestBody // ignore: cast_nullable_to_non_nullable
              as bool,
      includeResponseBody: null == includeResponseBody
          ? _self.includeResponseBody
          : includeResponseBody // ignore: cast_nullable_to_non_nullable
              as bool,
      maxBodySize: freezed == maxBodySize
          ? _self.maxBodySize
          : maxBodySize // ignore: cast_nullable_to_non_nullable
              as int?,
      autoClearOnRestart: null == autoClearOnRestart
          ? _self.autoClearOnRestart
          : autoClearOnRestart // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// Adds pattern-matching-related methods to [DroidoConfig].
extension DroidoConfigPatterns on DroidoConfig {
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
    TResult Function(_DroidoConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DroidoConfig() when $default != null:
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
    TResult Function(_DroidoConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DroidoConfig():
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
    TResult? Function(_DroidoConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DroidoConfig() when $default != null:
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
            int maxLogs,
            bool enableNotification,
            String notificationTitle,
            String notificationChannelId,
            String notificationChannelName,
            bool notificationOngoing,
            FlutterLocalNotificationsPlugin? externalNotificationPlugin,
            bool includeRequestHeaders,
            bool includeResponseHeaders,
            bool includeRequestBody,
            bool includeResponseBody,
            int? maxBodySize,
            bool autoClearOnRestart)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _DroidoConfig() when $default != null:
        return $default(
            _that.maxLogs,
            _that.enableNotification,
            _that.notificationTitle,
            _that.notificationChannelId,
            _that.notificationChannelName,
            _that.notificationOngoing,
            _that.externalNotificationPlugin,
            _that.includeRequestHeaders,
            _that.includeResponseHeaders,
            _that.includeRequestBody,
            _that.includeResponseBody,
            _that.maxBodySize,
            _that.autoClearOnRestart);
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
            int maxLogs,
            bool enableNotification,
            String notificationTitle,
            String notificationChannelId,
            String notificationChannelName,
            bool notificationOngoing,
            FlutterLocalNotificationsPlugin? externalNotificationPlugin,
            bool includeRequestHeaders,
            bool includeResponseHeaders,
            bool includeRequestBody,
            bool includeResponseBody,
            int? maxBodySize,
            bool autoClearOnRestart)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DroidoConfig():
        return $default(
            _that.maxLogs,
            _that.enableNotification,
            _that.notificationTitle,
            _that.notificationChannelId,
            _that.notificationChannelName,
            _that.notificationOngoing,
            _that.externalNotificationPlugin,
            _that.includeRequestHeaders,
            _that.includeResponseHeaders,
            _that.includeRequestBody,
            _that.includeResponseBody,
            _that.maxBodySize,
            _that.autoClearOnRestart);
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
            int maxLogs,
            bool enableNotification,
            String notificationTitle,
            String notificationChannelId,
            String notificationChannelName,
            bool notificationOngoing,
            FlutterLocalNotificationsPlugin? externalNotificationPlugin,
            bool includeRequestHeaders,
            bool includeResponseHeaders,
            bool includeRequestBody,
            bool includeResponseBody,
            int? maxBodySize,
            bool autoClearOnRestart)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _DroidoConfig() when $default != null:
        return $default(
            _that.maxLogs,
            _that.enableNotification,
            _that.notificationTitle,
            _that.notificationChannelId,
            _that.notificationChannelName,
            _that.notificationOngoing,
            _that.externalNotificationPlugin,
            _that.includeRequestHeaders,
            _that.includeResponseHeaders,
            _that.includeRequestBody,
            _that.includeResponseBody,
            _that.maxBodySize,
            _that.autoClearOnRestart);
      case _:
        return null;
    }
  }
}

/// @nodoc

class _DroidoConfig extends DroidoConfig {
  const _DroidoConfig(
      {this.maxLogs = 500,
      this.enableNotification = true,
      this.notificationTitle = 'Debug Active',
      this.notificationChannelId = 'droido_debug_channel',
      this.notificationChannelName = 'Droido Debug',
      this.notificationOngoing = true,
      this.externalNotificationPlugin,
      this.includeRequestHeaders = true,
      this.includeResponseHeaders = true,
      this.includeRequestBody = true,
      this.includeResponseBody = true,
      this.maxBodySize = 1048576,
      this.autoClearOnRestart = false})
      : super._();

  /// Maximum number of logs to keep in memory
  @override
  @JsonKey()
  final int maxLogs;

  /// Enable persistent notification
  @override
  @JsonKey()
  final bool enableNotification;

  /// Notification title
  @override
  @JsonKey()
  final String notificationTitle;

  /// Notification channel ID (Android)
  @override
  @JsonKey()
  final String notificationChannelId;

  /// Notification channel name (Android)
  @override
  @JsonKey()
  final String notificationChannelName;

  /// Make notification non-dismissable (ongoing)
  ///
  /// When true, the notification cannot be swiped away and will persist
  /// until the app is closed or Droido is disposed. Useful for ensuring
  /// debug panel is always accessible.
  @override
  @JsonKey()
  final bool notificationOngoing;

  /// External FlutterLocalNotificationsPlugin instance
  ///
  /// Provide this if your app already has a notification plugin instance
  /// to avoid conflicts. When provided, Droido will use this instance instead
  /// of creating its own. You'll need to route notification taps to Droido manually.
  @override
  final FlutterLocalNotificationsPlugin? externalNotificationPlugin;

  /// Include request headers in logs
  @override
  @JsonKey()
  final bool includeRequestHeaders;

  /// Include response headers in logs
  @override
  @JsonKey()
  final bool includeResponseHeaders;

  /// Include request body in logs
  @override
  @JsonKey()
  final bool includeRequestBody;

  /// Include response body in logs
  @override
  @JsonKey()
  final bool includeResponseBody;

  /// Maximum body size to log (in bytes). Set to null for unlimited.
  @override
  @JsonKey()
  final int? maxBodySize;
// 1MB default
  /// Auto-clear logs on app restart
  @override
  @JsonKey()
  final bool autoClearOnRestart;

  /// Create a copy of DroidoConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$DroidoConfigCopyWith<_DroidoConfig> get copyWith =>
      __$DroidoConfigCopyWithImpl<_DroidoConfig>(this, _$identity);

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _DroidoConfig &&
            (identical(other.maxLogs, maxLogs) || other.maxLogs == maxLogs) &&
            (identical(other.enableNotification, enableNotification) ||
                other.enableNotification == enableNotification) &&
            (identical(other.notificationTitle, notificationTitle) ||
                other.notificationTitle == notificationTitle) &&
            (identical(other.notificationChannelId, notificationChannelId) ||
                other.notificationChannelId == notificationChannelId) &&
            (identical(
                    other.notificationChannelName, notificationChannelName) ||
                other.notificationChannelName == notificationChannelName) &&
            (identical(other.notificationOngoing, notificationOngoing) ||
                other.notificationOngoing == notificationOngoing) &&
            (identical(other.externalNotificationPlugin,
                    externalNotificationPlugin) ||
                other.externalNotificationPlugin ==
                    externalNotificationPlugin) &&
            (identical(other.includeRequestHeaders, includeRequestHeaders) ||
                other.includeRequestHeaders == includeRequestHeaders) &&
            (identical(other.includeResponseHeaders, includeResponseHeaders) ||
                other.includeResponseHeaders == includeResponseHeaders) &&
            (identical(other.includeRequestBody, includeRequestBody) ||
                other.includeRequestBody == includeRequestBody) &&
            (identical(other.includeResponseBody, includeResponseBody) ||
                other.includeResponseBody == includeResponseBody) &&
            (identical(other.maxBodySize, maxBodySize) ||
                other.maxBodySize == maxBodySize) &&
            (identical(other.autoClearOnRestart, autoClearOnRestart) ||
                other.autoClearOnRestart == autoClearOnRestart));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      maxLogs,
      enableNotification,
      notificationTitle,
      notificationChannelId,
      notificationChannelName,
      notificationOngoing,
      externalNotificationPlugin,
      includeRequestHeaders,
      includeResponseHeaders,
      includeRequestBody,
      includeResponseBody,
      maxBodySize,
      autoClearOnRestart);

  @override
  String toString() {
    return 'DroidoConfig(maxLogs: $maxLogs, enableNotification: $enableNotification, notificationTitle: $notificationTitle, notificationChannelId: $notificationChannelId, notificationChannelName: $notificationChannelName, notificationOngoing: $notificationOngoing, externalNotificationPlugin: $externalNotificationPlugin, includeRequestHeaders: $includeRequestHeaders, includeResponseHeaders: $includeResponseHeaders, includeRequestBody: $includeRequestBody, includeResponseBody: $includeResponseBody, maxBodySize: $maxBodySize, autoClearOnRestart: $autoClearOnRestart)';
  }
}

/// @nodoc
abstract mixin class _$DroidoConfigCopyWith<$Res>
    implements $DroidoConfigCopyWith<$Res> {
  factory _$DroidoConfigCopyWith(
          _DroidoConfig value, $Res Function(_DroidoConfig) _then) =
      __$DroidoConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {int maxLogs,
      bool enableNotification,
      String notificationTitle,
      String notificationChannelId,
      String notificationChannelName,
      bool notificationOngoing,
      FlutterLocalNotificationsPlugin? externalNotificationPlugin,
      bool includeRequestHeaders,
      bool includeResponseHeaders,
      bool includeRequestBody,
      bool includeResponseBody,
      int? maxBodySize,
      bool autoClearOnRestart});
}

/// @nodoc
class __$DroidoConfigCopyWithImpl<$Res>
    implements _$DroidoConfigCopyWith<$Res> {
  __$DroidoConfigCopyWithImpl(this._self, this._then);

  final _DroidoConfig _self;
  final $Res Function(_DroidoConfig) _then;

  /// Create a copy of DroidoConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? maxLogs = null,
    Object? enableNotification = null,
    Object? notificationTitle = null,
    Object? notificationChannelId = null,
    Object? notificationChannelName = null,
    Object? notificationOngoing = null,
    Object? externalNotificationPlugin = freezed,
    Object? includeRequestHeaders = null,
    Object? includeResponseHeaders = null,
    Object? includeRequestBody = null,
    Object? includeResponseBody = null,
    Object? maxBodySize = freezed,
    Object? autoClearOnRestart = null,
  }) {
    return _then(_DroidoConfig(
      maxLogs: null == maxLogs
          ? _self.maxLogs
          : maxLogs // ignore: cast_nullable_to_non_nullable
              as int,
      enableNotification: null == enableNotification
          ? _self.enableNotification
          : enableNotification // ignore: cast_nullable_to_non_nullable
              as bool,
      notificationTitle: null == notificationTitle
          ? _self.notificationTitle
          : notificationTitle // ignore: cast_nullable_to_non_nullable
              as String,
      notificationChannelId: null == notificationChannelId
          ? _self.notificationChannelId
          : notificationChannelId // ignore: cast_nullable_to_non_nullable
              as String,
      notificationChannelName: null == notificationChannelName
          ? _self.notificationChannelName
          : notificationChannelName // ignore: cast_nullable_to_non_nullable
              as String,
      notificationOngoing: null == notificationOngoing
          ? _self.notificationOngoing
          : notificationOngoing // ignore: cast_nullable_to_non_nullable
              as bool,
      externalNotificationPlugin: freezed == externalNotificationPlugin
          ? _self.externalNotificationPlugin
          : externalNotificationPlugin // ignore: cast_nullable_to_non_nullable
              as FlutterLocalNotificationsPlugin?,
      includeRequestHeaders: null == includeRequestHeaders
          ? _self.includeRequestHeaders
          : includeRequestHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      includeResponseHeaders: null == includeResponseHeaders
          ? _self.includeResponseHeaders
          : includeResponseHeaders // ignore: cast_nullable_to_non_nullable
              as bool,
      includeRequestBody: null == includeRequestBody
          ? _self.includeRequestBody
          : includeRequestBody // ignore: cast_nullable_to_non_nullable
              as bool,
      includeResponseBody: null == includeResponseBody
          ? _self.includeResponseBody
          : includeResponseBody // ignore: cast_nullable_to_non_nullable
              as bool,
      maxBodySize: freezed == maxBodySize
          ? _self.maxBodySize
          : maxBodySize // ignore: cast_nullable_to_non_nullable
              as int?,
      autoClearOnRestart: null == autoClearOnRestart
          ? _self.autoClearOnRestart
          : autoClearOnRestart // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

// dart format on
