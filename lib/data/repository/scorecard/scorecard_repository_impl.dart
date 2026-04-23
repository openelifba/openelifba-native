import '../../../domain/entity/scorecard/scoreboard_response.dart';
import '../../../domain/repository/scorecard/scorecard_repository.dart';
import '../../network/apis/scorecard/scorecard_api.dart';

class ScoreboardRepositoryImpl implements ScoreboardRepository {
  final ScoreboardApi _scoreboardApi;

  ScoreboardRepositoryImpl(this._scoreboardApi);

  @override
  Future<ScoreboardResponse> getScoreboard(String userId, {int? limit}) async {
    return await _scoreboardApi.getScoreboard(userId, limit: limit);
  }
}
