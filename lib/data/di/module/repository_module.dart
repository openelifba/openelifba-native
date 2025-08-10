import 'dart:async';

import 'package:openelifba/data/repository/setting/setting_repository_impl.dart';

import 'package:openelifba/data/sharedpref/shared_preference_helper.dart';
import 'package:openelifba/domain/repository/memory/memory_repository.dart';

import 'package:openelifba/domain/repository/setting/setting_repository.dart';
import 'package:openelifba/domain/repository/user/user_repository.dart';

import '../../../di/service_locator.dart';
import '../../../domain/repository/category/category_repository.dart';
import '../../../domain/repository/exercises/exercises_repository.dart';
import '../../network/apis/category/category_api.dart';
import '../../network/apis/exercises/exercises_api.dart';
import '../../network/apis/memory/memory_api.dart';
import '../../network/apis/user/user_api.dart';
import '../../repository/category/category_repository_impl.dart';
import '../../repository/exercises/exercises_repository_impl.dart';
import '../../repository/memory/memory_repository_impl.dart';
import '../../repository/user/user_repository_impl.dart';

class RepositoryModule {
  static Future<void> configureRepositoryModuleInjection() async {
    // repository:--------------------------------------------------------------
    getIt.registerSingleton<SettingRepository>(SettingRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
    ));

    getIt.registerSingleton<UserRepository>(UserRepositoryImpl(
      getIt<SharedPreferenceHelper>(),
      getIt<UserApi>(),
    ));

    getIt.registerSingleton<CategoryRepository>(CategoryRepositoryImpl(
      getIt<CategoryApi>(),
    ));

    getIt.registerSingleton<ExercisesRepository>(ExercisesRepositoryImpl(
      getIt<ExercisesApi>(),
    ));

    getIt.registerSingleton<MemoryRepository>(MemoryRepositoryImpl(
      getIt<MemoryApi>(),
    ));
  }
}
