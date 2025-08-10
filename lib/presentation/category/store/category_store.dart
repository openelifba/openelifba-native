import 'package:mobx/mobx.dart';
import 'package:openelifba/core/stores/error/error_store.dart';
import '../../../domain/entity/category/category.dart';
import '../../../domain/usecase/category/category_usecase.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  // constructor:---------------------------------------------------------------
  _CategoryStore(this._getCategoryUseCase, this.errorStore);

  // use cases:-----------------------------------------------------------------
  final GetCategoryUseCase _getCategoryUseCase;

  // stores:--------------------------------------------------------------------
  final ErrorStore errorStore;

  // store variables:-----------------------------------------------------------
  @observable
  ObservableList<Category> categories = ObservableList<Category>();

  @observable
  bool success = false;

  @observable
  ObservableFuture<void> fetchCategoriesFuture = ObservableFuture.value(null);

  @computed
  bool get loading => fetchCategoriesFuture.status == FutureStatus.pending;

  @computed
  List<Category> get activeCategories => categories
      .where((category) => category.statistic.status == "ACTIVE")
      .toList();

  @computed
  bool get hasActiveCategories => activeCategories.isNotEmpty;

  // actions:-------------------------------------------------------------------
  @action
  Future<void> getCategories() async {
    final future = _getCategoryUseCase.call(params: null);
    fetchCategoriesFuture = ObservableFuture(future);

    await future.then((categories) {
      this.categories.clear();
      this.categories.addAll(categories);
      success = true;
    }).catchError((error) {
      errorStore.errorMessage = "Failed to fetch categories";
    });
  }

  @action
  int findNextActiveIndex(int currentIndex,
      {int itemHeight = 220, double scrollPosition = 0}) {
    if (categories.isEmpty) return -1;

    // Find the current visible item index based on scroll position
    int visibleIndex = (scrollPosition / itemHeight).floor();
    int startIndex = currentIndex > -1 ? currentIndex + 1 : visibleIndex + 1;

    // Find the next active card starting from the specified index
    for (int i = startIndex; i < categories.length; i++) {
      if (categories[i].statistic.status == "ACTIVE") {
        return i;
      }
    }

    // If no active card found after current position, search from beginning
    for (int i = 0; i < startIndex; i++) {
      if (categories[i].statistic.status == "ACTIVE") {
        return i;
      }
    }

    return -1; // No active categories found
  }

  bool isActiveCategory(Category category) {
    return category.statistic.status == "ACTIVE";
  }
}
