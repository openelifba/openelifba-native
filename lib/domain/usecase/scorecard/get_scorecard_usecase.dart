import '../../../core/domain/usecase/use_case.dart';
import '../../entity/scorecard/scoreboard_response.dart';
import '../../repository/scorecard/scorecard_repository.dart';

class GetScoreboardParams {
  final String userId;
  final int? limit;

  GetScoreboardParams({required this.userId, this.limit});
}

class GetScoreboardUseCase
    extends UseCase<ScoreboardResponse, GetScoreboardParams> {
  final ScoreboardRepository _scoreboardRepository;

  GetScoreboardUseCase(this._scoreboardRepository);

  @override
  Future<ScoreboardResponse> call(
      {required GetScoreboardParams params}) async {
    return await _scoreboardRepository.getScoreboard(
      params.userId,
      limit: params.limit,
    );
  }
}
