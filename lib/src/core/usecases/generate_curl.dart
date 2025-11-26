import 'dart:convert';
import 'package:droido/src/core/entities/network_log.dart';

/// Use case for generating cURL command from a network log
///
/// Useful for reproducing requests in terminal or other tools.
class GenerateCurl {
  /// Generate cURL command from a network log
  String call(NetworkLog log) {
    final buffer = StringBuffer('curl');

    // Method
    if (log.method != 'GET') {
      buffer.write(' -X ${log.method}');
    }

    // URL
    buffer.write(" '${log.url}'");

    // Headers
    if (log.requestHeaders != null) {
      for (final entry in log.requestHeaders!.entries) {
        final value = entry.value.toString().replaceAll("'", "\\'");
        buffer.write(" \\\n  -H '${entry.key}: $value'");
      }
    }

    // Body
    if (log.requestBody != null) {
      String bodyString;
      if (log.requestBody is String) {
        bodyString = log.requestBody as String;
      } else {
        bodyString = jsonEncode(log.requestBody);
      }

      final escapedBody = bodyString.replaceAll("'", "\\'");
      buffer.write(" \\\n  -d '$escapedBody'");
    }

    return buffer.toString();
  }
}
