# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.1] - 2024-11-26

### Fixed
- Updated `intl` dependency from `^0.19.0` to `^0.20.0` for latest compatibility
- Removed explicit `meta` dependency (now provided by Flutter SDK)
- Improved pub.dev scoring for dependency compatibility

### Changed
- All dependencies now use latest compatible versions

## [1.0.0] - 2024-11-26

### Added

- 🎉 Initial release of Droido
- Network request/response logging via Dio interceptor
- Persistent notification with tap-to-open functionality
- Modern white-theme UI with Material Design
- In-app debug panel with three tabs (Overview, Request, Response)
- Real-time network log streaming
- Search and filter functionality for logs
- Export logs in multiple formats (JSON, HAR, CSV)
- cURL command generation for any request
- Detailed request metrics (time, size, duration)
- Color-coded status indicators and performance metrics
- Full request/response header and body inspection
- Formatted JSON display
- Error tracking with stack traces
- Configurable log retention and notification settings
- Clean architecture with SOLID principles
- Zero release build impact (debug-only, tree-shakable)
- Comprehensive API documentation

### Features

#### Core API
- `Droido.init()` - Initialize with Dio instance and optional configuration
- `Droido.setNotificationCallback()` - Handle notification taps
- `Droido.logs` - Access current network logs
- `Droido.logsStream` - Subscribe to log updates
- `Droido.searchLogs()` - Search logs by query
- `Droido.clearLogs()` - Clear all logs
- `Droido.logCount` - Get total log count
- `Droido.isInitialized` - Check initialization status
- `Droido.dispose()` - Clean up resources

#### Export & Utilities
- `Droido.exportAsJson()` - Export logs as JSON
- `Droido.exportAsHar()` - Export logs in HAR format
- `Droido.exportAsCsv()` - Export logs as CSV
- `Droido.generateCurl()` - Generate cURL command

#### UI Components
- `DroidoPanel` - Main debug panel widget
- `NetworkCard` - Modern request card with metrics
- `LogDetailPage` - Detailed request/response view
- `DesignTokens` - Centralized design system

#### Configuration
- Customizable via `DroidoConfig`
- Max logs limit
- Notification settings
- Header/Body inclusion options
- Body size limits
- Auto-clear on restart

### Technical

- Built with Flutter 3.10.0+
- Dart SDK 3.0.0+
- Dio 5.4.0+ integration
- Clean architecture implementation
- SOLID principles
- Comprehensive type safety
- Null-safe codebase

[1.0.1]: https://github.com/kapdroid/droido/releases/tag/v1.0.1
[1.0.0]: https://github.com/kapdroid/droido/releases/tag/v1.0.0
