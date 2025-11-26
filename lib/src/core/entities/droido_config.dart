import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'droido_config.freezed.dart';

/// Configuration for Droido initialization
///
/// Use the builder pattern for easy configuration:
/// ```dart
/// final config = DroidoConfig(
///   maxLogs: 1000,
///   enableNotification: true,
/// );
/// ```
@freezed
abstract class DroidoConfig with _$DroidoConfig {
  const factory DroidoConfig({
    /// Maximum number of logs to keep in memory
    @Default(500) int maxLogs,

    /// Enable persistent notification
    @Default(true) bool enableNotification,

    /// Notification title
    @Default('Debug Active') String notificationTitle,

    /// Notification channel ID (Android)
    @Default('droido_debug_channel') String notificationChannelId,

    /// Notification channel name (Android)
    @Default('Droido Debug') String notificationChannelName,

    /// External FlutterLocalNotificationsPlugin instance
    ///
    /// Provide this if your app already has a notification plugin instance
    /// to avoid conflicts. When provided, Droido will use this instance instead
    /// of creating its own. You'll need to route notification taps to Droido manually.
    FlutterLocalNotificationsPlugin? externalNotificationPlugin,

    /// Include request headers in logs
    @Default(true) bool includeRequestHeaders,

    /// Include response headers in logs
    @Default(true) bool includeResponseHeaders,

    /// Include request body in logs
    @Default(true) bool includeRequestBody,

    /// Include response body in logs
    @Default(true) bool includeResponseBody,

    /// Maximum body size to log (in bytes). Set to null for unlimited.
    @Default(1048576) int? maxBodySize, // 1MB default
    /// Auto-clear logs on app restart
    @Default(false) bool autoClearOnRestart,
  }) = _DroidoConfig;

  const DroidoConfig._();
}
