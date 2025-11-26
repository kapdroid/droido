import 'package:flutter/material.dart';

/// Design tokens for Droido UI
///
/// Centralized design system with:
/// - Color palette (white theme with subtle accents)
/// - Typography scale
/// - Spacing system
/// - Shadow definitions
class DroidoDesignTokens {
  DroidoDesignTokens._();

  // ============================================================
  // COLORS
  // ============================================================

  /// Base colors
  static const background = Color(0xFFFFFFFF); // Pure white
  static const surface = Color(0xFFFAFAFA); // Off-white cards
  static const surfaceElevated = Color(0xFFF5F5F5); // Slightly darker surface
  static const border = Color(0xFFE5E7EB); // Light grey border
  static const divider = Color(0xFFE5E7EB); // Divider line

  /// Text colors
  static const textPrimary = Color(0xFF111827); // Near black - main text
  static const textSecondary = Color(0xFF374151); // Dark grey - secondary
  static const textTertiary = Color(0xFF6B7280); // Medium grey - labels
  static const textQuaternary = Color(0xFF9CA3AF); // Light grey - hints

  /// Status colors (2xx)
  static const success = Color(0xFF10B981); // Green
  static const successLight = Color(0xFFF0FDF4); // Light green background
  static const successBorder = Color(0xFFBBF7D0); // Light green border

  /// Warning colors (3xx, 4xx client errors)
  static const warning = Color(0xFFF59E0B); // Amber
  static const warningLight = Color(0xFFFEF3C7); // Light amber background
  static const warningBorder = Color(0xFFFDE68A); // Light amber border

  /// Error colors (5xx server errors)
  static const error = Color(0xFFEF4444); // Red
  static const errorLight = Color(0xFFFEF2F2); // Light red background
  static const errorBorder = Color(0xFFFECACA); // Light red border

  /// Info colors (pending, info states)
  static const info = Color(0xFF3B82F6); // Blue
  static const infoLight = Color(0xFFEFF6FF); // Light blue background
  static const infoBorder = Color(0xFFBFDBFE); // Light blue border

  /// Method colors
  static const methodGet = Color(0xFF3B82F6); // Blue
  static const methodPost = Color(0xFF10B981); // Green
  static const methodPut = Color(0xFFF59E0B); // Amber
  static const methodPatch = Color(0xFF8B5CF6); // Purple
  static const methodDelete = Color(0xFFEF4444); // Red
  static const methodDefault = Color(0xFF6B7280); // Grey

  /// Performance colors (for duration indicators)
  static const performanceFast = Color(0xFF10B981); // < 500ms - Green
  static const performanceNormal = Color(0xFFF59E0B); // < 2s - Amber
  static const performanceSlow = Color(0xFFEF4444); // > 2s - Red

  // ============================================================
  // TYPOGRAPHY
  // ============================================================

