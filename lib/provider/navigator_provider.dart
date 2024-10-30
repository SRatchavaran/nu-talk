import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/constant/navigator.dart';
import 'package:nutalk/feature/kratoo/detail/screen.dart';
import 'package:nutalk/feature/main/screen.dart';
import 'package:nutalk/helper/navigator_helper_app.dart';
import 'package:nutalk/model/community/post_community_model.dart';

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

  void pushToCreatePost() => customNavigatorHelperRouter.pushNamed(NavigatorRouteNameConstans.createPostPath);

  void pushToDetailPost({required PostCommunityModel post}) => customNavigatorHelperRouter
      .pushNamed(NavigatorRouteNameConstans.detailPostPath, extra: DetailPostArguments(detail: post));
}

extension NavigatorProviderContext on BuildContext {
  NavigatorProvider get navigatorProvider => provide<NavigatorProvider>(listen: false);
}
