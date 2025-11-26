import 'dart:async';

import 'package:dio/dio.dart';
import 'package:droido/src/core/entities/droido_config.dart';
import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/data/repositories/flutter_notification_repository.dart';
import 'package:droido/src/data/services/dio_interceptor.dart';
import 'package:droido/src/di/droido_container.dart';
import 'package:flutter/foundation.dart';

/// Main manager class for Droido
///
/// This is the facade that provides a simple API for the package.
/// All functionality is NO-OP in release mode for zero impact.
class DroidoManager {
  DroidoManager._();

  static DroidoManager? _instance;
  static DroidoManager get instance => _instance ??= DroidoManager._();

  bool _isInitialized = false;
  DroidoConfig? _config;
  Timer? _notificationTimer;
  DroidoInterceptor? _interceptor;

  /// Initialize Droido with Dio instance
  Future<void> init({required Dio dio, DroidoConfig? config}) async {
    if (!kDebugMode) return;
    if (_isInitialized) return;

    _config = config ?? const DroidoConfig();

    // Initialize container
    DroidoContainer.instance.initialize(_config!);

    // Initialize notification
    if (_config!.enableNotification) {
      await DroidoContainer.instance.notificationRepository.initialize();
      await DroidoContainer.instance.notificationRepository.requestPermission();

      // Start periodic notification updates
      _startNotificationUpdates();
    }

    // Add Dio interceptor
    _interceptor = DroidoInterceptor(
      logRequest: DroidoContainer.instance.logNetworkRequest,
      updateLog: DroidoContainer.instance.updateNetworkLog,
      includeHeaders: _config!.includeRequestHeaders,
      includeBody: _config!.includeRequestBody,
      maxBodySize: _config!.maxBodySize,
    );
    dio.interceptors.add(_interceptor!);

    // Clear logs if configured
    if (_config!.autoClearOnRestart) {
      await DroidoContainer.instance.clearLogs();
    }

    _isInitialized = true;
  }

  /// Set callback for notification tap
  void setNotificationCallback(VoidCallback callback) {
    if (!kDebugMode) return;
    DroidoContainer.instance.notificationRepository.setOnTapCallback(callback);
  }

  /// Handle notification response (for external plugin integration)
  ///
  /// Call this from your app's notification response handler when using
  /// an external FlutterLocalNotificationsPlugin instance.
  void handleNotificationResponse(dynamic response) {
    if (!kDebugMode) return;
    final repo = DroidoContainer.instance.notificationRepository;
    if (repo is FlutterNotificationRepository) {
      repo.handleNotificationResponse(response);
    }
  }

  /// Check if payload is for Droido and handle it
  ///
  /// Returns true if the payload was handled, false otherwise.
  /// Use this for simpler integration with external notification plugins.
  /// This is a static method that doesn't require initialization.
  ///
  /// Example:
  /// ```dart
  /// void onNotificationTap(NotificationResponse response) {
  ///   if (Droido.handlePayload(response.payload)) {
  ///     return; // Droido handled it
  ///   }
  ///   // Handle other notifications
  /// }
  /// ```
  bool handlePayload(String? payload) {
    if (!kDebugMode) return false;
    return FlutterNotificationRepository.handlePayloadStatic(payload);
  }

  /// Get logs stream
  Stream<List<NetworkLog>> get logsStream {
    if (!kDebugMode) return Stream.value([]);
    return DroidoContainer.instance.getLogs();
  }

  /// Get logs synchronously
  List<NetworkLog> get logs {
    if (!kDebugMode) return [];
    return DroidoContainer.instance.getLogs.getSync();
  }

  /// Search logs
  List<NetworkLog> searchLogs(String query) {
    if (!kDebugMode) return [];
    return DroidoContainer.instance.searchLogs(query);
  }

  /// Clear all logs
  Future<void> clearLogs() async {
    if (!kDebugMode) return;
    await DroidoContainer.instance.clearLogs();
  }

  /// Export logs as JSON
  String exportAsJson() {
    if (!kDebugMode) return '[]';
    return DroidoContainer.instance.exportLogs.exportAsJson();
  }

  /// Export logs as HAR
  String exportAsHar() {
    if (!kDebugMode) return '{}';
    return DroidoContainer.instance.exportLogs.exportAsHar();
  }

  /// Export logs as CSV
  String exportAsCsv() {
    if (!kDebugMode) return '';
    return DroidoContainer.instance.exportLogs.exportAsCsv();
  }

  /// Generate cURL command for a log
  String generateCurl(NetworkLog log) {
    if (!kDebugMode) return '';
    return DroidoContainer.instance.generateCurl(log);
  }

  /// Get log count
  int get logCount {
    if (!kDebugMode) return 0;
    return DroidoContainer.instance.logRepository.getLogCount();
  }

  /// Check if initialized
  bool get isInitialized => kDebugMode && _isInitialized;

  void _startNotificationUpdates() {
    _notificationTimer?.cancel();
    _notificationTimer = Timer.periodic(
      const Duration(seconds: 5),
      (_) => _updateNotification(),
    );
    _updateNotification(); // Initial update
  }

  Future<void> _updateNotification() async {
    if (!kDebugMode || !_isInitialized) return;

    final count = DroidoContainer.instance.logRepository.getLogCount();
    final body = count == 0
        ? 'Tap to open • No requests yet'
        : 'Tap to open • $count requests';

    await DroidoContainer.instance.notificationRepository.showNotification(
      title: _config!.notificationTitle,
      body: body,
    );
  }

  /// Dispose and cleanup
  Future<void> dispose() async {
    if (!kDebugMode) return;
    if (!_isInitialized) return;

    _notificationTimer?.cancel();
    _notificationTimer = null;

    await DroidoContainer.instance.notificationRepository.dispose();
    await DroidoContainer.instance.logRepository.dispose();

    DroidoContainer.instance.reset();

    _isInitialized = false;
    _config = null;
  }
}
