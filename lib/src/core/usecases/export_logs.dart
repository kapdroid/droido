import 'dart:convert';
import 'package:droido/src/core/repositories/log_repository.dart';

/// Use case for exporting network logs
///
/// Supports multiple export formats:
/// - JSON
/// - HAR (HTTP Archive format)
/// - CSV
class ExportLogs {
  ExportLogs(this._repository);

  final LogRepository _repository;

  /// Export as JSON string
  String exportAsJson() {
    final logs = _repository.getLogs();
    final jsonList = logs
        .map(
          (log) => {
            'id': log.id,
            'url': log.url,
            'method': log.method,
            'timestamp': log.timestamp.toIso8601String(),
            'statusCode': log.statusCode,
            'durationMs': log.durationMs,
            'errorMessage': log.errorMessage,
          },
        )
        .toList();
    return const JsonEncoder.withIndent('  ').convert(jsonList);
  }

  /// Export as HAR format (HTTP Archive)
  /// Compatible with Chrome DevTools, Postman, etc.
  String exportAsHar() {
    final logs = _repository.getLogs();

    final entries = logs.map((log) {
      return {
        'startedDateTime': log.timestamp.toIso8601String(),
        'time': log.durationMs ?? 0,
        'request': {
          'method': log.method,
          'url': log.url,
          'httpVersion': 'HTTP/1.1',
          'headers': _convertHeaders(log.requestHeaders),
          'queryString': [],
          'postData': log.requestBody != null
              ? {
                  'mimeType': 'application/json',
                  'text': jsonEncode(log.requestBody),
                }
              : null,
        },
        'response': {
          'status': log.statusCode ?? 0,
          'statusText': log.statusDescription,
          'httpVersion': 'HTTP/1.1',
          'headers': _convertHeaders(log.responseHeaders),
          'content': {
            'size': 0,
            'mimeType': 'application/json',
            'text':
                log.responseBody != null ? jsonEncode(log.responseBody) : '',
          },
        },
        'cache': {},
        'timings': {'send': 0, 'wait': log.durationMs ?? 0, 'receive': 0},
      };
    }).toList();

    final har = {
      'log': {
        'version': '1.2',
        'creator': {'name': 'Droido', 'version': '1.0.0'},
        'entries': entries,
      },
    };

    return const JsonEncoder.withIndent('  ').convert(har);
  }

  /// Export as CSV string
  String exportAsCsv() {
    final logs = _repository.getLogs();
    final buffer = StringBuffer();

    // Header
    buffer.writeln('Timestamp,Method,URL,Status Code,Duration (ms),Error');

    // Data rows
    for (final log in logs) {
      buffer.writeln(
        '${log.timestamp.toIso8601String()},'
        '${log.method},'
        '"${_escapeCsv(log.url)}",'
        '${log.statusCode ?? ""},'
        '${log.durationMs ?? ""},'
        '"${_escapeCsv(log.errorMessage ?? "")}"',
      );
    }

    return buffer.toString();
  }

  List<Map<String, String>> _convertHeaders(Map<String, dynamic>? headers) {
    if (headers == null) return [];
    return headers.entries
        .map((e) => {'name': e.key, 'value': e.value.toString()})
        .toList();
  }

  String _escapeCsv(String value) {
    return value.replaceAll('"', '""');
  }
}
