// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ExerciseStore on _ExerciseStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_ExerciseStore.loading'))
      .value;
  Computed<bool>? _$allExercisesCompletedComputed;

  @override
  bool get allExercisesCompleted => (_$allExercisesCompletedComputed ??=
          Computed<bool>(() => super.allExercisesCompleted,
              name: '_ExerciseStore.allExercisesCompleted'))
      .value;
  Computed<double>? _$responseTimeSecondsComputed;

  @override
  double get responseTimeSeconds => (_$responseTimeSecondsComputed ??=
          Computed<double>(() => super.responseTimeSeconds,
              name: '_ExerciseStore.responseTimeSeconds'))
      .value;

  late final _$dueExercisesAtom =
      Atom(name: '_ExerciseStore.dueExercises', context: context);

  @override
  ObservableList<Exercise> get dueExercises {
    _$dueExercisesAtom.reportRead();
    return super.dueExercises;
  }

  @override
  set dueExercises(ObservableList<Exercise> value) {
    _$dueExercisesAtom.reportWrite(value, super.dueExercises, () {
      super.dueExercises = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_ExerciseStore.success', context: context);

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

  late final _$fetchDueExercisesFutureAtom =
      Atom(name: '_ExerciseStore.fetchDueExercisesFuture', context: context);

  @override
  ObservableFuture<void> get fetchDueExercisesFuture {
    _$fetchDueExercisesFutureAtom.reportRead();
    return super.fetchDueExercisesFuture;
  }

  @override
  set fetchDueExercisesFuture(ObservableFuture<void> value) {
    _$fetchDueExercisesFutureAtom
        .reportWrite(value, super.fetchDueExercisesFuture, () {
      super.fetchDueExercisesFuture = value;
    });
  }

  late final _$currentExerciseIndexAtom =
      Atom(name: '_ExerciseStore.currentExerciseIndex', context: context);

  @override
  int get currentExerciseIndex {
    _$currentExerciseIndexAtom.reportRead();
    return super.currentExerciseIndex;
  }

  @override
  set currentExerciseIndex(int value) {
    _$currentExerciseIndexAtom.reportWrite(value, super.currentExerciseIndex,
        () {
      super.currentExerciseIndex = value;
    });
  }

  late final _$completedExerciseIndexesAtom =
      Atom(name: '_ExerciseStore.completedExerciseIndexes', context: context);

  @override
  ObservableSet<int> get completedExerciseIndexes {
    _$completedExerciseIndexesAtom.reportRead();
    return super.completedExerciseIndexes;
  }

  @override
  set completedExerciseIndexes(ObservableSet<int> value) {
    _$completedExerciseIndexesAtom
        .reportWrite(value, super.completedExerciseIndexes, () {
      super.completedExerciseIndexes = value;
    });
  }

  late final _$elapsedMillisecondsAtom =
      Atom(name: '_ExerciseStore.elapsedMilliseconds', context: context);

  @override
  int get elapsedMilliseconds {
    _$elapsedMillisecondsAtom.reportRead();
    return super.elapsedMilliseconds;
  }

  @override
  set elapsedMilliseconds(int value) {
    _$elapsedMillisecondsAtom.reportWrite(value, super.elapsedMilliseconds, () {
      super.elapsedMilliseconds = value;
    });
  }

  late final _$isTimerRunningAtom =
      Atom(name: '_ExerciseStore.isTimerRunning', context: context);

  @override
  bool get isTimerRunning {
    _$isTimerRunningAtom.reportRead();
    return super.isTimerRunning;
  }

  @override
  set isTimerRunning(bool value) {
    _$isTimerRunningAtom.reportWrite(value, super.isTimerRunning, () {
      super.isTimerRunning = value;
    });
  }

  late final _$categoryIdAtom =
      Atom(name: '_ExerciseStore.categoryId', context: context);

  @override
  String get categoryId {
    _$categoryIdAtom.reportRead();
    return super.categoryId;
  }

  @override
  set categoryId(String value) {
    _$categoryIdAtom.reportWrite(value, super.categoryId, () {
      super.categoryId = value;
    });
  }

  late final _$getDueExercisesAsyncAction =
      AsyncAction('_ExerciseStore.getDueExercises', context: context);

  @override
  Future<void> getDueExercises(String categoryId) {
    return _$getDueExercisesAsyncAction
        .run(() => super.getDueExercises(categoryId));
  }

  late final _$updateMemoryAsyncAction =
      AsyncAction('_ExerciseStore.updateMemory', context: context);

  @override
  Future<void> updateMemory(
      String exerciseId, bool success, int responseTimeMillis) {
    return _$updateMemoryAsyncAction
        .run(() => super.updateMemory(exerciseId, success, responseTimeMillis));
  }

  late final _$_ExerciseStoreActionController =
      ActionController(name: '_ExerciseStore', context: context);

  @override
  void setCurrentExerciseIndex(int index) {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.setCurrentExerciseIndex');
    try {
      return super.setCurrentExerciseIndex(index);
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void markExerciseCompleted(int index) {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.markExerciseCompleted');
    try {
      return super.markExerciseCompleted(index);
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetExercises() {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.resetExercises');
    try {
      return super.resetExercises();
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void startTimer() {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.startTimer');
    try {
      return super.startTimer();
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void stopTimer() {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.stopTimer');
    try {
      return super.stopTimer();
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void updateElapsedTime(int milliseconds) {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.updateElapsedTime');
    try {
      return super.updateElapsedTime(milliseconds);
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void nextExercise() {
    final _$actionInfo = _$_ExerciseStoreActionController.startAction(
        name: '_ExerciseStore.nextExercise');
    try {
      return super.nextExercise();
    } finally {
      _$_ExerciseStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
dueExercises: ${dueExercises},
success: ${success},
fetchDueExercisesFuture: ${fetchDueExercisesFuture},
currentExerciseIndex: ${currentExerciseIndex},
completedExerciseIndexes: ${completedExerciseIndexes},
elapsedMilliseconds: ${elapsedMilliseconds},
isTimerRunning: ${isTimerRunning},
categoryId: ${categoryId},
loading: ${loading},
allExercisesCompleted: ${allExercisesCompleted},
responseTimeSeconds: ${responseTimeSeconds}
    ''';
  }
}
