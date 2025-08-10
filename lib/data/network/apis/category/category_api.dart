import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../../../domain/entity/category/category.dart';
import '../../constants/endpoints.dart';

part 'category_api.g.dart';

@RestApi(baseUrl: Endpoints.openElifba)
abstract class CategoryApi {
  factory CategoryApi(Dio dio, {String baseUrl}) = _CategoryApi;

  @GET("/categories")
  Future<List<Category>> getCategories();
}
