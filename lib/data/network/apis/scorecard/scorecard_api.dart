import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../domain/entity/scorecard/scoreboard_response.dart';
import '../../constants/endpoints.dart';

part 'scorecard_api.g.dart';

@RestApi(baseUrl: Endpoints.openElifba)
abstract class ScoreboardApi {
  factory ScoreboardApi(Dio dio, {String baseUrl}) = _ScoreboardApi;

  @GET("/scoreboard")
  Future<ScoreboardResponse> getScoreboard(
    @Header("x-user-id") String userId, {
    @Query("limit") int? limit,
  });
}
