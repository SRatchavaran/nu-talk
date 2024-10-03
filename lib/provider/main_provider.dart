import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/helper/share_preference_helper.dart';
import 'package:nutalk/model/user/user_model.dart';

enum CustomTheme { theme1, theme2, theme3, theme4, theme5 }

class MainProvider extends ChangeNotifier {
  Color primaryColorTheme = primaryTheme1;
  Color secondaryColorTheme = secondaryTheme1;

  int newTheme = 1;
  int oldTheme = 1;

  CustomTheme _theme = CustomTheme.theme1;
  CustomTheme get theme => _theme;

  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? str) => _user = str;

  bool isLogin = false;
  String email = '';

  Future init() async {
    isLogin = await SharePreferenceHelper.getUserLoggedInSharedPreference();
    email = await SharePreferenceHelper.getUserEmailSharedPreference();
  }

  void setTheme(BuildContext context, int index, {bool setTheme = false}) {
    newTheme = index;
    if (setTheme) {
      oldTheme = newTheme;
    }

    switch (index) {
      case 1:
        _theme = CustomTheme.theme1;
        break;
      case 2:
        _theme = CustomTheme.theme2;
        break;
      case 3:
        _theme = CustomTheme.theme3;
        break;
      case 4:
        _theme = CustomTheme.theme4;
        break;
      case 5:
        _theme = CustomTheme.theme5;
        break;
    }

    primaryColorTheme = primaryColor(context);
    secondaryColorTheme = secondaryColor(context);
    notifyListeners();
  }
}
