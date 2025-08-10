import 'package:openelifba/domain/entity/category/category.dart';

import '../../../domain/repository/category/category_repository.dart';
import '../../network/apis/category/category_api.dart';

class CategoryRepositoryImpl extends CategoryRepository {
  final CategoryApi _categoryApi;

  CategoryRepositoryImpl(this._categoryApi);

  @override
  Future<List<Category>> getCategories() async {
    return await _categoryApi.getCategories().then((categories) {
      return categories;
    }).catchError((error) => throw error);
  }
}
