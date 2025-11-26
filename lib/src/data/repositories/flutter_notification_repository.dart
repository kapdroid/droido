import 'dart:io';

import 'package:droido/src/core/repositories/notification_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Flutter implementation of NotificationRepository
///
/// Uses flutter_local_notifications plugin for cross-platform support.
/// Can accept an external plugin instance to avoid conflicts when multiple
/// notification plugins exist in the app.
class FlutterNotificationRepository implements NotificationRepository {
  FlutterNotificationRepository({
    required this.channelId,
    required this.channelName,
    this.notificationId = 999999,
    this.notificationOngoing = true,
    FlutterLocalNotificationsPlugin? externalPlugin,
  })  : _plugin = externalPlugin ?? FlutterLocalNotificationsPlugin(),
        _isExternalPlugin = externalPlugin != null;

  final String channelId;
  final String channelName;
  final int notificationId;
  final bool notificationOngoing;

  final FlutterLocalNotificationsPlugin _plugin;
  final bool _isExternalPlugin;

  bool _isInitialized = false;
  static Function()? _globalCallback;

  /// The expected payload for Droido notifications
  static const String droidoPayload = '{"type":"droido"}';

  @pragma('vm:entry-point')
  static void handleGlobalTap() {
    if (kDebugMode) {
      print(
          '🎯 Droido: handleGlobalTap called, callback is ${_globalCallback != null ? "SET" : "NULL"}');
    }
    _globalCallback?.call();
  }

  /// Check if payload matches Droido's payload (static)
  ///
  /// Returns true if the payload is for Droido.
  static bool isDroidoPayload(String? payload) {
    return payload == droidoPayload;
  }

  /// Handle payload and trigger callback if it matches (static)
  ///
  /// Returns true if the payload was handled, false otherwise.
  /// Can be used without initializing the repository.
  @pragma('vm:entry-point')
  static bool handlePayloadStatic(String? payload) {
    if (payload == null) return false;

    if (isDroidoPayload(payload)) {
      if (kDebugMode) {
        print('🎯 Droido: Payload matched, calling handleGlobalTap');
      }
      handleGlobalTap();
      return true;
    }

    if (kDebugMode) {
      print(
          '⚠️ Droido: Payload did not match. Expected $droidoPayload, got: $payload');
    }
    return false;
  }

  @override
  Future<void> initialize() async {
    if (!kDebugMode) {
      if (kDebugMode) {
        print('⚠️ Droido: Not in debug mode, skipping initialization');
      }
      return;
    }

    if (_isInitialized) {
      if (kDebugMode) print('⚠️ Droido: Already initialized');
      return;
    }

    if (kDebugMode) {
      print('🚀 Droido: Starting notification plugin initialization...');
      if (_isExternalPlugin) {
        print(
            'ℹ️ Droido: Using external plugin instance (skipping plugin.initialize)');
      }
    }

    try {
      // Only initialize plugin if we own it (not external)
      if (!_isExternalPlugin) {
        // Initialize notification plugin with tap handler
        const initializationSettingsAndroid =
            AndroidInitializationSettings('@mipmap/ic_launcher');
        const initializationSettingsIOS = DarwinInitializationSettings(
          requestAlertPermission: false,
          requestBadgePermission: false,
          requestSoundPermission: false,
        );
        const initializationSettings = InitializationSettings(
          android: initializationSettingsAndroid,
          iOS: initializationSettingsIOS,
        );

        final initResult = await _plugin.initialize(
          initializationSettings,
          onDidReceiveNotificationResponse: _onNotificationTap,
        );

        if (kDebugMode) {
          print('✅ Droido: Plugin initialized with result: $initResult');
        }

        if (kDebugMode) {
          print('🔔 Droido: Notification plugin initialized');
        }
      }

      if (Platform.isAndroid) {
        final androidChannel = AndroidNotificationChannel(
          channelId,
          channelName,
          description: 'Tap to open debug panel',
          importance: Importance.high, // Changed to HIGH to match notification
          playSound: false,
          showBadge: false,
        );

        await _plugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(androidChannel);

        if (kDebugMode) {
          print(
              '✅ Droido: Android notification channel created with HIGH importance');
        }
      }

      _isInitialized = true;

      if (kDebugMode) {
        print('✅ Droido: Notification repository fully initialized');
      }
    } catch (e) {
      _isInitialized = false;
    }
  }

  void _onNotificationTap(NotificationResponse response) {
    if (kDebugMode) {
      print('🔔 Droido: Notification tapped! Payload: ${response.payload}');
      print(
          '🔔 Droido: Response details - id: ${response.id}, actionId: ${response.actionId}, input: ${response.input}');
    }

    // Use static method for consistency
    handlePayloadStatic(response.payload);
  }

