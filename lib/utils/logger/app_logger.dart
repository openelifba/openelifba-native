import 'package:flutter/foundation.dart';

/// Centralized logging utility for the application
class AppLogger {
  AppLogger._();

  static const String _tag = 'ElifbaApp';

  /// Log debug messages (only in debug mode)
  static void debug(String message, [String? tag]) {
    if (kDebugMode) {
      debugPrint('[$_tag${tag != null ? ':$tag' : ''}] DEBUG: $message');
    }
  }

  /// Log info messages
  static void info(String message, [String? tag]) {
    debugPrint('[$_tag${tag != null ? ':$tag' : ''}] INFO: $message');
  }

  /// Log warning messages
  static void warning(String message, [String? tag]) {
    debugPrint('[$_tag${tag != null ? ':$tag' : ''}] WARNING: $message');
  }

  /// Log error messages
  static void error(String message,
      [String? tag, Object? error, StackTrace? stackTrace]) {
    debugPrint('[$_tag${tag != null ? ':$tag' : ''}] ERROR: $message');
    if (error != null) {
      debugPrint('Error details: $error');
    }
    if (stackTrace != null && kDebugMode) {
      debugPrint('Stack trace: $stackTrace');
    }
  }

  /// Log network requests and responses
  static void network(String message, [String? endpoint]) {
    if (kDebugMode) {
      debugPrint(
          '[$_tag:Network${endpoint != null ? ':$endpoint' : ''}] $message');
    }
  }

  /// Log user interactions
  static void userAction(String action, [Map<String, dynamic>? data]) {
    if (kDebugMode) {
      String message = 'User action: $action';
      if (data != null && data.isNotEmpty) {
        message += ' | Data: $data';
      }
      debugPrint('[$_tag:UserAction] $message');
    }
  }
}
