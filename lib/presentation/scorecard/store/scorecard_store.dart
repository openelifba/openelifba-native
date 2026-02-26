import 'package:mobx/mobx.dart';
import 'package:openelifba/core/stores/error/error_store.dart';

import '../../../domain/entity/scorecard/score_entry.dart';
import '../../../domain/usecase/scorecard/get_scorecard_usecase.dart';
import '../../../domain/usecase/user/get_user_id_usecase.dart';

part 'scorecard_store.g.dart';

class ScorecardStore = _ScorecardStore with _$ScorecardStore;

abstract class _ScorecardStore with Store {
  // constructor:---------------------------------------------------------------
  _ScorecardStore(
    this._getScoreboardUseCase,
    this._getUserIdUseCase,
    this.errorStore,
  );

  // use cases:-----------------------------------------------------------------
  final GetScoreboardUseCase _getScoreboardUseCase;
  final GetUserIdUseCase _getUserIdUseCase;

  // stores:--------------------------------------------------------------------
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  @observable
  ObservableList<ScoreEntry> topScores = ObservableList<ScoreEntry>();

  @observable
  ScoreEntry? myRank;

  @observable
  String? currentUserId;

  @observable
  bool success = false;

  @observable
  ObservableFuture<void> fetchScoreboardFuture = ObservableFuture.value(null);

  @computed
  bool get loading => fetchScoreboardFuture.status == FutureStatus.pending;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> fetchScoreboard({int? limit}) async {
    currentUserId = await _getUserIdUseCase.call(params: null);

    if (currentUserId == null) {
      errorStore.errorMessage = "User not authenticated";
      return;
    }

    final future = _getScoreboardUseCase.call(
      params: GetScoreboardParams(userId: currentUserId!, limit: limit),
    );
    fetchScoreboardFuture = ObservableFuture(future);

    await future.then((response) {
      topScores.clear();
      topScores.addAll(response.topScores);
      myRank = response.myRank;
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = "Failed to fetch scoreboard";
    });
  }
}
