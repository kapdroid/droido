import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/core/repositories/log_repository.dart';

/// Use case for searching network logs
///
/// Searches by URL, method, status code, or error message.
class SearchLogs {
  SearchLogs(this._repository);

  final LogRepository _repository;

  /// Execute the search
  List<NetworkLog> call(String query) {
    if (query.trim().isEmpty) {
      return _repository.getLogs();
    }
    return _repository.searchLogs(query);
  }
}
