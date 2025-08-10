  import 'package:dio/dio.dart';
import 'package:openelifba/data/network/interceptors/auth_interceptor.dart';
import 'package:openelifba/data/network/interceptors/logging_interceptor.dart';

import 'package:openelifba/data/network/apis/user/user_api.dart';
import 'package:openelifba/data/network/constants/endpoints.dart';
import 'package:openelifba/data/network/interceptors/error_interceptor.dart';
import 'package:openelifba/data/network/interceptors/auth_retry_interceptor.dart';
import 'package:openelifba/data/sharedpref/shared_preference_helper.dart';
import 'package:event_bus/event_bus.dart';

import '../../../di/service_locator.dart';
import '../../network/apis/category/category_api.dart';
import '../../network/apis/exercises/exercises_api.dart';
import '../../network/apis/memory/memory_api.dart';

class NetworkModule {
  static Future<void> configureNetworkModuleInjection() async {
    // event bus:---------------------------------------------------------------
    getIt.registerSingleton<EventBus>(EventBus());

    // interceptors:------------------------------------------------------------
    getIt.registerSingleton<LoggingInterceptor>(LoggingInterceptor());
    getIt.registerSingleton<ErrorInterceptor>(ErrorInterceptor(getIt()));
    getIt.registerSingleton<AuthInterceptor>(
      AuthInterceptor(
        accessToken: () async =>
            await getIt<SharedPreferenceHelper>().authToken,
      ),
    );
    getIt.registerSingleton<AuthRetryInterceptor>(
      AuthRetryInterceptor(getIt<SharedPreferenceHelper>()),
    );

    // dio:---------------------------------------------------------------------
    getIt.registerSingleton<Dio>(
      Dio()
        ..options.connectTimeout = const Duration(milliseconds: Endpoints.connectionTimeout)
        ..options.receiveTimeout = const Duration(milliseconds: Endpoints.receiveTimeout)
        ..interceptors.addAll([
          getIt<AuthInterceptor>(),
          getIt<AuthRetryInterceptor>(),
          getIt<ErrorInterceptor>(),
          getIt<LoggingInterceptor>(),
        ]),
    );

    // apis:-------------------------------------------------------------------

    getIt.registerSingleton<UserApi>(UserApi(getIt<Dio>()));
    getIt.registerSingleton<CategoryApi>(CategoryApi(getIt<Dio>()));
    getIt.registerSingleton<ExercisesApi>(ExercisesApi(getIt<Dio>()));
    getIt.registerSingleton<MemoryApi>(MemoryApi(getIt<Dio>()));
  }
}
