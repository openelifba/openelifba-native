import '../../../domain/entity/exercise/exercise.dart';
import '../../../domain/repository/exercises/exercises_repository.dart';
import '../../network/apis/exercises/exercises_api.dart';

class ExercisesRepositoryImpl implements ExercisesRepository {
  final ExercisesApi _exercisesApi;

  ExercisesRepositoryImpl(this._exercisesApi);

  @override
  Future<List<Exercise>> getDueExercises(String categoryId) async {
    return await _exercisesApi.getDueExercises(categoryId);
  }
}
