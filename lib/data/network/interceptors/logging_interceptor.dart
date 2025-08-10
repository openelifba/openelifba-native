import 'package:dio/dio.dart';
import 'package:openelifba/utils/logger/app_logger.dart';

/// Interceptor that logs HTTP requests and responses for debugging
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    AppLogger.network('REQUEST[${options.method}] => PATH: ${options.path}', options.path);
    if (options.data != null) {
      AppLogger.debug('Request data: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    AppLogger.network(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
        response.requestOptions.path);
    AppLogger.debug('Response data: ${response.data}');
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    AppLogger.error(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
        'LoggingInterceptor',
        err);
    handler.next(err);
  }
}
