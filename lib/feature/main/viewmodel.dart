import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/provider/main_provider.dart';

import '../../base/base_viewmodel.dart';

enum CustomTheme { theme1, theme2, theme3, theme4, theme5 }

class MainViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  MainViewModel(BuildContext context) : _mainProvider = context.provide();

  Color get primaryColorTheme => _mainProvider.primaryColorTheme;

  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  set currentIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
    }
  }
}
