import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/feature/setting/viewmodel.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/icon.dart';
import 'package:nutalk/widget/textstyle.dart';

import '../../base/base_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<SettingViewModel>(
      model: SettingViewModel(context),
      onModelReady: (model) {
        model.init();
      },
      onPageResume: (model) {},
      builder: (context, model, _) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: model.primaryColorTheme,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                    onTap: () {
                      model.setTheme();
                      context.navigatorProvider.pop();
                    },
                    child: Text(
                      "Cancel",
                      style: customTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                    )),
                Expanded(
                  child: Center(
                    child: Text(
                      tr('setting.title'),
                      style: customTextStyle(
                        context: context,
                        typography: TextStyleTypography.mainTextStyle,
                        fontSize: TextStyleSize.s24
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    model.save();
                    context.navigatorProvider.pop();
                  },
                  child: Text(
                    "Save",
                    style: customTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                  ),
                )
              ],
            ),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: Container(
            color: model.secondaryColorTheme,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Form(
              // key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Constants.myType != 'user' ? null : _selectImage();
                          },
                          child: const CustomIcon(
                            IconName.profileUser1,
                            height: 100,
                          ),
                        ),
                        // Constants.myType != 'user' ? Container() : Text('change picture'),
                        const SizedBox(height: 24),
                        Text(
                          tr('setting.name'),
                          style: customTextStyle(
                            context: context,
                            typography: TextStyleTypography.headTextStyle,
                            fontSize: TextStyleSize.s24,
                          ),
                        ),
                        Text(
                          tr('setting.age'),
                          style: customTextStyle(
                            context: context,
                            typography: TextStyleTypography.headTextStyle,
                            fontSize: TextStyleSize.s19,
                          ),
                        ),
                        Text(
                          tr('setting.gender'),
                          style: customTextStyle(
                            context: context,
                            typography: TextStyleTypography.headTextStyle,
                            fontSize: TextStyleSize.s19,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        tr('setting.theme'),
                        style: customTextStyle(
                          context: context,
                          typography: TextStyleTypography.headTextStyle,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        tr('setting.select_theme'),
                        style: customTextStyle(
                          context: context,
                          typography: TextStyleTypography.simpleTextStyle,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Container(
                        width: context.mediaSize.width,
                        height: 50,
                        padding: EdgeInsets.symmetric(horizontal: context.mediaSize.width * 0.1),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: model.themes
                              .asMap()
                              .map((index, element) => MapEntry(
                                    index,
                                    GestureDetector(
                                      onTap: () {
                                        model.setTheme(index: index + 1);
                                      },
                                      child: CustomIcon(model.themes[index]),
                                    ),
                                  ))
                              .values
                              .toList(),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      // HelperFunctions.saveUserLoggedInSharedPreference(false);
                      // authService.signOut();
                      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Authenticate()));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Text(
                        tr('setting.logout'),
                        style: customTextStyle(context: context),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