  /// Heading styles
  static const headingLarge = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    height: 1.3,
    letterSpacing: -0.2,
  );

  static const headingMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );

  static const headingSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );

  /// Body text styles
  static const bodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    color: textPrimary,
    height: 1.5,
  );

  static const bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );

  static const bodySmall = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: textSecondary,
    height: 1.5,
  );

  /// Label styles (uppercase, for metric labels)
  static const labelLarge = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: textTertiary,
    height: 1.2,
  );

  static const labelSmall = TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.5,
    color: textQuaternary,
    height: 1.2,
  );

  /// Value styles (for displaying data)
  static const valueLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: textPrimary,
    height: 1.3,
  );

  static const valueMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: textPrimary,
    height: 1.4,
  );

  static const valueSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: textSecondary,
    height: 1.4,
  );

  /// Badge styles
  static const badgeLarge = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    height: 1.2,
  );

  static const badgeSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w700,
    letterSpacing: 0.3,
    height: 1.2,
  );

  /// Monospace styles (for code, URLs)
  static const mono = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    fontFamily: 'monospace',
    color: textPrimary,
    height: 1.5,
  );

  static const monoSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    fontFamily: 'monospace',
    color: textSecondary,
    height: 1.5,
  );

  // ============================================================
  // SPACING
  // ============================================================

  /// Spacing scale (4px base)
  static const double space0 = 0;
  static const double space1 = 4; // xs
  static const double space2 = 8; // sm
  static const double space3 = 12; // md
  static const double space4 = 16; // lg (default)
  static const double space5 = 20; // xl
  static const double space6 = 24; // 2xl
  static const double space8 = 32; // 3xl
  static const double space10 = 40; // 4xl
  static const double space12 = 48; // 5xl
  static const double space16 = 64; // 6xl

  /// Semantic spacing
  static const double paddingTiny = space1;
  static const double paddingSmall = space2;
  static const double paddingMedium = space3;
  static const double paddingDefault = space4;
  static const double paddingLarge = space5;
  static const double paddingXLarge = space6;

  static const double gapTiny = space1;
  static const double gapSmall = space2;
  static const double gapMedium = space3;
  static const double gapDefault = space4;
  static const double gapLarge = space6;

  // ============================================================
  // BORDERS & RADIUS
  // ============================================================

  static const double borderWidthThin = 1.0;
  static const double borderWidthMedium = 1.5;
  static const double borderWidthThick = 2.0;

  static const double radiusSmall = 6.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  static const double radiusFull = 999.0;

  static const cardRadius = BorderRadius.all(Radius.circular(radiusLarge));
  static const badgeRadius = BorderRadius.all(Radius.circular(radiusSmall));
  static const buttonRadius = BorderRadius.all(Radius.circular(radiusMedium));

  // ============================================================
  // SHADOWS
  // ============================================================

  /// Subtle shadow for cards
  static const cardShadow = [
    BoxShadow(
      color: Color(0x05000000),
      offset: Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  /// Medium shadow for elevated elements
  static const elevatedShadow = [
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -1,
    ),
    BoxShadow(
      color: Color(0x0F000000),
      offset: Offset(0, 2),
      blurRadius: 4,
      spreadRadius: -1,
    ),
  ];

  /// Strong shadow for modals/dialogs
  static const modalShadow = [
    BoxShadow(
      color: Color(0x14000000),
      offset: Offset(0, 10),
      blurRadius: 15,
      spreadRadius: -3,
    ),
    BoxShadow(
      color: Color(0x0A000000),
      offset: Offset(0, 4),
      blurRadius: 6,
      spreadRadius: -2,
    ),
  ];

  // ============================================================
  // ANIMATIONS
  // ============================================================

  static const animationDurationFast = Duration(milliseconds: 150);
  static const animationDurationNormal = Duration(milliseconds: 250);
  static const animationDurationSlow = Duration(milliseconds: 400);

  static const animationCurve = Curves.easeInOut;
  static const animationCurveEmphasized = Curves.easeOutCubic;

  // ============================================================
  // HELPER METHODS
  // ============================================================

  /// Get status color based on HTTP status code
  static Color getStatusColor(int? statusCode) {
    if (statusCode == null) return textTertiary;
    if (statusCode >= 200 && statusCode < 300) return success;
    if (statusCode >= 300 && statusCode < 400) return info;
    if (statusCode >= 400 && statusCode < 500) return warning;
    return error;
  }

  /// Get surface color based on status
  static Color getSurfaceColor(int? statusCode) {
    if (statusCode == null) return surface;
    if (statusCode >= 200 && statusCode < 300) return surface;
    if (statusCode >= 400) return errorLight;
    return surface;
  }

  /// Get method color
  static Color getMethodColor(String method) {
    switch (method.toUpperCase()) {
      case 'GET':
        return methodGet;
      case 'POST':
        return methodPost;
      case 'PUT':
        return methodPut;
      case 'PATCH':
        return methodPatch;
      case 'DELETE':
        return methodDelete;
      default:
        return methodDefault;
    }
  }

  /// Get duration color based on performance
  static Color getDurationColor(int? ms) {
    if (ms == null) return textTertiary;
    if (ms < 500) return performanceFast;
    if (ms < 2000) return performanceNormal;
    return performanceSlow;
  }
}
