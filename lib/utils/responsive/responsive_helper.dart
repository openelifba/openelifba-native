import 'package:flutter/material.dart';

/// Helper class for responsive layout decisions
class ResponsiveHelper {
  ResponsiveHelper._();

  // Breakpoints
  static const double mobileBreakpoint = 600.0;
  static const double tabletBreakpoint = 900.0;
  static const double desktopBreakpoint = 1200.0;

  /// Check if current screen is mobile size
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < mobileBreakpoint;
  }

  /// Check if current screen is tablet size
  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= mobileBreakpoint && width < tabletBreakpoint;
  }

  /// Check if current screen is desktop size
  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= tabletBreakpoint;
  }

  /// Get responsive value based on screen size
  static T getValue<T>({
    required BuildContext context,
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop(context) && desktop != null) {
      return desktop;
    } else if (isTablet(context) && tablet != null) {
      return tablet;
    }
    return mobile;
  }

  /// Get responsive padding
  static EdgeInsets getPadding(BuildContext context) {
    return EdgeInsets.all(getValue<double>(
      context: context,
      mobile: 16.0,
      tablet: 24.0,
      desktop: 32.0,
    ));
  }

  /// Get responsive font size
  static double getFontSize(
    BuildContext context, {
    required double baseFontSize,
    double scaleFactor = 1.2,
  }) {
    if (isDesktop(context)) {
      return baseFontSize * scaleFactor;
    } else if (isTablet(context)) {
      return baseFontSize * (scaleFactor * 0.8);
    }
    return baseFontSize;
  }

  /// Get number of columns for grid layout
  static int getGridColumns(
    BuildContext context, {
    int mobileColumns = 1,
    int tabletColumns = 2,
    int desktopColumns = 3,
  }) {
    return getValue<int>(
      context: context,
      mobile: mobileColumns,
      tablet: tabletColumns,
      desktop: desktopColumns,
    );
  }
}
