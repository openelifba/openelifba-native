import 'dart:async';
import 'dart:convert';

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
      final extractedUserId = _extractUserIdFromToken(user.token);
      if (extractedUserId != null) {
        _sharedPrefsHelper.saveUserId(extractedUserId);
      }
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

  @override
  String? get userId => _sharedPrefsHelper.userId;

  // Decodes the JWT payload and extracts the 'sub' claim as the user ID.
  String? _extractUserIdFromToken(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return null;

      String payload = parts[1]
          .replaceAll('-', '+')
          .replaceAll('_', '/');
      switch (payload.length % 4) {
        case 2:
          payload += '==';
          break;
        case 3:
          payload += '=';
          break;
      }

      final decodedBytes = base64Decode(payload);
      final decodedString = utf8.decode(decodedBytes);
      final claims = jsonDecode(decodedString) as Map<String, dynamic>;
      return claims['sub']?.toString();
    } catch (e) {
      AppLogger.error('Failed to extract user ID from token', 'UserRepository', e);
      return null;
    }
  }
}
