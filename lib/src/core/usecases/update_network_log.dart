import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/core/repositories/log_repository.dart';

/// Use case for updating a network log with response data
///
/// Used when a request completes to update the pending log
/// with response information and duration.
class UpdateNetworkLog {
  UpdateNetworkLog(this._repository);

  final LogRepository _repository;

  /// Execute the use case
  Future<void> call(NetworkLog log) async {
    await _repository.updateLog(log);
  }
}
