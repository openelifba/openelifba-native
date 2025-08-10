/// Central configuration class for application-wide settings and constants
class AppConfig {
  AppConfig._();

  // App information
  static const String appName = 'Open Elifba';
  static const String appVersion = '1.0.0';

  // Error handling
  static const int errorDisplayDurationMs = 3000;
  static const int maxRetryAttempts = 3;

  // UI settings
  static const bool debugShowCheckedModeBanner = false;
  static const double defaultElevation = 4.0;

  // Network settings (these could be overridden by environment config)
  static const int connectionTimeoutMs = 30000;
  static const int receiveTimeoutMs = 15000;

  // Feature flags
  static const bool enableOfflineMode = true;
  static const bool enableAnalytics = false; // Set based on environment
  static const bool enableCrashReporting = false; // Set based on environment

  // Cache settings
  static const int maxCacheAgeHours = 24;
  static const int maxCacheSizeMB = 50;

  // Audio settings
  static const double defaultVolume = 1.0;
  static const bool enableHapticFeedback = true;

  // Learning settings
  static const int defaultExerciseBatchSize = 10;
  static const double masteryThreshold = 0.8; // 80% accuracy
}
