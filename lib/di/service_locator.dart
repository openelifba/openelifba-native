import 'package:openelifba/data/di/data_layer_injection.dart';
import 'package:openelifba/domain/di/domain_layer_injection.dart';
import 'package:openelifba/presentation/di/presentation_layer_injection.dart';
import 'package:openelifba/utils/logger/app_logger.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

class ServiceLocator {
  static Future<void> configureDependencies() async {
    try {
      AppLogger.debug('Configuring data layer dependencies');
      await DataLayerInjection.configureDataLayerInjection();

      AppLogger.debug('Configuring domain layer dependencies');
      await DomainLayerInjection.configureDomainLayerInjection();

      AppLogger.debug('Configuring presentation layer dependencies');
      await PresentationLayerInjection.configurePresentationLayerInjection();

      AppLogger.info('All dependencies configured successfully');
    } catch (error, stackTrace) {
      AppLogger.error('Failed to configure dependencies', 'ServiceLocator',
          error, stackTrace);
      rethrow;
    }
  }

  /// Reset all dependencies (useful for testing)
  static Future<void> reset() async {
    try {
      await getIt.reset();
      AppLogger.debug('Dependencies reset successfully');
    } catch (error, stackTrace) {
      AppLogger.error(
          'Failed to reset dependencies', 'ServiceLocator', error, stackTrace);
      rethrow;
    }
  }
}
