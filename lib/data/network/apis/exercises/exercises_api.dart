import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../domain/entity/exercise/exercise.dart';
import '../../constants/endpoints.dart';

part 'exercises_api.g.dart';

@RestApi(baseUrl: Endpoints.openElifba)
abstract class ExercisesApi {
  factory ExercisesApi(Dio dio, {String baseUrl}) = _ExercisesApi;

  @GET("/categories/{categoryId}/exercises/due")
  Future<List<Exercise>> getDueExercises(@Path("categoryId") String categoryId);
}
