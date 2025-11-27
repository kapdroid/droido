import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:droido/droido.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create Dio instance
  final dio = Dio(
    BaseOptions(
      baseUrl: 'http://jsonplaceholder.typicode.com/',
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 10),
    ),
  );

  // Initialize Droido
  await Droido.init(
    dio: dio,
    config: const DroidoConfig(
      maxLogs: 500,
      enableNotification: true,
      notificationTitle: 'Droido Example',
    ),
  );

  // Set notification tap callback
  Droido.setNotificationCallback(() {
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const DroidoPanel()),
    );
  });

  runApp(MyApp(dio: dio));
}

class MyApp extends StatelessWidget {
  const MyApp({required this.dio, super.key});

  final Dio dio;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Droido Example',
      navigatorKey: navigatorKey,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ExampleHomePage(dio: dio),
    );
  }
}

class ExampleHomePage extends StatelessWidget {
  const ExampleHomePage({required this.dio, super.key});

  final Dio dio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Droido Example'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report),
            onPressed: () {
              Navigator.of(
                context,
              ).push(MaterialPageRoute(builder: (_) => const DroidoPanel()));
            },
            tooltip: 'Open Debug Panel',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            'Network Testing',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildButton(
            context,
            'GET Request',
            Icons.download,
            Colors.green,
            () => _testGet(context),
          ),
          _buildButton(
            context,
            'POST Request',
            Icons.upload,
            Colors.blue,
            () => _testPost(context),
          ),
          _buildButton(
            context,
            'Failed Request (404)',
            Icons.error,
            Colors.orange,
            () => _testFailed(context),
          ),
          _buildButton(
            context,
            'Multiple Requests',
            Icons.refresh,
            Colors.purple,
            () => _testMultiple(context),
          ),
          const SizedBox(height: 32),
          const Text(
            'Log Management',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildButton(
            context,
            'Clear Logs',
            Icons.delete,
            Colors.red,
            () => _clearLogs(context),
          ),
          _buildButton(
            context,
            'Show Log Count',
            Icons.info,
            Colors.grey,
            () => _showLogCount(context),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onPressed,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: Icon(icon),
        label: Text(label),
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 56),
        ),
      ),
    );
  }

  Future<void> _testGet(BuildContext context) async {
    try {
      await dio.get('/posts/1');
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('GET request successful')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _testPost(BuildContext context) async {
    try {
      await dio.post(
        '/posts',
        data: {
          'title': 'Test Post',
          'body': 'This is a test post from Droido example',
          'userId': 1,
        },
      );
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('POST request successful')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  Future<void> _testFailed(BuildContext context) async {
    try {
      await dio.get('/posts/99999999');
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Expected 404 error logged')),
        );
      }
    }
  }

  Future<void> _testMultiple(BuildContext context) async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Sending 5 requests...')));

    for (int i = 1; i <= 5; i++) {
      await dio.get('/posts/$i');
    }

    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('All requests completed')));
    }
  }

  Future<void> _clearLogs(BuildContext context) async {
    await Droido.clearLogs();
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Logs cleared')));
    }
  }

  void _showLogCount(BuildContext context) {
    final count = Droido.logCount;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Log Count'),
        content: Text('Currently tracking $count network requests'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
