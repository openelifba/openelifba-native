import 'package:mobx/mobx.dart';

part 'error_store.g.dart';

class ErrorStore = ErrorStoreBase with _$ErrorStore;

abstract class ErrorStoreBase with Store {
  // disposers
  late List<ReactionDisposer> _disposers;

  // constructor:---------------------------------------------------------------
  ErrorStoreBase() {
    _disposers = [
      reaction((_) => errorMessage, reset, delay: 500),
    ];
  }

  // store variables:-----------------------------------------------------------
  @observable
  String errorMessage = '';

  // actions:-------------------------------------------------------------------
  @action
  void setErrorMessage(String message) {
    errorMessage = message;
  }

  @action
  void reset(String value) {
    errorMessage = '';
  }

  // dispose:-------------------------------------------------------------------
  @action
  dispose() {
    for (final disposer in _disposers) {
      disposer();
    }
  }
}
