import 'dart:async';

import 'package:openelifba/di/service_locator.dart';
import 'package:openelifba/presentation/my_app.dart';
import 'package:openelifba/utils/logger/app_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  // Ensure Flutter binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  AppLogger.info('Starting Elifba Native app');

  // Set up error handling
  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.error('Flutter error occurred', 'FlutterError', details.exception,
        details.stack);
    FlutterError.presentError(details);
  };

  runZonedGuarded<Future<void>>(() async {
    try {
      AppLogger.debug('Setting preferred orientations');
      await setPreferredOrientations();

      AppLogger.debug('Configuring dependencies');
      await ServiceLocator.configureDependencies();

      AppLogger.info('Launching app');
      runApp(MyApp());
    } catch (error, stackTrace) {
      AppLogger.error(
          'Error during app initialization', 'Init', error, stackTrace);
      // In a production app, you might want to send this to a crash reporting service
    }
  }, (error, stackTrace) {
    AppLogger.error('Uncaught error', 'Global', error, stackTrace);
    // In a production app, you might want to send this to a crash reporting service
  });
}

Future<void> setPreferredOrientations() {
  return SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeRight,
    DeviceOrientation.landscapeLeft,
  ]);
}
