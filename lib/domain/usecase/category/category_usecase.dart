import 'package:openelifba/core/domain/usecase/use_case.dart';
import 'package:openelifba/domain/repository/category/category_repository.dart';

import '../../entity/category/category.dart';

class GetCategoryUseCase extends UseCase<List<Category>, void> {
  final CategoryRepository _categoryRepository;

  GetCategoryUseCase(this._categoryRepository);

  @override
  Future<List<Category>> call({required void params}) async {
    return await _categoryRepository.getCategories();
  }
}
