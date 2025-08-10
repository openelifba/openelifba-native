import 'package:dio/dio.dart';

/// Interceptor that adds authentication headers to requests
class AuthInterceptor extends Interceptor {
  final Future<String?> Function() accessToken;

  AuthInterceptor({required this.accessToken});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await accessToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }
}
