import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/core/repositories/log_repository.dart';

/// Use case for retrieving network logs
///
/// Provides reactive access to logs via stream.
class GetLogs {
  GetLogs(this._repository);

  final LogRepository _repository;

  /// Get logs stream
  Stream<List<NetworkLog>> call() {
    return _repository.logsStream;
  }

  /// Get logs synchronously
  List<NetworkLog> getSync() {
    return _repository.getLogs();
  }
}
