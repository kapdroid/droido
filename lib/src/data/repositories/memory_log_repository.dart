import 'dart:async';
import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/core/repositories/log_repository.dart';
import 'package:rxdart/rxdart.dart';

/// In-memory implementation of LogRepository
///
/// Stores logs in memory with a circular buffer pattern.
/// Automatically evicts oldest logs when max capacity is reached.
class MemoryLogRepository implements LogRepository {
  MemoryLogRepository({this.maxLogs = 500});

  final int maxLogs;
  final List<NetworkLog> _logs = [];
  final _logsController = BehaviorSubject<List<NetworkLog>>.seeded(const []);

  @override
  Stream<List<NetworkLog>> get logsStream => _logsController.stream;

  @override
  List<NetworkLog> getLogs() {
    return List.unmodifiable(_logs);
  }

  @override
  Future<void> addLog(NetworkLog log) async {
    _logs.add(log);

    // Circular buffer: remove oldest if exceeding max
    if (_logs.length > maxLogs) {
      _logs.removeAt(0);
    }

    _logsController.add(List.unmodifiable(_logs));
  }

  @override
  Future<void> updateLog(NetworkLog log) async {
    final index = _logs.indexWhere((l) => l.id == log.id);
    if (index != -1) {
      _logs[index] = log;
      _logsController.add(List.unmodifiable(_logs));
    }
  }

  @override
  Future<void> deleteLog(String id) async {
    _logs.removeWhere((log) => log.id == id);
    _logsController.add(List.unmodifiable(_logs));
  }

  @override
  Future<void> clearLogs() async {
    _logs.clear();
    _logsController.add(const []);
  }

  @override
  NetworkLog? getLogById(String id) {
    try {
      return _logs.firstWhere((log) => log.id == id);
    } catch (_) {
      return null;
    }
  }

  @override
  List<NetworkLog> searchLogs(String query) {
    final lowerQuery = query.toLowerCase();
    return _logs.where((log) {
      return log.url.toLowerCase().contains(lowerQuery) ||
          log.method.toLowerCase().contains(lowerQuery) ||
          (log.statusCode?.toString().contains(query) ?? false) ||
          (log.errorMessage?.toLowerCase().contains(lowerQuery) ?? false);
    }).toList();
  }

  @override
  List<NetworkLog> filterLogs({
    String? method,
    int? statusCode,
    bool? isSuccessful,
    bool? isFailed,
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _logs.where((log) {
      if (method != null && log.method != method) return false;
      if (statusCode != null && log.statusCode != statusCode) return false;
      if (isSuccessful != null && log.isSuccessful != isSuccessful) {
        return false;
      }
      if (isFailed != null && log.isFailed != isFailed) return false;
      if (startDate != null && log.timestamp.isBefore(startDate)) {
        return false;
      }
      if (endDate != null && log.timestamp.isAfter(endDate)) return false;
      return true;
    }).toList();
  }

  @override
  int getLogCount() => _logs.length;

  @override
  Future<void> dispose() async {
    await _logsController.close();
    _logs.clear();
  }
}
