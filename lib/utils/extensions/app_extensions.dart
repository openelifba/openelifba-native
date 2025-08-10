import 'package:flutter/material.dart';

/// Extension methods for String class to add common functionality
extension StringExtensions on String {
  /// Capitalizes the first letter of the string
  String get capitalized {
    if (isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }

  /// Capitalizes the first letter of each word
  String get titleCase {
    if (isEmpty) return this;
    return split(' ').map((word) => word.capitalized).join(' ');
  }

  /// Checks if string is a valid email
  bool get isValidEmail {
    final emailRegex =
        RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(this);
  }

  /// Truncates string to specified length with ellipsis
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength)}...';
  }
}

/// Extension methods for double class for formatting numbers
extension DoubleExtensions on double {
  /// Formats double as percentage with specified decimal places
  String toPercentage([int decimalPlaces = 1]) {
    return '${toStringAsFixed(decimalPlaces)}%';
  }

  /// Formats double as time in seconds
  String toSecondsFormat([int decimalPlaces = 1]) {
    return '${toStringAsFixed(decimalPlaces)}s';
  }

  /// Checks if double is within a reasonable accuracy range (0-100)
  bool get isValidAccuracy => this >= 0.0 && this <= 100.0;
}

/// Extension methods for BuildContext to access theme and media query easily
extension BuildContextExtensions on BuildContext {
  /// Quick access to theme
  ThemeData get theme => Theme.of(this);

  /// Quick access to color scheme
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  /// Quick access to text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Quick access to media query
  MediaQueryData get mediaQuery => MediaQuery.of(this);

  /// Quick access to screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Check if current theme is dark
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Quick access to padding (safe area)
  EdgeInsets get padding => MediaQuery.of(this).padding;
}

/// Extension methods for DateTime for common formatting
extension DateTimeExtensions on DateTime {
  /// Formats date as "Jan 1, 2024"
  String get formatted {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    return '${months[month - 1]} $day, $year';
  }

  /// Returns time ago string like "2 hours ago"
  String get timeAgo {
    final now = DateTime.now();
    final difference = now.difference(this);

    if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }
}
