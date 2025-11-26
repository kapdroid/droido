import 'package:droido/droido.dart';
import 'package:droido/src/presentation/theme/design_tokens.dart';
import 'package:droido/src/presentation/widgets/log_detail_page.dart';
import 'package:droido/src/presentation/widgets/network_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Main Droido debug panel
///
/// Displays network logs with search, filter, and detail views.
class DroidoPanel extends StatefulWidget {
  const DroidoPanel({super.key});

  @override
  State<DroidoPanel> createState() => _DroidoPanelState();
}

class _DroidoPanelState extends State<DroidoPanel> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: DroidoDesignTokens.background,
      appBar: AppBar(
        backgroundColor: DroidoDesignTokens.surface,
        foregroundColor: DroidoDesignTokens.textPrimary,
        elevation: 0,
        title: const Text('Droido', style: DroidoDesignTokens.headingMedium),
        actions: [
          IconButton(
            icon: const Icon(Icons.file_download_outlined),
            onPressed: () => _showExportDialog(context),
            tooltip: 'Export Logs',
            color: DroidoDesignTokens.textSecondary,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: () => _confirmClearLogs(context),
            tooltip: 'Clear Logs',
            color: DroidoDesignTokens.textSecondary,
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: DroidoDesignTokens.border,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: StreamBuilder<List<NetworkLog>>(
              stream: Droido.logsStream,
              builder: (context, snapshot) {
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return _buildEmptyState();
                }

                final logs = _filterLogs(snapshot.data!);

                if (logs.isEmpty) {
                  return _buildNoResultsState();
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: logs.length,
                  itemBuilder: (context, index) {
                    final log = logs[index];
                    return NetworkCard(
                      log: log,
                      onTap: () => _openLogDetail(context, log),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
      decoration: const BoxDecoration(
        color: DroidoDesignTokens.surface,
        border: Border(
          bottom: BorderSide(
            color: DroidoDesignTokens.border,
            width: 1,
          ),
        ),
      ),
      child: TextField(
        controller: _searchController,
        style: DroidoDesignTokens.bodyMedium,
        decoration: InputDecoration(
          hintText: 'Search URL, method, status...',
          hintStyle: DroidoDesignTokens.bodyMedium.copyWith(
            color: DroidoDesignTokens.textTertiary,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: DroidoDesignTokens.textTertiary,
          ),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: const Icon(
                    Icons.clear,
                    color: DroidoDesignTokens.textTertiary,
                  ),
                  onPressed: () {
                    setState(() {
                      _searchController.clear();
                      _searchQuery = '';
                    });
                  },
                )
              : null,
          filled: true,
          fillColor: DroidoDesignTokens.background,
          border: const OutlineInputBorder(
            borderRadius: DroidoDesignTokens.buttonRadius,
            borderSide: BorderSide(
              color: DroidoDesignTokens.border,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: DroidoDesignTokens.buttonRadius,
            borderSide: BorderSide(
              color: DroidoDesignTokens.border,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: DroidoDesignTokens.buttonRadius,
            borderSide: BorderSide(
              color: DroidoDesignTokens.info,
              width: 2,
            ),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: DroidoDesignTokens.paddingDefault,
            vertical: DroidoDesignTokens.paddingSmall,
          ),
        ),
        onChanged: (value) {
          setState(() {
            _searchQuery = value;
          });
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.wifi_tethering,
            size: 64,
            color: DroidoDesignTokens.textTertiary,
          ),
          const SizedBox(height: DroidoDesignTokens.space4),
          const Text(
            'No Network Requests Yet',
            style: DroidoDesignTokens.headingMedium,
          ),
          const SizedBox(height: DroidoDesignTokens.space2),
          Text(
            'Make an API call to see it here',
            style: DroidoDesignTokens.bodySmall.copyWith(
              color: DroidoDesignTokens.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoResultsState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.search_off,
            size: 64,
            color: DroidoDesignTokens.textTertiary,
          ),
          const SizedBox(height: DroidoDesignTokens.space4),
          const Text(
            'No Results Found',
            style: DroidoDesignTokens.headingMedium,
          ),
          const SizedBox(height: DroidoDesignTokens.space2),
          Text(
            'Try a different search term',
            style: DroidoDesignTokens.bodySmall.copyWith(
              color: DroidoDesignTokens.textTertiary,
            ),
          ),
        ],
      ),
    );
  }

  List<NetworkLog> _filterLogs(List<NetworkLog> logs) {
    if (_searchQuery.isEmpty) return logs;
    return Droido.searchLogs(_searchQuery);
  }

  void _openLogDetail(BuildContext context, NetworkLog log) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => LogDetailPage(log: log)));
  }

  void _showExportDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: DroidoDesignTokens.surface,
        title: const Text(
          'Export Logs',
          style: DroidoDesignTokens.headingMedium,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildExportButton(
              'Export as JSON',
              Icons.code,
              () => _exportLogs('json'),
            ),
            const SizedBox(height: DroidoDesignTokens.space2),
            _buildExportButton(
              'Export as HAR',
              Icons.archive,
              () => _exportLogs('har'),
            ),
            const SizedBox(height: DroidoDesignTokens.space2),
            _buildExportButton(
              'Export as CSV',
              Icons.table_chart,
              () => _exportLogs('csv'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: DroidoDesignTokens.bodyMedium.copyWith(
                color: DroidoDesignTokens.textSecondary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExportButton(String label, IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: DroidoDesignTokens.buttonRadius,
      child: Container(
        padding: const EdgeInsets.all(DroidoDesignTokens.paddingDefault),
        decoration: BoxDecoration(
          color: DroidoDesignTokens.background,
          borderRadius: DroidoDesignTokens.buttonRadius,
          border: Border.all(
            color: DroidoDesignTokens.border,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: DroidoDesignTokens.info),
            const SizedBox(width: DroidoDesignTokens.space4),
            Text(label, style: DroidoDesignTokens.bodyMedium),
          ],
        ),
      ),
    );
  }

  void _exportLogs(String format) {
    Navigator.of(context).pop();

    String content;
    switch (format) {
      case 'json':
        content = Droido.exportAsJson();
        break;
      case 'har':
        content = Droido.exportAsHar();
        break;
      case 'csv':
        content = Droido.exportAsCsv();
        break;
      default:
        return;
    }

    Clipboard.setData(ClipboardData(text: content));

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Copied ${format.toUpperCase()} to clipboard'),
        backgroundColor: DroidoDesignTokens.success,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _confirmClearLogs(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: DroidoDesignTokens.surface,
        title: const Text(
          'Clear All Logs?',
          style: DroidoDesignTokens.headingMedium,
        ),
        content: const Text(
          'This will delete all network logs. This action cannot be undone.',
          style: DroidoDesignTokens.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text(
              'Cancel',
              style: DroidoDesignTokens.bodyMedium.copyWith(
                color: DroidoDesignTokens.textSecondary,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Droido.clearLogs();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Logs cleared'),
                  backgroundColor: DroidoDesignTokens.success,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
            child: Text(
              'Clear',
              style: DroidoDesignTokens.bodyMedium.copyWith(
                color: DroidoDesignTokens.error,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
