import 'dart:io';

/// Utility class for network-related helper functions
class NetworkUtils {
  NetworkUtils._();

  /// Checks if the device has an active internet connection
  /// Uses a simple DNS lookup approach without external dependencies
  static Future<bool> isConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      return result.isNotEmpty && result[0].rawAddress.isNotEmpty;
    } catch (e) {
      // If we can't check connectivity, assume we're connected
      // to avoid blocking the user unnecessarily
      return true;
    }
  }

  /// Returns a user-friendly error message based on the error type
  static String getErrorMessage(Exception error) {
    if (error.toString().contains('SocketException')) {
      return 'No internet connection. Please check your network settings.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'Request timed out. Please try again.';
    } else if (error.toString().contains('FormatException')) {
      return 'Invalid data format received from server.';
    } else {
      return 'Something went wrong. Please try again later.';
    }
  }

  /// Validates if a URL is properly formatted
  static bool isValidUrl(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.hasScheme && (uri.scheme == 'http' || uri.scheme == 'https');
    } catch (e) {
      return false;
    }
  }
}
