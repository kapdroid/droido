import 'package:dio/dio.dart';
import 'package:droido/src/core/entities/network_log.dart';
import 'package:droido/src/core/usecases/log_network_request.dart';
import 'package:droido/src/core/usecases/update_network_log.dart';
import 'package:flutter/foundation.dart';

/// Dio interceptor for capturing network requests/responses
///
/// Automatically logs all HTTP traffic passing through Dio.
/// Only active in debug mode for zero release impact.
class DroidoInterceptor extends Interceptor {
  DroidoInterceptor({
    required this.logRequest,
    required this.updateLog,
    this.includeHeaders = true,
    this.includeBody = true,
    this.maxBodySize,
  });

  final LogNetworkRequest logRequest;
  final UpdateNetworkLog updateLog;
  final bool includeHeaders;
  final bool includeBody;
  final int? maxBodySize;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (!kDebugMode) {
      super.onRequest(options, handler);
      return;
    }

    final id = _generateId();
    final timestamp = DateTime.now();

    final log = NetworkLog(
      id: id,
      url: options.uri.toString(),
      method: options.method,
      timestamp: timestamp,
      requestHeaders:
          includeHeaders ? Map<String, dynamic>.from(options.headers) : null,
      requestBody: includeBody ? _sanitizeBody(options.data) : null,
    );

    // Store ID in extra for correlation
    options.extra['_droido_id'] = id;
    options.extra['_droido_start'] = timestamp.millisecondsSinceEpoch;

    logRequest(log);

    super.onRequest(options, handler);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    if (!kDebugMode) {
      super.onResponse(response, handler);
      return;
    }

    final id = response.requestOptions.extra['_droido_id'] as String?;
    final startTime = response.requestOptions.extra['_droido_start'] as int?;

    if (id != null) {
      final duration = startTime != null
          ? DateTime.now().millisecondsSinceEpoch - startTime
          : null;

      final log = NetworkLog(
        id: id,
        url: response.requestOptions.uri.toString(),
        method: response.requestOptions.method,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          startTime ?? DateTime.now().millisecondsSinceEpoch,
        ),
        requestHeaders: includeHeaders
            ? Map<String, dynamic>.from(response.requestOptions.headers)
            : null,
        requestBody:
            includeBody ? _sanitizeBody(response.requestOptions.data) : null,
        statusCode: response.statusCode,
        responseHeaders: includeHeaders
            ? Map<String, dynamic>.from(response.headers.map)
            : null,
        responseBody: includeBody ? _sanitizeBody(response.data) : null,
        durationMs: duration,
      );

      updateLog(log);
    }

    super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (!kDebugMode) {
      super.onError(err, handler);
      return;
    }

    final id = err.requestOptions.extra['_droido_id'] as String?;
    final startTime = err.requestOptions.extra['_droido_start'] as int?;

    if (id != null) {
      final duration = startTime != null
          ? DateTime.now().millisecondsSinceEpoch - startTime
          : null;

      final log = NetworkLog(
        id: id,
        url: err.requestOptions.uri.toString(),
        method: err.requestOptions.method,
        timestamp: DateTime.fromMillisecondsSinceEpoch(
          startTime ?? DateTime.now().millisecondsSinceEpoch,
        ),
        requestHeaders: includeHeaders
            ? Map<String, dynamic>.from(err.requestOptions.headers)
            : null,
        requestBody:
            includeBody ? _sanitizeBody(err.requestOptions.data) : null,
        statusCode: err.response?.statusCode,
        responseHeaders: includeHeaders && err.response != null
            ? Map<String, dynamic>.from(err.response!.headers.map)
            : null,
        responseBody: includeBody && err.response != null
            ? _sanitizeBody(err.response!.data)
            : null,
        durationMs: duration,
        errorMessage: err.message,
        stackTrace: err.stackTrace,
      );

      updateLog(log);
    }

    super.onError(err, handler);
  }

  String _generateId() {
    final now = DateTime.now();
    return '${now.millisecondsSinceEpoch}_${now.microsecond}';
  }

  dynamic _sanitizeBody(dynamic body) {
    if (body == null) return null;

    // Check size limit
    if (maxBodySize != null) {
      final bodyString = body.toString();
      if (bodyString.length > maxBodySize!) {
        return '[Body too large: ${bodyString.length} bytes]';
      }
    }

    return body;
  }
}
