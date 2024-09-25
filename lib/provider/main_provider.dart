import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';

enum CustomTheme { theme1, theme2, theme3, theme4, theme5 }

class MainProvider extends ChangeNotifier {
  Color primaryColorTheme = primaryTheme1;
  Color secondaryColorTheme = secondaryTheme1;

  int newTheme = 1;
  int oldTheme = 1;

  CustomTheme _theme = CustomTheme.theme1;
  CustomTheme get theme => _theme;

  void setTheme(int index, {bool setTheme = false}) {
    newTheme = index;
    if (setTheme) {
      oldTheme = newTheme;
    }
    switch (index) {
      case 1:
        _theme = CustomTheme.theme1;
        primaryColorTheme = primaryTheme1;
        secondaryColorTheme = secondaryTheme1;
        break;
      case 2:
        _theme = CustomTheme.theme2;
        primaryColorTheme = primaryTheme2;
        secondaryColorTheme = secondaryTheme2;
        break;
      case 3:
        _theme = CustomTheme.theme3;
        primaryColorTheme = primaryTheme3;
        secondaryColorTheme = secondaryTheme3;
        break;
      case 4:
        _theme = CustomTheme.theme4;
        primaryColorTheme = primaryTheme4;
        secondaryColorTheme = secondaryTheme4;
        break;
      case 5:
        _theme = CustomTheme.theme5;
        primaryColorTheme = primaryTheme5;
        secondaryColorTheme = secondaryTheme5;
        break;
    }
    notifyListeners();
  }
}
