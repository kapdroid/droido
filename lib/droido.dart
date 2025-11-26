/// Droido - Lightweight network debugging for Flutter
///
/// A debug-only network inspector with persistent notification UI.
/// Zero impact on release builds through tree-shaking.
///
/// ## Features
/// - Network request/response logging
/// - Persistent notification showing request count
/// - In-app debug panel with search and filtering
/// - Export logs as JSON, HAR, or CSV
/// - Generate cURL commands
/// - Fully tree-shakable (zero release footprint)
///
/// ## Quick Start
///
/// ```dart
/// import 'package:droido/droido.dart';
///
/// // Initialize in main() or app startup
/// await Droido.init(
///   dio: dioInstance,
///   config: DroidoConfig(maxLogs: 500),
/// );
///
/// // Set notification tap callback
/// Droido.setNotificationCallback(() {
///   Navigator.push(
///     context,
///     MaterialPageRoute(builder: (_) => DroidoPanel()),
///   );
/// });
/// ```
library droido;

import 'package:dio/dio.dart';
import 'package:droido/src/core/entities/droido_config.dart';
import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/droido_manager.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// Core exports
export 'package:flutter_local_notifications/flutter_local_notifications.dart'
    show NotificationResponse;

export 'src/core/entities/droido_config.dart';
export 'src/core/entities/network_log.dart';
// UI exports
export 'src/presentation/pages/droido_panel.dart';

/// Main Droido API
///
/// Facade providing simple access to all Droido functionality.
/// All methods are NO-OP in release mode.
class Droido {
  Droido._();

  /// Initialize Droido with Dio instance
  ///
  /// ```dart
  /// await Droido.init(
  ///   dio: myDioInstance,
  ///   config: DroidoConfig(
  ///     maxLogs: 1000,
  ///     enableNotification: true,
  ///   ),
  /// );
  /// ```
  static Future<void> init({required Dio dio, DroidoConfig? config}) async {
    if (!kDebugMode) return;
    await DroidoManager.instance.init(dio: dio, config: config);
  }

  /// Set callback for when notification is tapped
  ///
  /// ```dart
  /// Droido.setNotificationCallback(() {
  ///   Navigator.push(
  ///     context,
  ///     MaterialPageRoute(builder: (_) => DroidoPanel()),
  ///   );
  /// });
  /// ```
  static void setNotificationCallback(VoidCallback callback) {
    if (!kDebugMode) return;
    DroidoManager.instance.setNotificationCallback(callback);
  }

  /// Handle notification response (for external plugin integration)
  ///
  /// Use this when providing your own FlutterLocalNotificationsPlugin instance
  /// to route Droido notification taps properly.
  ///
  /// ```dart
  /// // In your app's notification handler:
  /// void onNotificationTap(NotificationResponse response) {
  ///   if (response.payload?.contains('droido') ?? false) {
  ///     Droido.handleNotificationResponse(response);
  ///   } else {
  ///     // Handle other notifications
  ///   }
  /// }
  /// ```
  static void handleNotificationResponse(NotificationResponse response) {
    if (!kDebugMode) return;
    DroidoManager.instance.handleNotificationResponse(response);
  }

  /// The expected payload for Droido notifications
  ///
  /// Use this constant when you need to check the payload yourself.
  static const String droidoPayload = '{"type":"droido"}';

  /// Check if a payload is for Droido (without handling it)
  ///
  /// Returns true if the payload matches Droido's expected payload.
  /// Useful for conditional routing in notification handlers.
  ///
  /// ```dart
  /// void onNotificationTap(NotificationResponse response) {
  ///   if (Droido.isDroidoPayload(response.payload)) {
  ///     // Route to Droido
  ///     Droido.handlePayload(response.payload);
  ///   }
  /// }
  /// ```
  static bool isDroidoPayload(String? payload) {
    return payload == droidoPayload;
  }

  /// Check if payload is for Droido and handle it
  ///
  /// Returns true if the payload was handled, false otherwise.
  /// Simpler alternative to handleNotificationResponse - just pass the payload string.
  /// This is a static method that works without initialization.
  ///
  /// ```dart
  /// // In your app's notification handler:
  /// void onNotificationTap(NotificationResponse response) {
  ///   if (Droido.handlePayload(response.payload)) {
  ///     return; // Droido handled it
  ///   }
  ///   // Handle other app notifications
  /// }
  /// ```
  static bool handlePayload(String? payload) {
    if (!kDebugMode) return false;
    return DroidoManager.instance.handlePayload(payload);
  }

  /// Get reactive stream of logs
  static Stream<List<NetworkLog>> get logsStream {
    if (!kDebugMode) return Stream.value([]);
    return DroidoManager.instance.logsStream;
  }

  /// Get current logs (synchronous)
  static List<NetworkLog> get logs {
    if (!kDebugMode) return [];
    return DroidoManager.instance.logs;
  }

  /// Search logs by query
  static List<NetworkLog> searchLogs(String query) {
    if (!kDebugMode) return [];
    return DroidoManager.instance.searchLogs(query);
  }

  /// Clear all logs
  static Future<void> clearLogs() async {
    if (!kDebugMode) return;
    await DroidoManager.instance.clearLogs();
  }

  /// Export logs as JSON
  static String exportAsJson() {
    if (!kDebugMode) return '[]';
    return DroidoManager.instance.exportAsJson();
  }

  /// Export logs as HAR format
  static String exportAsHar() {
    if (!kDebugMode) return '{}';
    return DroidoManager.instance.exportAsHar();
  }

  /// Export logs as CSV
  static String exportAsCsv() {
    if (!kDebugMode) return '';
    return DroidoManager.instance.exportAsCsv();
  }

  /// Generate cURL command for a log
  static String generateCurl(NetworkLog log) {
    if (!kDebugMode) return '';
    return DroidoManager.instance.generateCurl(log);
  }

  /// Get total log count
  static int get logCount {
    if (!kDebugMode) return 0;
    return DroidoManager.instance.logCount;
  }

  /// Check if Droido is initialized
  static bool get isInitialized {
    if (!kDebugMode) return false;
    return DroidoManager.instance.isInitialized;
  }

  /// Dispose and cleanup
  static Future<void> dispose() async {
    if (!kDebugMode) return;
    await DroidoManager.instance.dispose();
  }
}
