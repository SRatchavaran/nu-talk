import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/helper/firestore_database_helper.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:nutalk/widget/icon.dart';

import '../../base/base_viewmodel.dart';

enum CustomTheme { theme1, theme2, theme3, theme4, theme5 }

class MainViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  MainViewModel(BuildContext context) : _mainProvider = context.provide();

  Color get primaryColorTheme => _mainProvider.primaryColorTheme;

  UserModel? _user;
  UserModel? get user => _user;
  set user(UserModel? model) {
    _user = model;
    _mainProvider.user = _user;
  }

  IconName profile() {
    switch (user?.image) {
      case 1:
        return IconName.profileUser1;
      case 2:
        return IconName.profileUser2;
      case 3:
        return IconName.profileUser3;
      case 4:
        return IconName.profileUser4;
      case 5:
        return IconName.profileUser5;
      case 6:
        return IconName.profileUser6;
      default:
        return IconName.profileUser1;
    }
  }

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
    }
  }

  String email = '';
  bool get isLogin => _mainProvider.isLogin;

  Future<void> init({required bool init}) async {
    if (init) busy = true;
    await _mainProvider.init();
    email = _mainProvider.email;

    if (_mainProvider.isLogin) {
      user = await DatabaseMethods().getUserByEmail(_mainProvider.email);
    }
    await Future.delayed(
      Duration(seconds: 2),
      () async {},
    );

    busy = false;
  }
}
