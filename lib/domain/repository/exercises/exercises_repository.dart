import '../../entity/exercise/exercise.dart';

abstract class ExercisesRepository {
  Future<List<Exercise>> getDueExercises(String categoryId);
}
