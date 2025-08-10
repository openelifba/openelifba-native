import 'package:dio/dio.dart';
import 'package:openelifba/presentation/auth/store/user_store.dart';
import 'package:openelifba/data/sharedpref/shared_preference_helper.dart';
import 'package:openelifba/di/service_locator.dart';
import 'package:openelifba/utils/logger/app_logger.dart';

class AuthRetryInterceptor extends Interceptor {
  final SharedPreferenceHelper _sharedPrefsHelper;
  bool _isRefreshing = false;

  AuthRetryInterceptor(this._sharedPrefsHelper);

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Check if the error is a 401 Unauthorized response
    if (err.response?.statusCode == 401) {
      // Only attempt auto-login once to avoid infinite loops
      if (!_isRefreshing) {
        _isRefreshing = true;

        try {
          AppLogger.info('Session expired (401), attempting auto-login...', 'AuthRetryInterceptor');

          // Get UserStore from service locator (if available)
          try {
            final userStore = getIt<UserStore>();

            // Attempt auto-login with device ID
            await userStore.autoLoginWithDeviceId();

            // If auto-login was successful, retry the original request
            if (userStore.isLoggedIn) {
              AppLogger.info('Auto-login successful, retrying original request', 'AuthRetryInterceptor');

              // Retry the original request with the new authentication
              final response = await _retry(err.requestOptions);
              _isRefreshing = false;
              return handler.resolve(response);
            } else {
              AppLogger.warning('Auto-login failed, user needs to login manually', 'AuthRetryInterceptor');
            }
          } catch (serviceLocatorError) {
            AppLogger.error(
                'UserStore not available in service locator', 'AuthRetryInterceptor', serviceLocatorError);
          }
        } catch (e) {
          AppLogger.error('Auto-login error', 'AuthRetryInterceptor', e);
        } finally {
          _isRefreshing = false;
        }
      }
    }

    // If not a 401 or auto-login failed, pass the error through
    super.onError(err, handler);
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    // Create a new Dio instance to avoid interceptor loops
    final dio = Dio();

    // Copy base options from original request
    dio.options.baseUrl = requestOptions.baseUrl;
    dio.options.headers = Map<String, dynamic>.from(requestOptions.headers);

    // Add the new auth token if available
    final authToken = await _sharedPrefsHelper.authToken;
    if (authToken != null && authToken.isNotEmpty) {
      dio.options.headers['Authorization'] = 'Bearer $authToken';
    }

    return await dio.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
        responseType: requestOptions.responseType,
        contentType: requestOptions.contentType,
      ),
    );
  }
}
