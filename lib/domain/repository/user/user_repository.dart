import 'dart:async';

import 'package:openelifba/domain/usecase/user/login_usecase.dart';

import '../../entity/user/user.dart';
import '../../usecase/user/register_usecase.dart';
import '../../usecase/user/save_login_in_status_usecase.dart';

abstract class UserRepository {
  Future<User?> login(LoginParams params);

  Future<void> register(RegisterParams params);

  Future<void> saveIsLoggedIn(SaveLoginStatusParams value);

  Future<bool> get isLoggedIn;
}
