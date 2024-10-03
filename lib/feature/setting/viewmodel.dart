import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:nutalk/widget/icon.dart';

import '../../base/base_viewmodel.dart';

class SettingViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  SettingViewModel(BuildContext context) : _mainProvider = context.provide();

  int get oldTheme => _mainProvider.oldTheme;

  int _index = 1;

  List<IconName> themes = [
    IconName.theme1,
    IconName.theme2,
    IconName.theme3,
    IconName.theme4,
    IconName.theme5,
  ];

  void init() {
    _index = _mainProvider.theme.index;
  }

  void setTheme(BuildContext context, {int? index}) {
    _index = index ?? 1;
    _mainProvider.setTheme(context, index ?? oldTheme, setTheme: false);
  }

  void save(BuildContext context) {
    _mainProvider.setTheme(context, _index, setTheme: true);
  }
}
