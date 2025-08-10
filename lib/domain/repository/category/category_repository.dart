import '../../entity/category/category.dart';

abstract class CategoryRepository {
  Future<List<Category>> getCategories();
}
