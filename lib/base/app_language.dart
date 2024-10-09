// Flutter Modules
import 'package:flutter/cupertino.dart';

// External Modules
import 'package:easy_localization/easy_localization.dart';

enum Language { thai, english }

// ignore_for_file: avoid_classes_with_only_static_members
extension LanguageExtension on Language {
  String get name {
    switch (this) {
      case Language.thai:
        return 'language.thai';
      case Language.english:
        return 'language.english';
      default:
        return '';
    }
  }

  // NUIcon get iconName {
  //   switch (this) {
  //     case Language.thai:
  //       return IconName.thai;
  //     case Language.english:
  //       return IconName.english;
  //     default:
  //       return IconName.blank;
  //   }
  // }

  String get code {
    switch (this) {
      case Language.thai:
        return 'th';
      default:
        return 'en';
    }
  }
}

extension LanguageContextExtension on BuildContext {
  void initLanguage() => ApplicationLanguage.initLanguage(this);

  void setApplicationLanguage(Language language) => ApplicationLanguage.setValue(this, language);
}

class ApplicationLanguage {
  static const _initialLanguage = Language.english;

  static Language _currentLanguage = _initialLanguage;

  static Language get current => _currentLanguage;

  static void initLanguage(BuildContext context) {
    var locale = context.locale;
    switch (locale.languageCode) {
      case 'th':
        _currentLanguage = Language.thai;
        break;
      default:
        _currentLanguage = Language.english;
        break;
    }
  }

  static Future<void> setValue(BuildContext context, Language language) async {
    _currentLanguage = language;
    var supportedLocales = context.supportedLocales;
    switch (language) {
      case Language.thai:
        await context.setLocale(supportedLocales[1]);
        break;
      default:
        await context.setLocale(supportedLocales[0]);
        break;
    }
  }
}
