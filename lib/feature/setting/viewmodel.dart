import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/helper/firestore_database_helper.dart';
import 'package:nutalk/helper/share_preference_helper.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:nutalk/service/auth_service.dart';
import 'package:nutalk/widget/icon.dart';

import '../../base/base_viewmodel.dart';

class SettingViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  SettingViewModel(BuildContext context) : _mainProvider = context.provide();

  int get oldTheme => _mainProvider.oldTheme;

  UserModel? get user => _mainProvider.user;

  int _index = 1;
  int get index => _index;

  List<IconName> themes = [
    IconName.theme1,
    IconName.theme2,
    IconName.theme3,
    IconName.theme4,
    IconName.theme5,
  ];

  List<CustomTheme> theme = [
    CustomTheme.theme1,
    CustomTheme.theme2,
    CustomTheme.theme3,
    CustomTheme.theme4,
    CustomTheme.theme5,
  ];

  void init() {
    _index = _mainProvider.theme.index + 1;
  }

  void setTheme(BuildContext context, {int? index}) {
    _index = index ?? 1;
    _mainProvider.setTheme(context, index ?? oldTheme, setTheme: false);
  }

  void save(BuildContext context) {
    _updateThemt(context);
    _mainProvider.setTheme(context, _index, setTheme: true);
  }

  bool selectedTHLanguage(BuildContext context) => context.locale.languageCode.toLowerCase() == 'th';

  Future<void> logout() async {
    busy = true;
    SharePreferenceHelper.saveUserLoggedInSharedPreference(false);
    await AuthService().signOut();
    busy = true;
  }

  void _updateThemt(BuildContext context) {
    DatabaseMethods().updateUserInfo(context, theme: _index);
  }
}
