import 'package:openelifba/core/stores/error/error_store.dart';
import 'package:openelifba/core/stores/form/form_store.dart';
import 'package:openelifba/domain/usecase/device/get_device_id_usecase.dart';
import 'package:openelifba/domain/usecase/user/is_logged_in_usecase.dart';
import 'package:openelifba/domain/usecase/user/register_usecase.dart';
import 'package:openelifba/domain/usecase/user/save_login_in_status_usecase.dart';
import 'package:openelifba/utils/logger/app_logger.dart';
import 'package:mobx/mobx.dart';

import '../../../domain/entity/user/user.dart';
import '../../../domain/usecase/user/login_usecase.dart';

part 'user_store.g.dart';

class UserStore = _UserStore with _$UserStore;

abstract class _UserStore with Store {
  // constructor:---------------------------------------------------------------
  _UserStore(
    this._isLoggedInUseCase,
    this._saveLoginStatusUseCase,
    this._loginUseCase,
    this._registerUseCase,
    this._getDeviceIdUseCase,
    this.formErrorStore,
    this.errorStore,
  ) {
    // setting up disposers
    _setupDisposers();

    // checking if user is logged in
    _isLoggedInUseCase.call(params: null).then((value) async {
      isLoggedIn = value;
    });
  }

  // use cases:-----------------------------------------------------------------
  final IsLoggedInUseCase _isLoggedInUseCase;
  final SaveLoginStatusUseCase _saveLoginStatusUseCase;
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final GetDeviceIdUseCase _getDeviceIdUseCase;

  // stores:--------------------------------------------------------------------
  // for handling form errors
  final FormErrorStore formErrorStore;

  // store for handling error messages
  final ErrorStore errorStore;

  // disposers:-----------------------------------------------------------------
  late List<ReactionDisposer> _disposers;

  void _setupDisposers() {
    _disposers = [
      reaction((_) => success, (_) => success = false, delay: 200),
    ];
  }

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<User?> emptyLoginResponse =
      ObservableFuture.value(null);

  // store variables:-----------------------------------------------------------
  @observable
  bool isLoggedIn = false;

  @observable
  bool success = false;

  @observable
  ObservableFuture<User?> loginFuture = emptyLoginResponse;

  @computed
  bool get isLoading => loginFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future login(String email, String password) async {
    final LoginParams loginParams =
        LoginParams(email: email, password: password);
    final future = _loginUseCase.call(params: loginParams);
    loginFuture = ObservableFuture(future);

    await future.then((value) async {
      if (value != null) {
        AppLogger.debug("Login successful, token received: ${value.token}", "UserStore");
        await _saveLoginStatusUseCase.call(
            params: SaveLoginStatusParams(isLoggedIn: true, user: value));
        isLoggedIn = true;
        success = true;
      }
    }).catchError((e) {
      AppLogger.error("Login failed", "UserStore", e);
      isLoggedIn = false;
      success = false;
      throw e;
    });
  }

  @action
  Future register(String email, String password) async {
    final RegisterParams loginParams =
        RegisterParams(email: email, password: password);
    final future = _registerUseCase.call(params: loginParams);

    await future.then((value) async {
      // Do nothing
    }).catchError((e) {
      // Do nothing
    });
  }

  @action
  Future autoLoginWithDeviceId() async {
    try {
      final future = _getDeviceIdUseCase.call(params: null);
      await future.then((value) async {
        AppLogger.debug("Auto login with device ID called", "UserStore");
        var email = "$value@wordiam.com";

        // First register, then login - both awaited properly
        await register(email, value);
        await login(email, value);
      });
    } catch (e) {
      AppLogger.error("Auto login error", "UserStore", e);
      rethrow;
    }
  }

  logout() async {
    isLoggedIn = false;
    await _saveLoginStatusUseCase.call(
        params: SaveLoginStatusParams(isLoggedIn: isLoggedIn, user: null));
  }

  // general methods:-----------------------------------------------------------
  void dispose() {
    for (final d in _disposers) {
      d();
    }
  }
}
