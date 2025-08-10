import 'dart:async';

import 'package:openelifba/domain/repository/category/category_repository.dart';
import 'package:openelifba/domain/repository/exercises/exercises_repository.dart';
import 'package:openelifba/domain/repository/memory/memory_repository.dart';

import 'package:openelifba/domain/repository/user/user_repository.dart';
import 'package:openelifba/domain/usecase/category/category_usecase.dart';
import 'package:openelifba/domain/usecase/device/get_device_id_usecase.dart';
import 'package:openelifba/domain/usecase/exercise/get_due_exercises_usecase.dart';
import 'package:openelifba/domain/usecase/memory/update_memory_usecase.dart';

import 'package:openelifba/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:openelifba/domain/usecase/user/login_usecase.dart';
import 'package:openelifba/domain/usecase/user/save_login_in_status_usecase.dart';

import '../../../di/service_locator.dart';
import '../../usecase/user/register_usecase.dart';

class UseCaseModule {
  static Future<void> configureUseCaseModuleInjection() async {
    // user:--------------------------------------------------------------------
    getIt.registerSingleton<IsLoggedInUseCase>(
      IsLoggedInUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<SaveLoginStatusUseCase>(
      SaveLoginStatusUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<LoginUseCase>(
      LoginUseCase(getIt<UserRepository>()),
    );
    getIt.registerSingleton<RegisterUseCase>(
      RegisterUseCase(getIt<UserRepository>()),
    );

    // device:------------------------------------------------------------------
    getIt.registerSingleton<GetDeviceIdUseCase>(
      GetDeviceIdUseCase(),
    );

    // category:----------------------------------------------------------------
    getIt.registerSingleton<GetCategoryUseCase>(
      GetCategoryUseCase(getIt<CategoryRepository>()),
    );

    // exercises:---------------------------------------------------------------
    getIt.registerSingleton<GetDueExercisesUseCase>(
      GetDueExercisesUseCase(getIt<ExercisesRepository>()),
    );

    // memory:------------------------------------------------------------------
    getIt.registerSingleton<UpdateMemoryUseCase>(
      UpdateMemoryUseCase(getIt<MemoryRepository>()),
    );
  }
}
