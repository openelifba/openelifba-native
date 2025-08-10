import 'dart:async';

import 'package:openelifba/data/network/apis/user/user_api.dart';
import 'package:openelifba/domain/repository/user/user_repository.dart';
import 'package:openelifba/data/sharedpref/shared_preference_helper.dart';
import 'package:openelifba/utils/logger/app_logger.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';
import '../../../domain/usecase/user/register_usecase.dart';
import '../../../domain/usecase/user/save_login_in_status_usecase.dart';

class UserRepositoryImpl extends UserRepository {
  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // api objects
  final UserApi _userApi;

  // constructor
  UserRepositoryImpl(this._sharedPrefsHelper, this._userApi);

  // Login:---------------------------------------------------------------------
  @override
  Future<User?> login(LoginParams params) async {
    try {
      final user = await _userApi.login({
        "email": params.email,
        "password": params.password,
      });
      _sharedPrefsHelper.saveAuthToken(user.token);
      return user;
    } catch (error) {
      _sharedPrefsHelper.removeAuthToken();
      AppLogger.error('Login failed', 'UserRepository', error);
      rethrow;
    }
  }

  // Register:---------------------------------------------------------------------
  @override
  Future<void> register(RegisterParams params) async {
    try {
      _sharedPrefsHelper.removeAuthToken();
      await _userApi.register({
        "email": params.email,
        "password": params.password,
      });
    } catch (error) {
      rethrow;
    }
  }

  @override
  Future<void> saveIsLoggedIn(SaveLoginStatusParams value) {
    return _sharedPrefsHelper.saveIsLoggedIn(value.isLoggedIn);
  }

  @override
  Future<bool> get isLoggedIn => _sharedPrefsHelper.isLoggedIn;
}
