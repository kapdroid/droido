import 'package:droido/droido.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Modern, clean network request card with professional UX/UI
///
/// Design principles:
/// - White theme with subtle shadows
/// - Clear visual hierarchy
/// - Data-first approach
/// - Easy to scan for developers
class NetworkCard extends StatelessWidget {
  const NetworkCard({
    required this.log,
    required this.onTap,
    super.key,
  });

  final NetworkLog log;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(
          color: _borderColor,
          width: 1,
        ),
      ),
      color: _surfaceColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),
            _buildMetrics(),
          ],
        ),
      ),
    );
  }

  /// Header with method, URL, and status code
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Method badge
          _buildMethodBadge(),
          const SizedBox(width: 12),

          // URL
          Expanded(
            child: Text(
              _formatUrl(log.url),
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Color(0xFF374151),
                height: 1.4,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          const SizedBox(width: 12),

          // Status code badge
          if (log.statusCode != null) _buildStatusBadge(),
        ],
      ),
    );
  }

  /// Metrics section with request time, response size, and duration
  Widget _buildMetrics() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          // Request Time
          Expanded(
            child: _buildMetricItem(
              icon: Icons.schedule_outlined,
              label: 'REQUEST TIME',
              value: _formatTime(log.timestamp),
              iconColor: const Color(0xFF6B7280),
            ),
          ),

          // Response Size
          Expanded(
            child: _buildMetricItem(
              icon: Icons.data_usage_outlined,
              label: 'RESPONSE SIZE',
              value: _formatSize(log.responseBody),
              iconColor: const Color(0xFF6B7280),
            ),
          ),

          // Duration
          Expanded(
            child: _buildMetricItem(
              icon: Icons.bolt_outlined,
              label: 'DURATION',
              value: _formatDuration(log.durationMs),
              iconColor: _durationColor,
              valueColor: _durationColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Individual metric item
  Widget _buildMetricItem({
    required IconData icon,
    required String label,
    required String value,
    required Color iconColor,
    Color? valueColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 12, color: iconColor),
            const SizedBox(width: 4),
            Text(
              label,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.5,
                color: Color(0xFF9CA3AF),
                height: 1.2,
              ),
            ),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: valueColor ?? const Color(0xFF111827),
            height: 1.4,
          ),
        ),
      ],
    );
  }

  /// Method badge (GET, POST, etc.)
  Widget _buildMethodBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: _methodColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: _methodColor.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        log.method,
        style: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.3,
          color: _methodColor,
          height: 1.2,
        ),
      ),
    );
  }

  /// Status code badge
  Widget _buildStatusBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: _statusColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        log.statusCode.toString(),
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
          color: Colors.white,
          height: 1.2,
        ),
      ),
    );
  }

  // Color getters based on status
  Color get _statusColor {
    if (log.statusCode == null) return const Color(0xFF6B7280);
    if (log.statusCode! >= 200 && log.statusCode! < 300) {
      return const Color(0xFF10B981); // Green
    }
    if (log.statusCode! >= 300 && log.statusCode! < 400) {
      return const Color(0xFF3B82F6); // Blue
    }
    if (log.statusCode! >= 400 && log.statusCode! < 500) {
      return const Color(0xFFF59E0B); // Amber
    }
    return const Color(0xFFEF4444); // Red
  }

  Color get _surfaceColor {
    if (log.statusCode == null) return const Color(0xFFFAFAFA);
    if (log.statusCode! >= 200 && log.statusCode! < 300) {
      return const Color(0xFFFAFAFA);
    }
    if (log.statusCode! >= 400) {
      return const Color(0xFFFEF2F2); // Light red
    }
    return const Color(0xFFFAFAFA);
  }

  Color get _borderColor {
    if (log.statusCode == null) return const Color(0xFFE5E7EB);
    if (log.statusCode! >= 200 && log.statusCode! < 300) {
      return const Color(0xFFE5E7EB);
    }
    if (log.statusCode! >= 400) {
      return const Color(0xFFEF4444).withValues(alpha: 0.2);
    }
    return const Color(0xFFE5E7EB);
  }

  Color get _methodColor {
    switch (log.method.toUpperCase()) {
      case 'GET':
        return const Color(0xFF3B82F6); // Blue
      case 'POST':
        return const Color(0xFF10B981); // Green
      case 'PUT':
        return const Color(0xFFF59E0B); // Amber
      case 'PATCH':
        return const Color(0xFF8B5CF6); // Purple
      case 'DELETE':
        return const Color(0xFFEF4444); // Red
      default:
        return const Color(0xFF6B7280); // Grey
    }
  }

  Color get _durationColor {
    if (log.durationMs == null) return const Color(0xFF6B7280);
    if (log.durationMs! < 500) return const Color(0xFF10B981); // Green
    if (log.durationMs! < 2000) return const Color(0xFFF59E0B); // Amber
    return const Color(0xFFEF4444); // Red
  }

  // Formatters
  String _formatTime(DateTime timestamp) {
    return DateFormat('HH:mm:ss').format(timestamp);
  }

  String _formatSize(dynamic body) {
    if (body == null) return '0 B';

    int bytes;
    if (body is String) {
      bytes = body.length;
    } else {
      bytes = body.toString().length;
    }

    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(2)} MB';
  }

  String _formatDuration(int? ms) {
    if (ms == null) return '—';
    if (ms < 1000) return '${ms}ms';
    return '${(ms / 1000).toStringAsFixed(2)}s';
  }

  String _formatUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return '${uri.host}${uri.path}';
    } catch (_) {
      return url;
    }
  }
}
