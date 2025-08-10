/// Utility class for common validation functions
class ValidationUtils {
  ValidationUtils._();

  /// Validates email format
  static bool isValidEmail(String email) {
    if (email.isEmpty) return false;

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email);
  }

  /// Validates password strength
  static bool isValidPassword(String password, {int minLength = 6}) {
    if (password.length < minLength) return false;

    // Check for at least one letter and one number
    final hasLetter = RegExp(r'[a-zA-Z]').hasMatch(password);
    final hasNumber = RegExp(r'[0-9]').hasMatch(password);

    return hasLetter && hasNumber;
  }

  /// Validates if string is not empty and not just whitespace
  static bool isNotEmpty(String? value) {
    return value != null && value.trim().isNotEmpty;
  }

  /// Validates if string has minimum length
  static bool hasMinLength(String? value, int minLength) {
    return value != null && value.length >= minLength;
  }

  /// Validates if string has maximum length
  static bool hasMaxLength(String? value, int maxLength) {
    return value != null && value.length <= maxLength;
  }

  /// Validates if value is within numeric range
  static bool isInRange(num? value, num min, num max) {
    return value != null && value >= min && value <= max;
  }

  /// Validates if accuracy percentage is valid (0-100)
  static bool isValidAccuracy(double? accuracy) {
    return accuracy != null && accuracy >= 0.0 && accuracy <= 100.0;
  }

  /// Validates if response time is reasonable (0-60 seconds)
  static bool isValidResponseTime(int? responseTimeMillis) {
    return responseTimeMillis != null &&
        responseTimeMillis >= 0 &&
        responseTimeMillis <= 60000; // 60 seconds
  }
}
