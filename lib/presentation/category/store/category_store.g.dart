// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on _CategoryStore, Store {
  Computed<bool>? _$loadingComputed;

  @override
  bool get loading => (_$loadingComputed ??=
          Computed<bool>(() => super.loading, name: '_CategoryStore.loading'))
      .value;
  Computed<List<Category>>? _$activeCategoriesComputed;

  @override
  List<Category> get activeCategories => (_$activeCategoriesComputed ??=
          Computed<List<Category>>(() => super.activeCategories,
              name: '_CategoryStore.activeCategories'))
      .value;
  Computed<bool>? _$hasActiveCategoriesComputed;

  @override
  bool get hasActiveCategories => (_$hasActiveCategoriesComputed ??=
          Computed<bool>(() => super.hasActiveCategories,
              name: '_CategoryStore.hasActiveCategories'))
      .value;

  late final _$categoriesAtom =
      Atom(name: '_CategoryStore.categories', context: context);

  @override
  ObservableList<Category> get categories {
    _$categoriesAtom.reportRead();
    return super.categories;
  }

  @override
  set categories(ObservableList<Category> value) {
    _$categoriesAtom.reportWrite(value, super.categories, () {
      super.categories = value;
    });
  }

  late final _$successAtom =
      Atom(name: '_CategoryStore.success', context: context);

  @override
  bool get success {
    _$successAtom.reportRead();
    return super.success;
  }

  @override
  set success(bool value) {
    _$successAtom.reportWrite(value, super.success, () {
      super.success = value;
    });
  }

  late final _$fetchCategoriesFutureAtom =
      Atom(name: '_CategoryStore.fetchCategoriesFuture', context: context);

  @override
  ObservableFuture<void> get fetchCategoriesFuture {
    _$fetchCategoriesFutureAtom.reportRead();
    return super.fetchCategoriesFuture;
  }

  @override
  set fetchCategoriesFuture(ObservableFuture<void> value) {
    _$fetchCategoriesFutureAtom.reportWrite(value, super.fetchCategoriesFuture,
        () {
      super.fetchCategoriesFuture = value;
    });
  }

  late final _$getCategoriesAsyncAction =
      AsyncAction('_CategoryStore.getCategories', context: context);

  @override
  Future<void> getCategories() {
    return _$getCategoriesAsyncAction.run(() => super.getCategories());
  }

  late final _$_CategoryStoreActionController =
      ActionController(name: '_CategoryStore', context: context);

  @override
  int findNextActiveIndex(int currentIndex,
      {int itemHeight = 220, double scrollPosition = 0}) {
    final _$actionInfo = _$_CategoryStoreActionController.startAction(
        name: '_CategoryStore.findNextActiveIndex');
    try {
      return super.findNextActiveIndex(currentIndex,
          itemHeight: itemHeight, scrollPosition: scrollPosition);
    } finally {
      _$_CategoryStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
categories: ${categories},
success: ${success},
fetchCategoriesFuture: ${fetchCategoriesFuture},
loading: ${loading},
activeCategories: ${activeCategories},
hasActiveCategories: ${hasActiveCategories}
    ''';
  }
}
