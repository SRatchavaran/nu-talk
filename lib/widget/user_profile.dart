import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:nutalk/widget/icon.dart';

IconName profile(BuildContext context) {
  UserModel? user = context.provide<MainProvider>(listen: false).user;
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
