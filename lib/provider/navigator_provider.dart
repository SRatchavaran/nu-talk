import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/constant/navigator.dart';
import 'package:nutalk/feature/main/screen.dart';
import 'package:nutalk/helper/navigator_helper_app.dart';

class NavigatorProvider extends ChangeNotifier {
  GoRouter customNavigatorHelperRouter = CustomNavigatorHelperApp.router;

  void pop() => customNavigatorHelperRouter.pop();

  void pushToHome() => customNavigatorHelperRouter.goNamed(
        NavigatorRouteNameConstans.homePath,
        extra: MainNavigatorBarArguments(initScreen: false),
      );

  void pushToSetting() => customNavigatorHelperRouter.pushNamed(NavigatorRouteNameConstans.settingPath);

  void pushToSetupProfile() => customNavigatorHelperRouter.pushNamed(NavigatorRouteNameConstans.setupProfilePath);

  void pushToSignup() => customNavigatorHelperRouter.goNamed(NavigatorRouteNameConstans.signupPath);

  void pushToSignin() => customNavigatorHelperRouter.pushNamed(NavigatorRouteNameConstans.loginPath);
}

extension NavigatorProviderContext on BuildContext {
  NavigatorProvider get navigatorProvider => provide<NavigatorProvider>(listen: false);
}
