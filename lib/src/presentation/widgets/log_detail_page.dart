import 'dart:convert';

import 'package:droido/droido.dart';
import 'package:droido/src/presentation/theme/design_tokens.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Detail page showing full network log information
class LogDetailPage extends StatefulWidget {
  const LogDetailPage({required this.log, super.key});

  final NetworkLog log;

  @override
  State<LogDetailPage> createState() => _LogDetailPageState();
}

class _LogDetailPageState extends State<LogDetailPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final statusColor =
        DroidoDesignTokens.getStatusColor(widget.log.statusCode);

    return Scaffold(
      backgroundColor: DroidoDesignTokens.background,
      appBar: AppBar(
        backgroundColor: DroidoDesignTokens.surface,
        foregroundColor: DroidoDesignTokens.textPrimary,
        elevation: 0,
        title: Row(
          children: [
            _buildMethodBadge(),
            const SizedBox(width: DroidoDesignTokens.space2),
            Text(
              widget.log.statusCode?.toString() ?? 'Pending',
              style: DroidoDesignTokens.headingMedium.copyWith(
                color: statusColor,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.content_copy_outlined),
            onPressed: _copyCurl,
            tooltip: 'Copy cURL',
            color: DroidoDesignTokens.textSecondary,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(49),
          child: Column(
            children: [
              TabBar(
                controller: _tabController,
                labelColor: DroidoDesignTokens.textPrimary,
                unselectedLabelColor: DroidoDesignTokens.textTertiary,
                indicatorColor: statusColor,
                indicatorWeight: 3,
                labelStyle: DroidoDesignTokens.bodyMedium.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                tabs: const [
                  Tab(text: 'Overview'),
                  Tab(text: 'Request'),
                  Tab(text: 'Response'),
                ],
              ),
              Container(
                height: 1,
                color: DroidoDesignTokens.border,
              ),
            ],
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildOverviewTab(),
          _buildRequestTab(),
          _buildResponseTab(),
        ],
      ),
    );
  }

  Widget _buildOverviewTab() {
    return ListView(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      children: [
        // Metric Cards Row - Scrollable to prevent overflow
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SizedBox(
                width: 130,
                child: _buildMetricCard(
                  icon: Icons.schedule_outlined,
                  label: 'TIME',
                  value: DateFormat('HH:mm:ss').format(widget.log.timestamp),
                  iconColor: DroidoDesignTokens.textTertiary,
                ),
              ),
              const SizedBox(width: DroidoDesignTokens.space2),
              SizedBox(
                width: 110,
                child: _buildMetricCard(
                  icon: Icons.data_usage_outlined,
                  label: 'SIZE',
                  value: _formatSize(widget.log.responseBody),
                  iconColor: DroidoDesignTokens.textTertiary,
                ),
              ),
              const SizedBox(width: DroidoDesignTokens.space2),
              SizedBox(
                width: 110,
                child: _buildMetricCard(
                  icon: Icons.bolt_outlined,
                  label: 'DURATION',
                  value: _formatDuration(widget.log.durationMs),
                  valueColor: DroidoDesignTokens.getDurationColor(
                      widget.log.durationMs),
                  iconColor: DroidoDesignTokens.getDurationColor(
                      widget.log.durationMs),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: DroidoDesignTokens.space4),

        // URL Card
        _buildInfoCard('REQUEST URL', [
          _buildCopyableRow(widget.log.url),
        ]),
        const SizedBox(height: DroidoDesignTokens.space3),

        // Request Details
        _buildInfoCard('REQUEST DETAILS', [
          _buildInfoRow('Method', widget.log.method),
          if (widget.log.statusCode != null)
            _buildInfoRow('Status Code', widget.log.statusCode.toString()),
          _buildInfoRow('Status', widget.log.statusDescription),
          _buildInfoRow('Timestamp',
              DateFormat('MMM dd, yyyy HH:mm:ss').format(widget.log.timestamp)),
        ]),

        // Error Message (if any)
        if (widget.log.errorMessage != null) ...[
          const SizedBox(height: DroidoDesignTokens.space3),
          _buildErrorCard(widget.log.errorMessage!),
        ],
      ],
    );
  }

  Widget _buildRequestTab() {
    return ListView(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      children: [
        if (widget.log.requestHeaders != null &&
            widget.log.requestHeaders!.isNotEmpty) ...[
          _buildInfoCard(
            'REQUEST HEADERS',
            widget.log.requestHeaders!.entries
                .map((e) => _buildInfoRow(e.key, e.value.toString()))
                .toList(),
          ),
          const SizedBox(height: DroidoDesignTokens.space3),
        ],
        if (widget.log.requestBody != null) ...[
          _buildBodyCard('REQUEST BODY', widget.log.requestBody),
        ] else ...[
          _buildEmptyCard('No request body'),
        ],
      ],
    );
  }

  Widget _buildResponseTab() {
    return ListView(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      children: [
        if (widget.log.responseHeaders != null &&
            widget.log.responseHeaders!.isNotEmpty) ...[
          _buildInfoCard(
            'RESPONSE HEADERS',
            widget.log.responseHeaders!.entries
                .map((e) => _buildInfoRow(e.key, e.value.toString()))
                .toList(),
          ),
          const SizedBox(height: DroidoDesignTokens.space3),
        ],
        if (widget.log.responseBody != null) ...[
          _buildBodyCard('RESPONSE BODY', widget.log.responseBody),
        ] else ...[
          _buildEmptyCard('No response body'),
        ],
      ],
    );
  }

  Widget _buildMethodBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: DroidoDesignTokens.space2,
        vertical: DroidoDesignTokens.space1,
      ),
      decoration: BoxDecoration(
        color: DroidoDesignTokens.getMethodColor(widget.log.method)
            .withValues(alpha: 0.1),
        borderRadius: DroidoDesignTokens.badgeRadius,
        border: Border.all(
          color: DroidoDesignTokens.getMethodColor(widget.log.method)
              .withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Text(
        widget.log.method,
        style: DroidoDesignTokens.badgeSmall.copyWith(
          color: DroidoDesignTokens.getMethodColor(widget.log.method),
        ),
      ),
    );
  }

  Widget _buildMetricCard({
    required IconData icon,
    required String label,
    required String value,
    Color? iconColor,
    Color? valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      decoration: BoxDecoration(
        color: DroidoDesignTokens.surface,
        borderRadius: DroidoDesignTokens.cardRadius,
        border: Border.all(
          color: DroidoDesignTokens.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 12,
                color: iconColor ?? DroidoDesignTokens.textTertiary,
              ),
              const SizedBox(width: DroidoDesignTokens.space1),
              Text(
                label,
                style: DroidoDesignTokens.labelSmall,
              ),
            ],
          ),
          const SizedBox(height: DroidoDesignTokens.space2),
          Text(
            value,
            style: DroidoDesignTokens.valueMedium.copyWith(
              color: valueColor ?? DroidoDesignTokens.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Container(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      decoration: BoxDecoration(
        color: DroidoDesignTokens.surface,
        borderRadius: DroidoDesignTokens.cardRadius,
        border: Border.all(
          color: DroidoDesignTokens.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: DroidoDesignTokens.labelLarge,
          ),
          const SizedBox(height: DroidoDesignTokens.space3),
          ...children,
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: DroidoDesignTokens.space2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: DroidoDesignTokens.bodySmall.copyWith(
                color: DroidoDesignTokens.textTertiary,
              ),
            ),
          ),
          Expanded(
            child: SelectableText(
              value,
              style: DroidoDesignTokens.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCopyableRow(String value) {
    return Container(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingSmall),
      decoration: BoxDecoration(
        color: DroidoDesignTokens.background,
        borderRadius: DroidoDesignTokens.buttonRadius,
        border: Border.all(
          color: DroidoDesignTokens.border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SelectableText(
              value,
              style: DroidoDesignTokens.monoSmall,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.copy, size: 16),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: value));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('URL copied to clipboard'),
                  backgroundColor: DroidoDesignTokens.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            tooltip: 'Copy',
            color: DroidoDesignTokens.textSecondary,
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorCard(String error) {
    return Container(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      decoration: BoxDecoration(
        color: DroidoDesignTokens.errorLight,
        borderRadius: DroidoDesignTokens.cardRadius,
        border: Border.all(
          color: DroidoDesignTokens.error.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.error_outline,
                size: 16,
                color: DroidoDesignTokens.error,
              ),
              const SizedBox(width: DroidoDesignTokens.space2),
              Text(
                'ERROR',
                style: DroidoDesignTokens.labelLarge.copyWith(
                  color: DroidoDesignTokens.error,
                ),
              ),
            ],
          ),
          const SizedBox(height: DroidoDesignTokens.space2),
          SelectableText(
            error,
            style: DroidoDesignTokens.bodyMedium.copyWith(
              color: DroidoDesignTokens.error,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBodyCard(String title, dynamic body) {
    return Container(
      decoration: BoxDecoration(
        color: DroidoDesignTokens.surface,
        borderRadius: DroidoDesignTokens.cardRadius,
        border: Border.all(
          color: DroidoDesignTokens.border,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
            child: Text(
              title,
              style: DroidoDesignTokens.labelLarge,
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.fromLTRB(
              DroidoDesignTokens.paddingDefault,
              0,
              DroidoDesignTokens.paddingDefault,
              DroidoDesignTokens.paddingDefault,
            ),
            child: _buildJsonBody(body),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyCard(String message) {
    return Container(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingLarge * 2),
      decoration: BoxDecoration(
        color: DroidoDesignTokens.surface,
        borderRadius: DroidoDesignTokens.cardRadius,
        border: Border.all(
          color: DroidoDesignTokens.border,
        ),
      ),
      child: Center(
        child: Column(
          children: [
            const Icon(
              Icons.inbox_outlined,
              size: 48,
              color: DroidoDesignTokens.textQuaternary,
            ),
            const SizedBox(height: DroidoDesignTokens.space2),
            Text(
              message,
              style: DroidoDesignTokens.bodyMedium.copyWith(
                color: DroidoDesignTokens.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildJsonBody(dynamic body) {
    String formatted;
    try {
      if (body is String) {
        // Try to parse and pretty-print JSON string
        final decoded = jsonDecode(body);
        formatted = const JsonEncoder.withIndent('  ').convert(decoded);
      } else {
        formatted = const JsonEncoder.withIndent('  ').convert(body);
      }
    } catch (_) {
      formatted = body.toString();
    }

    return Container(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      decoration: BoxDecoration(
        color: DroidoDesignTokens.background,
        borderRadius: DroidoDesignTokens.buttonRadius,
        border: Border.all(
          color: DroidoDesignTokens.border,
        ),
      ),
      child: SelectableText(
        formatted,
        style: DroidoDesignTokens.mono.copyWith(
          fontSize: 12,
        ),
      ),
    );
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

  void _copyCurl() {
    final curl = Droido.generateCurl(widget.log);
    Clipboard.setData(ClipboardData(text: curl));

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('cURL copied to clipboard'),
        backgroundColor: DroidoDesignTokens.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
