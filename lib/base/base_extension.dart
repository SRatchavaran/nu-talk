import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/widget/textstyle.dart';
import 'package:provider/provider.dart';

extension BuildContextProvider on BuildContext {
  T provide<T>({bool listen = true}) => Provider.of<T>(this, listen: listen);

  MediaQueryData get media => MediaQuery.of(this);

  Size get mediaSize => MediaQuery.of(this).size;

  void unFocusScope() {
    FocusScope.of(this).unfocus();
  }

  Object? get settingsArguments {
    var arguments = ModalRoute.of(this)?.settings.arguments;
    return arguments;
  }

  void showToast({
    required String msg,
  }) {
    Timer timer = Timer(const Duration(seconds: 5), () {});
    showDialog(
      context: this,
      builder: (builderContext) {
        timer = Timer(const Duration(seconds: 3), () {
          Navigator.of(builderContext).pop();
        });
        return AlertDialog(
          backgroundColor: Colors.transparent,
          content: Container(
            width: mediaSize.width,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            decoration: BoxDecoration(color: whiteColor, borderRadius: BorderRadius.circular(16)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info_outline, color: redColor, size: 50),
                SizedBox(height: 12),
                Text(
                  tr('common.alert'),
                  style: customTextStyle(context: this, typography: TextStyleTypography.headTextStyle),
                ),
                SizedBox(height: 4),
                Text(
                  tr(msg),
                  style: customTextStyle(context: this, typography: TextStyleTypography.simpleTextStyle),
                ),
              ],
            ),
          ),
        );
      },
    ).then((val) {
      if (timer.isActive) {
        timer.cancel();
      }
    });
  }
}
