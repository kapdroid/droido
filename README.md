# 🤖 Droido

A lightweight, debug-only network inspector for Flutter apps using **Dio HTTP client**. Features a clean, modern UI with persistent notification. Built with clean architecture principles and zero impact on release builds.

[![pub package](https://img.shields.io/pub/v/droido.svg)](https://pub.dev/packages/droido)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

## ✨ Features

- 📡 **Network Inspection** - Capture and inspect all HTTP requests/responses via Dio interceptor
- 🔔 **Persistent Notification** - Always-visible debug notification (debug mode only)
- 🎨 **Modern UI** - Clean white-theme interface with Material Design
- 🔍 **Search & Filter** - Quickly find specific requests
- 📤 **Export Options** - Export as JSON, HAR, or CSV formats
- 🔄 **cURL Generation** - Generate cURL commands for any request
- 🌲 **Tree-Shakable** - Zero footprint in release builds
- 📊 **Detailed Metrics** - Request time, response size, duration with color-coded indicators
- 🏗️ **Clean Architecture** - SOLID principles, testable, maintainable

## ✨ Demo

Watch the latest walkthrough directly below:

https://github.com/user-attachments/assets/5fc2c999-7ef2-4e02-86cd-98507a1ceba6

## 📦 Installation

Add to your `pubspec.yaml`:

```yaml
dependencies:
  droido: ^1.0.2
  dio: ^5.4.0  # Required peer dependency
```

Then run:

```bash
flutter pub get
```

### Android Setup (Required)

Add required permissions to `android/app/src/main/AndroidManifest.xml`:

```xml
<manifest xmlns:android="http://schemas.android.com/apk/res/android">
    <!-- Required for Android 13+ notifications -->
    <uses-permission android:name="android.permission.POST_NOTIFICATIONS"/>
    
    <application>
        <!-- Your existing configuration -->
    </application>
</manifest>
```

**Note:** On Android 13+, notification permission will be **automatically requested** when Droido initializes. Users will see a system permission dialog on first launch.

### iOS Setup

No additional setup required for iOS.

## 🚀 Quick Start

### Basic Setup

```dart
import 'package:droido/droido.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Create your Dio instance
  final dio = Dio();

  // Initialize Droido (only works in debug mode)
  await Droido.init(dio: dio);

  // Set up notification tap callback
  Droido.setNotificationCallback(() {
    // Navigate to debug panel
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const DroidoPanel()),
    );
  });

  runApp(const MyApp());
}
```
### Already have Notification Local Notification
```dart
// No need to implement
  Droido.setNotificationCallback(() {
    // Navigate to debug panel
    navigatorKey.currentState?.push(
      MaterialPageRoute(builder: (_) => const DroidoPanel()),
    );
  });

// Inside your existing onDidReceiveNotificationResponse callback
// details.payload should '{"type":"droido"}'
if (isDebug) {
  Droido.handlePayload(details.payload);   // where details is 
}

// Example using flutter_local_notifications
_notificationsPlugin.initialize(
  initializationSettings,
  onDidReceiveNotificationResponse: (NotificationResponse details) {
    // Forward the payload to Droido in debug mode
    if (isDebug) {
      Droido.handlePayload(details.payload);
    }
  },
);

```
### With Configuration

```dart
await Droido.init(
  dio: dio,
  config: const DroidoConfig(
    maxLogs: 500,                      // Maximum logs to keep
    enableNotification: true,          // Show notification
    notificationTitle: 'Debug Active', // Notification title
    notificationOngoing: false,        // Set to false to allow dismissing (default: true)
    includeRequestHeaders: true,       // Log request headers
    includeResponseHeaders: true,      // Log response headers
    includeRequestBody: true,          // Log request body
    includeResponseBody: true,         // Log response body
    maxBodySize: 1048576,             // Max body size (1MB)
    autoClearOnRestart: false,        // Clear logs on restart
  ),
);
```

### That's it! 🎉

Droido automatically captures all network requests made through your Dio instance. Tap the notification to open the debug panel.

## 📖 API Reference

### Initialize

```dart
// Basic initialization
await Droido.init(dio: dio);

// With custom configuration
await Droido.init(
  dio: dio,
  config: const DroidoConfig(
    maxLogs: 1000,
    enableNotification: true,
  ),
);
```

### Notification Callback

```dart
// Set callback for notification tap
Droido.setNotificationCallback(() {
  // Your navigation logic
  navigatorKey.currentState?.push(
    MaterialPageRoute(builder: (_) => const DroidoPanel()),
  );
});
```

### Access Logs

```dart
// Get logs stream
Stream<List<NetworkLog>> stream = Droido.logsStream;

// Get current logs
List<NetworkLog> logs = Droido.logs;

// Get log count
int count = Droido.logCount;
```

### Search & Filter

```dart
// Search logs by URL, method, or status
List<NetworkLog> results = Droido.searchLogs('api/users');
```

### Export Logs

```dart
// Export as JSON
String json = Droido.exportAsJson();

// Export as HAR format
String har = Droido.exportAsHar();

// Export as CSV
String csv = Droido.exportAsCsv();
```

### Generate cURL

```dart
// Generate cURL command for a request
String curl = Droido.generateCurl(log);
```

### Clear Logs

```dart
// Clear all logs
await Droido.clearLogs();
```

### Dispose

```dart
// Dispose resources
await Droido.dispose();
```

## 📱 UI Components

### DroidoPanel

Main debug panel showing all network requests:

```dart
MaterialPageRoute(
  builder: (_) => const DroidoPanel(),
);
```

Features:
- List of all network requests
- Search functionality
- Export options
- Tap to view detailed request/response

### Request Detail View

Automatically shown when tapping a request card. Shows:
- Request time, response size, and duration
- Method and status code
- Full URL with copy button
- Request/Response headers and body
- Formatted JSON display
- Error messages (if any)

## ⚙️ Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `maxLogs` | `int` | `500` | Maximum number of logs to keep in memory |
| `enableNotification` | `bool` | `true` | Show persistent notification |
| `notificationTitle` | `String` | `'Debug Active'` | Notification title text |
| `notificationOngoing` | `bool` | `true` | Make notification non-dismissable (persistent until app closed) |
| `notificationChannelId` | `String` | `'droido_debug_channel'` | Android notification channel ID |
| `notificationChannelName` | `String` | `'Droido Debug'` | Android notification channel name |
| `includeRequestHeaders` | `bool` | `true` | Include request headers in logs |
| `includeResponseHeaders` | `bool` | `true` | Include response headers in logs |
| `includeRequestBody` | `bool` | `true` | Include request body in logs |
| `includeResponseBody` | `bool` | `true` | Include response body in logs |
| `maxBodySize` | `int?` | `1048576` | Maximum body size to log (bytes) |
| `autoClearOnRestart` | `bool` | `false` | Clear logs when app restarts |

## 🎨 UI Highlights

### Modern Design
- Clean white theme with subtle shadows
- Color-coded status indicators (2xx = green, 4xx = amber, 5xx = red)
- Method-based coloring (GET = blue, POST = green, DELETE = red)
- Performance indicators (fast = green, slow = red)

### Metric Cards
Each request displays:
- ⏱ Request time (HH:MM:SS)
- 📊 Response size (B/KB/MB)
- ⚡ Duration (ms/s) with color coding

### Detail View Tabs
- **Overview**: Key metrics and request details
- **Request**: Headers and body
- **Response**: Headers and body

## 🏗️ Architecture

Droido follows **Clean Architecture** principles:

```
lib/
├── droido.dart              # Public API
└── src/
    ├── core/               # Domain layer (pure Dart)
    │   ├── entities/      # Domain models
    │   ├── repositories/  # Abstract contracts
    │   └── usecases/      # Business logic
    ├── data/              # Data layer
    │   ├── repositories/  # Concrete implementations
    │   └── services/      # External services
    ├── presentation/      # Presentation layer
    │   ├── pages/        # UI screens
    │   ├── widgets/      # Reusable widgets
    │   └── theme/        # Design tokens
    └── di/                # Dependency injection
```

### SOLID Principles
- **Single Responsibility**: Each class has one clear purpose
- **Open/Closed**: Extensible through interfaces
- **Liskov Substitution**: Interface-based design
- **Interface Segregation**: Minimal, focused interfaces
- **Dependency Inversion**: Depends on abstractions

## 🔒 Privacy & Security

- **Debug Only**: All functionality wrapped in `kDebugMode` checks
- **Tree-Shakable**: Completely removed from release builds
- **No Analytics**: Zero external data transmission
- **Local Storage**: All data stays on device
- **No Permissions**: Minimal permissions required (only notifications)

## 🧪 Testing

Droido is designed to be no-op in release builds:

```dart
import 'package:droido/droido.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Droido is no-op in release mode', () {
    // kDebugMode is false in tests
    expect(Droido.isInitialized, false);
    expect(Droido.logs, isEmpty);
  });
}
```

## 📊 NetworkLog Model

```dart
class NetworkLog {
  final String id;                           // Unique identifier
  final String url;                          // Request URL
  final String method;                       // HTTP method
  final DateTime timestamp;                  // Request time
  final Map<String, dynamic>? requestHeaders;
  final dynamic requestBody;
  final int? statusCode;                     // Response status
  final Map<String, dynamic>? responseHeaders;
  final dynamic responseBody;
  final int? durationMs;                     // Duration in milliseconds
  final String? errorMessage;                // Error if failed
  final StackTrace? stackTrace;              // Stack trace if error
  
  // Computed properties
  bool get isSuccessful;  // Status 200-299
  bool get isFailed;      // Status 400+
  bool get isPending;     // No response yet
  String get statusDescription;  // Human-readable status
  String get domain;      // Extracted domain
  String get path;        // URL path
}
```

## 💡 Inspired By

- [Chucker](https://github.com/ChuckerTeam/chucker) - Android HTTP inspector
- [Netfox](https://github.com/kasketis/netfox) - iOS network debugging
- [Alice](https://github.com/jhomlala/alice) - Flutter HTTP inspector

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📝 License

MIT License - see the [LICENSE](LICENSE) file for details.

## 📧 Support

- 🐛 [Report Issues](https://github.com/kapdroid/droido/issues)
- 💡 [Request Features](https://github.com/kapdroid/droido/issues/new)
- 📖 [Documentation](https://pub.dev/documentation/droido/latest/)

---

Made with ❤️ for the Flutter community
