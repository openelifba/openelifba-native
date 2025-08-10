import 'package:mobx/mobx.dart';
import 'package:openelifba/core/stores/error/error_store.dart';
import '../../../domain/entity/exercise/exercise.dart';
import '../../../domain/entity/memory/update_memory_request.dart';
import '../../../domain/usecase/exercise/get_due_exercises_usecase.dart';
import '../../../domain/usecase/memory/update_memory_usecase.dart';

part 'exercise_store.g.dart';

class ExerciseStore = _ExerciseStore with _$ExerciseStore;

abstract class _ExerciseStore with Store {
  // constructor:---------------------------------------------------------------
  _ExerciseStore(
      this._getDueExercisesUseCase, this._updateMemoryUseCase, this.errorStore);

  // use cases:-----------------------------------------------------------------
  final GetDueExercisesUseCase _getDueExercisesUseCase;
  final UpdateMemoryUseCase _updateMemoryUseCase;

  // stores:--------------------------------------------------------------------
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  @observable
  ObservableList<Exercise> dueExercises = ObservableList<Exercise>();

  @observable
  bool success = false;

  @observable
  ObservableFuture<void> fetchDueExercisesFuture = ObservableFuture.value(null);

  @observable
  int currentExerciseIndex = 0;

  @observable
  ObservableSet<int> completedExerciseIndexes = ObservableSet<int>();

  @observable
  int elapsedMilliseconds = 0;

  @observable
  bool isTimerRunning = false;

  @observable
  String categoryId = '';

  @computed
  bool get loading => fetchDueExercisesFuture.status == FutureStatus.pending;

  @computed
  bool get allExercisesCompleted =>
      completedExerciseIndexes.length == dueExercises.length;

  @computed
  double get responseTimeSeconds => elapsedMilliseconds / 1000.0;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getDueExercises(String categoryId) async {
    this.categoryId = categoryId;
    
    // Reset all state when loading exercises for a new category
    resetExercises();
    
    // Clear any previous error messages
    errorStore.setErrorMessage('');
    
    final future = _getDueExercisesUseCase.call(
      params: GetDueExercisesParams(categoryId: categoryId),
    );
    fetchDueExercisesFuture = ObservableFuture(future);

    await future.then((exercises) {
      dueExercises.clear();
      dueExercises.addAll(exercises);
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = "Failed to fetch due exercises";
    });
  }

  @action
  void setCurrentExerciseIndex(int index) {
    currentExerciseIndex = index;
  }

  @action
  void markExerciseCompleted(int index) {
    completedExerciseIndexes.add(index);
  }

  @action
  void resetExercises() {
    completedExerciseIndexes.clear();
    currentExerciseIndex = 0;
    elapsedMilliseconds = 0;
    isTimerRunning = false;
  }

  @action
  void startTimer() {
    isTimerRunning = true;
    elapsedMilliseconds = 0;
  }

  @action
  void stopTimer() {
    isTimerRunning = false;
  }

  @action
  void updateElapsedTime(int milliseconds) {
    elapsedMilliseconds = milliseconds;
  }

  @action
  void nextExercise() {
    if (currentExerciseIndex < dueExercises.length - 1) {
      currentExerciseIndex++;
    }
  }

  @action
  Future<void> updateMemory(
      String exerciseId, bool success, int responseTimeMillis) async {
    try {
      final request = UpdateMemoryRequest(
        categoryId: categoryId,
        exerciseId: exerciseId,
        success: success,
        responseTimeMillis: responseTimeMillis,
      );

      await _updateMemoryUseCase.call(params: request);
    } catch (error) {
      errorStore.errorMessage = "Failed to update memory: ${error.toString()}";
    }
  }
}
