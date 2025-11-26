import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_log.freezed.dart';

/// Domain entity representing a network request/response log
///
/// This is the core business object used throughout the application.
/// Immutable by design for thread safety and predictable behavior.
@freezed
abstract class NetworkLog with _$NetworkLog {
  const factory NetworkLog({
    required String id,
    required String url,
    required String method,
    required DateTime timestamp,
    Map<String, dynamic>? requestHeaders,
    dynamic requestBody,
    int? statusCode,
    Map<String, dynamic>? responseHeaders,
    dynamic responseBody,
    int? durationMs,
    String? errorMessage,
    StackTrace? stackTrace,
  }) = _NetworkLog;

  const NetworkLog._();

  /// Returns true if the request was successful (2xx status code)
  bool get isSuccessful =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;

  /// Returns true if the request failed (4xx or 5xx status code)
  bool get isFailed =>
      statusCode != null && (statusCode! >= 400 || errorMessage != null);

  /// Returns true if the request is still pending
  bool get isPending => statusCode == null && errorMessage == null;

  /// Returns a human-readable status description
  String get statusDescription {
    if (isPending) return 'Pending';
    if (errorMessage != null) return 'Error';
    if (statusCode == null) return 'Unknown';
    if (isSuccessful) return 'Success';
    return 'Failed';
  }

  /// Returns the domain from the URL
  String get domain {
    try {
      final uri = Uri.parse(url);
      return uri.host;
    } catch (_) {
      return url;
    }
  }

  /// Returns the path from the URL
  String get path {
    try {
      final uri = Uri.parse(url);
      return uri.path;
    } catch (_) {
      return url;
    }
  }
}
