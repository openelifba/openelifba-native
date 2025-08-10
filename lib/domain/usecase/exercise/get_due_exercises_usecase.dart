import 'package:openelifba/core/domain/usecase/use_case.dart';
import 'package:openelifba/domain/repository/exercises/exercises_repository.dart';

import '../../entity/exercise/exercise.dart';

class GetDueExercisesParams {
  final String categoryId;

  GetDueExercisesParams({required this.categoryId});
}

class GetDueExercisesUseCase
    extends UseCase<List<Exercise>, GetDueExercisesParams> {
  final ExercisesRepository _exercisesRepository;

  GetDueExercisesUseCase(this._exercisesRepository);

  @override
  Future<List<Exercise>> call({required GetDueExercisesParams params}) async {
    return await _exercisesRepository.getDueExercises(params.categoryId);
  }
}
