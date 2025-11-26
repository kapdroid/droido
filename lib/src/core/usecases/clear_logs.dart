import 'package:droido/src/core/repositories/log_repository.dart';

/// Use case for clearing all network logs
class ClearLogs {
  ClearLogs(this._repository);

  final LogRepository _repository;

  /// Execute the use case
  Future<void> call() async {
    await _repository.clearLogs();
  }
}
