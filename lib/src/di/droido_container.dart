import 'package:droido/src/core/entities/droido_config.dart';
import 'package:droido/src/core/repositories/log_repository.dart';
import 'package:droido/src/core/repositories/notification_repository.dart';
import 'package:droido/src/core/usecases/clear_logs.dart';
import 'package:droido/src/core/usecases/export_logs.dart';
import 'package:droido/src/core/usecases/generate_curl.dart';
import 'package:droido/src/core/usecases/get_logs.dart';
import 'package:droido/src/core/usecases/log_network_request.dart';
import 'package:droido/src/core/usecases/search_logs.dart';
import 'package:droido/src/core/usecases/update_network_log.dart';
import 'package:droido/src/data/repositories/flutter_notification_repository.dart';
import 'package:droido/src/data/repositories/memory_log_repository.dart';

/// Dependency injection container for Droido
///
/// Simple, lightweight container without external dependencies.
/// Uses factory pattern for flexibility and testability.
class DroidoContainer {
  DroidoContainer._();

  static DroidoContainer? _instance;
  static DroidoContainer get instance => _instance ??= DroidoContainer._();

  LogRepository? _logRepository;
  NotificationRepository? _notificationRepository;

  // Use cases
  LogNetworkRequest? _logNetworkRequest;
  UpdateNetworkLog? _updateNetworkLog;
  GetLogs? _getLogs;
  SearchLogs? _searchLogs;
  ClearLogs? _clearLogs;
  ExportLogs? _exportLogs;
  GenerateCurl? _generateCurl;

  /// Initialize with config
  void initialize(DroidoConfig config) {
    // Repositories
    _logRepository = MemoryLogRepository(maxLogs: config.maxLogs);
    _notificationRepository = FlutterNotificationRepository(
      channelId: config.notificationChannelId,
      channelName: config.notificationChannelName,
      notificationOngoing: config.notificationOngoing,
      externalPlugin: config.externalNotificationPlugin,
    );

    // Use cases
    _logNetworkRequest = LogNetworkRequest(_logRepository!);
    _updateNetworkLog = UpdateNetworkLog(_logRepository!);
    _getLogs = GetLogs(_logRepository!);
    _searchLogs = SearchLogs(_logRepository!);
    _clearLogs = ClearLogs(_logRepository!);
    _exportLogs = ExportLogs(_logRepository!);
    _generateCurl = GenerateCurl();
  }

  // Getters
  LogRepository get logRepository {
    _assertInitialized();
    return _logRepository!;
  }

  NotificationRepository get notificationRepository {
    _assertInitialized();
    return _notificationRepository!;
  }

  LogNetworkRequest get logNetworkRequest {
    _assertInitialized();
    return _logNetworkRequest!;
  }

  UpdateNetworkLog get updateNetworkLog {
    _assertInitialized();
    return _updateNetworkLog!;
  }

  GetLogs get getLogs {
    _assertInitialized();
    return _getLogs!;
  }

  SearchLogs get searchLogs {
    _assertInitialized();
    return _searchLogs!;
  }

  ClearLogs get clearLogs {
    _assertInitialized();
    return _clearLogs!;
  }

  ExportLogs get exportLogs {
    _assertInitialized();
    return _exportLogs!;
  }

  GenerateCurl get generateCurl {
    _assertInitialized();
    return _generateCurl!;
  }

  void _assertInitialized() {
    if (_logRepository == null) {
      throw StateError(
        'DroidoContainer not initialized. Call Droido.init() first.',
      );
    }
  }

  /// Reset the container (for testing)
  void reset() {
    _logRepository?.dispose();
    _notificationRepository?.dispose();

    _logRepository = null;
    _notificationRepository = null;
    _logNetworkRequest = null;
    _updateNetworkLog = null;
    _getLogs = null;
    _searchLogs = null;
    _clearLogs = null;
    _exportLogs = null;
    _generateCurl = null;
  }
}
