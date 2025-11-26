/// Repository interface for notification management
///
/// Abstracts platform-specific notification implementations.
/// Allows for testing and different notification strategies.
abstract class NotificationRepository {
  /// Initialize the notification service
  Future<void> initialize();

  /// Show or update the debug notification
  Future<void> showNotification({
    required String title,
    required String body,
    Map<String, dynamic>? payload,
  });

  /// Hide the notification
  Future<void> hideNotification();

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled();

  /// Request notification permission (iOS/Android 13+)
  Future<bool> requestPermission();

  /// Set callback for notification tap
  void setOnTapCallback(Function() callback);

  /// Dispose resources
  Future<void> dispose();
}
