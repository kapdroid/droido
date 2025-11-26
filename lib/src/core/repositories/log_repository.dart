import 'package:droido/src/core/entities/network_log.dart';

/// Repository interface for managing network logs
///
/// This abstraction allows for different storage implementations:
/// - In-memory (default)
/// - Persistent (Hive/Isar/SQLite)
/// - Custom implementations
///
/// Following Repository Pattern and Dependency Inversion Principle.
abstract class LogRepository {
  /// Stream of all logs, emits whenever logs change
  Stream<List<NetworkLog>> get logsStream;

  /// Get all logs synchronously
  List<NetworkLog> getLogs();

  /// Add a new log
  Future<void> addLog(NetworkLog log);

  /// Update an existing log (for completing pending requests)
  Future<void> updateLog(NetworkLog log);

  /// Delete a specific log
  Future<void> deleteLog(String id);

  /// Clear all logs
  Future<void> clearLogs();

  /// Get a specific log by ID
  NetworkLog? getLogById(String id);

  /// Search logs by query (URL, method, status code)
  List<NetworkLog> searchLogs(String query);

  /// Filter logs by criteria
  List<NetworkLog> filterLogs({
    String? method,
    int? statusCode,
    bool? isSuccessful,
    bool? isFailed,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Get log count
  int getLogCount();

  /// Dispose resources
  Future<void> dispose();
}
