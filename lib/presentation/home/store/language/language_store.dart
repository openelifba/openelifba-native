import 'package:openelifba/core/stores/error/error_store.dart';
import 'package:openelifba/domain/entity/language/Language.dart';
import 'package:openelifba/domain/repository/setting/setting_repository.dart';
import 'package:mobx/mobx.dart';

part 'language_store.g.dart';

class LanguageStore = _LanguageStore with _$LanguageStore;

abstract class _LanguageStore with Store {
  // repository instance
  final SettingRepository _repository;

  // store for handling errors
  final ErrorStore errorStore;

  // supported languages
  List<Language> supportedLanguages = [
    Language(code: 'TR', locale: 'tr', language: 'Turkish'),
    Language(code: 'US', locale: 'en', language: 'English'),
    Language(code: 'DE', locale: 'de', language: 'German'),
    Language(code: 'ES', locale: 'es', language: 'Spanish'),
    Language(code: 'DK', locale: 'da', language: 'Danish'),
    Language(code: 'FR', locale: 'fr', language: 'French'),
    Language(code: 'CN', locale: 'zh', language: 'Chinese'),
    Language(code: 'IN', locale: 'hi', language: 'Hindi'),
    Language(code: 'BR', locale: 'pt', language: 'Portuguese'),
    Language(code: 'RU', locale: 'ru', language: 'Russian'),
    Language(code: 'JP', locale: 'ja', language: 'Japanese'),
    Language(code: 'IT', locale: 'it', language: 'Italian'),
  ];

  // constructor:---------------------------------------------------------------
  _LanguageStore(this._repository, this.errorStore) {
    init();
  }

  // store variables:-----------------------------------------------------------
  @observable
  String _locale = "en";

  @computed
  String get locale => _locale;

  // actions:-------------------------------------------------------------------
  @action
  void changeLanguage(String value) {
    _locale = value;
    _repository.changeLanguage(value).then((_) {
      // write additional logic here
    });
  }

  @action
  String getCode() {
    String? code;

    switch (_locale) {
      case 'en':
        code = 'US';
        break;
      case 'de':
        code = 'DE';
        break;
      case 'tr':
        code = 'TR';
        break;
      case 'es':
        code = 'ES';
        break;
      case 'da':
        code = 'DK';
        break;
      case 'fr':
        code = 'FR';
        break;
      case 'zh':
        code = 'CN';
        break;
      case 'hi':
        code = 'IN';
        break;
      case 'pt':
        code = 'BR';
        break;
      case 'ru':
        code = 'RU';
        break;
      case 'ja':
        code = 'JP';
        break;
      case 'it':
        code = 'IT';
        break;
      default:
        code = 'US';
    }

    return code;
  }

  @action
  String? getLanguage() {
    return supportedLanguages[supportedLanguages
            .indexWhere((language) => language.locale == _locale)]
        .language;
  }

  // general:-------------------------------------------------------------------
  void init() async {
    // getting current language from shared preference
    if (_repository.currentLanguage != null) {
      _locale = _repository.currentLanguage!;
    }
  }

  // dispose:-------------------------------------------------------------------
  dispose() {}
}