  @override
  Future<void> showNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  }) async {
    if (!kDebugMode) return;

    if (!_isInitialized) {
      await initialize();
    }

    try {
      final androidDetails = AndroidNotificationDetails(
        channelId,
        channelName,
        channelDescription: 'Tap to open debug panel',
        importance: Importance.high,
        priority: Priority.high,
        ongoing: notificationOngoing,
        autoCancel: !notificationOngoing,
        showWhen: false,
        enableVibration: false,
        playSound: false,
        icon: '@mipmap/ic_launcher',
        largeIcon: const DrawableResourceAndroidBitmap('@mipmap/ic_launcher'),
        category: AndroidNotificationCategory.status,
        visibility: NotificationVisibility.public,
        onlyAlertOnce: true,
        channelShowBadge: false,
      );

      const iosDetails = DarwinNotificationDetails(
        presentAlert: false,
        presentBadge: false,
        presentSound: false,
      );

      final notificationDetails = NotificationDetails(
        android: androidDetails,
        iOS: iosDetails,
      );

      await _plugin.show(
        notificationId,
        title,
        body,
        notificationDetails,
        payload: droidoPayload,
      );

      if (kDebugMode) {
        print('🔔 Droido notification shown with payload: $droidoPayload');
      }
    } catch (e) {
      if (kDebugMode) {
        print('❌ Droido notification error: $e');
      }
    }
  }

  @override
  Future<void> hideNotification() async {
    if (!kDebugMode) return;
    try {
      await _plugin.cancel(notificationId);
    } catch (e) {
      // Silently fail
    }
  }

  @override
  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      final androidImpl = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();
      return await androidImpl?.areNotificationsEnabled() ?? false;
    } else if (Platform.isIOS) {
      final iosImpl = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      final settings = await iosImpl?.requestPermissions();
      return settings ?? false;
    }
    return false;
  }

  @override
  Future<bool> requestPermission() async {
    if (!kDebugMode) return true;

    if (Platform.isAndroid) {
      final androidImpl = _plugin.resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>();

      if (androidImpl == null) return false;

      // Check if notifications are already enabled
      final areEnabled = await androidImpl.areNotificationsEnabled() ?? false;

      if (areEnabled) {
        if (kDebugMode) {
          print('✅ Droido: Notifications already enabled');
        }
        return true;
      }

      // Request permission for Android 13+ (API 33+)
      if (kDebugMode) {
        print('🔔 Droido: Requesting notification permission...');
      }

      final granted =
          await androidImpl.requestNotificationsPermission() ?? false;

      if (kDebugMode) {
        if (granted) {
          print('✅ Droido: Notification permission granted');
        } else {
          print('⚠️ Droido: Notification permission denied');
        }
      }

      return granted;
    } else if (Platform.isIOS) {
      final iosImpl = _plugin.resolvePlatformSpecificImplementation<
          IOSFlutterLocalNotificationsPlugin>();
      return await iosImpl?.requestPermissions(
            alert: true,
            badge: true,
            sound: false,
          ) ??
          false;
    }
    return true;
  }

  @override
  void setOnTapCallback(Function() callback) {
    if (kDebugMode) {
      print('🎯 Droido: Callback being registered');
      print(
          '🎯 Droido: Previous callback was: ${_globalCallback != null ? "SET" : "NULL"}');
    }
    _globalCallback = callback;
    if (kDebugMode) {
      print('✅ Droido: Callback registered successfully');
      print('🧪 Droido: Testing callback immediately...');
      try {
        callback();
        print('✅ Droido: Callback test successful');
      } catch (e) {
        print('❌ Droido: Callback test failed: $e');
      }
    }
  }

  /// Check if payload is for Droido and trigger callback if it matches
  ///
  /// Returns true if the payload was handled, false otherwise.
  /// Delegates to static method for consistency.
  ///
  /// Example:
  /// ```dart
  /// void onNotificationTap(NotificationResponse response) {
  ///   if (droidoRepo.handlePayload(response.payload)) {
  ///     return; // Droido handled it
  ///   }
  ///   // Handle other notifications
  /// }
  /// ```
  bool handlePayload(String? payload) {
    return handlePayloadStatic(payload);
  }

  /// Get the notification response handler for external plugin integration
  ///
  /// Use this when providing your own FlutterLocalNotificationsPlugin instance.
  /// Register this handler with your plugin to route Droido notifications properly.
  ///
  /// Example:
  /// ```dart
  /// final plugin = FlutterLocalNotificationsPlugin();
  /// final droidoRepo = FlutterNotificationRepository(
  ///   channelId: 'debug',
  ///   channelName: 'Debug',
  ///   externalPlugin: plugin,
  /// );
  ///
  /// // In your app's notification handler:
  /// void onNotificationTap(NotificationResponse response) {
  ///   if (response.payload?.contains('droido') ?? false) {
  ///     droidoRepo.handleNotificationResponse(response);
  ///   } else {
  ///     // Handle other notifications
  ///   }
  /// }
  /// ```
  void handleNotificationResponse(NotificationResponse response) {
    _onNotificationTap(response);
  }

  @override
  Future<void> dispose() async {
    await hideNotification();
    _isInitialized = false;
  }
}
