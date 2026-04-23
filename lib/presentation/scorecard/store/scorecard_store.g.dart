// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scorecard_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ScorecardStore on _ScorecardStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ScorecardStore.loading'))
      .value;

  late final _$topScoresAtom =
      Atom(name: '_ScorecardStore.topScores', context: context);

  @override
  ObservableList<ScoreEntry> get topScores {
    _$topScoresAtom.reportRead();
    return super.topScores;
  }

  @override
  set topScores(ObservableList<ScoreEntry> value) {
    _$topScoresAtom.reportWrite(value, super.topScores, () {
      super.topScores = value;
    });
  }

  late final _$myRankAtom =
      Atom(name: '_ScorecardStore.myRank', context: context);

  @override
  ScoreEntry? get myRank {
    _$myRankAtom.reportRead();
    return super.myRank;
  }

  @override
  set myRank(ScoreEntry? value) {
    _$myRankAtom.reportWrite(value, super.myRank, () {
      super.myRank = value;
    });
  }

  late final _$currentUserIdAtom =
      Atom(name: '_ScorecardStore.currentUserId', context: context);

  @override
  String? get currentUserId {
    _$currentUserIdAtom.reportRead();
    return super.currentUserId;
  }

  @override
  set currentUserId(String? value) {
    _$currentUserIdAtom.reportWrite(value, super.currentUserId, () {
      super.currentUserId = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ScorecardStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$fetchScoreboardFutureAtom =
      Atom(name: '_ScorecardStore.fetchScoreboardFuture', context: context);

  @override
  ObservableFuture<void> get fetchScoreboardFuture {
    _$fetchScoreboardFutureAtom.reportRead();
    return super.fetchScoreboardFuture;
  }

  @override
  set fetchScoreboardFuture(ObservableFuture<void> value) {
    _$fetchScoreboardFutureAtom.reportWrite(
        value, super.fetchScoreboardFuture, () {
      super.fetchScoreboardFuture = value;
    });
  }

  late final _$fetchScoreboardAsyncAction =
      AsyncAction('_ScorecardStore.fetchScoreboard', context: context);

  @override
  Future<void> fetchScoreboard({int? limit}) {
    return _$fetchScoreboardAsyncAction
        .run(() => super.fetchScoreboard(limit: limit));
  }

  @override
  String toString() {
    return '''
topScores: ${topScores},
myRank: ${myRank},
currentUserId: ${currentUserId},
success: ${success},
fetchScoreboardFuture: ${fetchScoreboardFuture},
loading: ${loading}
    ''';
  }
}
