import '../../entity/scorecard/scoreboard_response.dart';

abstract class ScoreboardRepository {
  Future<ScoreboardResponse> getScoreboard(String userId, {int? limit});
}
