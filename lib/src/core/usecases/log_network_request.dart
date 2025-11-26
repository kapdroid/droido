import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/core/repositories/log_repository.dart';

/// Use case for logging a network request
///
/// Encapsulates the business logic for adding a new network log.
/// Follows Single Responsibility and Use Case patterns.
class LogNetworkRequest {
  LogNetworkRequest(this._repository);

  final LogRepository _repository;

  /// Execute the use case
  Future<void> call(NetworkLog log) async {
    await _repository.addLog(log);
  }
}
