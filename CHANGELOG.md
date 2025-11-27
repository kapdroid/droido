# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.0.2]

### Added
- Embedded demo walkthrough in README for quick preview

## [1.0.1] - 2024-11-26

### Added
- **Non-dismissable notification by default** - Notification now persistent by default (`notificationOngoing: true`), set to `false` to allow dismissing
- **Latest-first log ordering** - Network logs now display with newest requests at the top for better UX
- **Scroll starts at top** - ListView now properly starts at the top showing latest requests, not at bottom
- **Dio-specific clarification** - Updated documentation to clearly indicate this package works exclusively with Dio HTTP client

### Fixed
- Updated `intl` dependency from `^0.19.0` to `^0.20.0` for latest compatibility
- Removed explicit `meta` dependency (now provided by Flutter SDK)
- Improved pub.dev scoring for dependency compatibility
- Fixed Android 13+ notification permission request to work automatically
- Enhanced permission checking logic to avoid redundant requests

### Changed
- All dependencies now use latest compatible versions
- Notification permission is now automatically requested on Android 13+ during initialization
- **Notification is now static** - Removed periodic updates (no more 5-second polling)
- **Simplified notification message** - Changed from dynamic request count to static "Tap to open debug panel"
- **Log order reversed** - Latest requests appear first in all views (list, search, filter)

### Improved
- Better debug logging for permission status
- More reliable permission detection on all Android versions
- **Reduced battery/CPU usage** - No periodic timer running in background
- **Cleaner notification UI** - Simple, professional message without changing numbers
- **Better UX** - Latest requests immediately visible without scrolling

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
