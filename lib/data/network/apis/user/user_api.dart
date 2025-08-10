import '../../../../domain/entity/user/user.dart';
import '../../constants/endpoints.dart';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'user_api.g.dart';

@RestApi(baseUrl: Endpoints.auth)
abstract class UserApi {
  factory UserApi(Dio dio, {String baseUrl}) = _UserApi;

  @POST("/auth/register")
  Future<void> register(@Body() Map<String, dynamic> user);

  @POST("/auth/login")
  Future<User> login(@Body() Map<String, dynamic> credentials);
}
