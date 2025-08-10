import 'dart:async';

import 'package:openelifba/core/stores/error/error_store.dart';
import 'package:openelifba/core/stores/form/form_store.dart';
import 'package:openelifba/domain/repository/setting/setting_repository.dart';
import 'package:openelifba/domain/usecase/category/category_usecase.dart';
import 'package:openelifba/domain/usecase/device/get_device_id_usecase.dart';
import 'package:openelifba/domain/usecase/exercise/get_due_exercises_usecase.dart';
import 'package:openelifba/domain/usecase/memory/update_memory_usecase.dart';

import 'package:openelifba/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:openelifba/domain/usecase/user/login_usecase.dart';
import 'package:openelifba/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:openelifba/presentation/category/store/category_store.dart';
import 'package:openelifba/presentation/exercise/store/exercise_store.dart';
import 'package:openelifba/presentation/home/store/language/language_store.dart';
import 'package:openelifba/presentation/home/store/theme/theme_store.dart';
import 'package:openelifba/presentation/auth/store/user_store.dart';

import '../../../di/service_locator.dart';
import '../../../domain/usecase/user/register_usecase.dart';

class StoreModule {
  static Future<void> configureStoreModuleInjection() async {
    // factories:---------------------------------------------------------------
    getIt.registerFactory(() => ErrorStore());
    getIt.registerFactory(() => FormErrorStore());
    getIt.registerFactory(
      () => FormStore(getIt<FormErrorStore>(), getIt<ErrorStore>()),
    );

    // stores:------------------------------------------------------------------
    getIt.registerSingleton<UserStore>(
      UserStore(
        getIt<IsLoggedInUseCase>(),
        getIt<SaveLoginStatusUseCase>(),
        getIt<LoginUseCase>(),
        getIt<RegisterUseCase>(),
        getIt<GetDeviceIdUseCase>(),
        getIt<FormErrorStore>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ThemeStore>(
      ThemeStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<LanguageStore>(
      LanguageStore(
        getIt<SettingRepository>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<CategoryStore>(
      CategoryStore(
        getIt<GetCategoryUseCase>(),
        getIt<ErrorStore>(),
      ),
    );

    getIt.registerSingleton<ExerciseStore>(
      ExerciseStore(
        getIt<GetDueExercisesUseCase>(),
        getIt<UpdateMemoryUseCase>(),
        getIt<ErrorStore>(),
      ),
    );
  }
}
