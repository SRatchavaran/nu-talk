import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/base/app_language.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/setting/viewmodel.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/button.dart';
import 'package:nutalk/widget/icon.dart';
import 'package:nutalk/widget/loading_screen.dart';
import 'package:nutalk/widget/text.dart';
import 'package:nutalk/widget/textstyle.dart';
import 'package:nutalk/widget/user_profile.dart';

import '../../base/base_widget.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  PreferredSizeWidget _appbar(BuildContext context, {required SettingViewModel model}) => AppBar(
        backgroundColor: primaryColor(context, selected: model.theme[model.index - 1]),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            NUButton(
              onTap: () {
                model.setTheme(context);
                context.navigatorProvider.pop();
              },
              child: NUText(
                text: 'common.cancle',
                textStyle: nuTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  tr('setting.title'),
                  style: nuTextStyle(
                      context: context, typography: TextStyleTypography.mainTextStyle, fontSize: TextStyleSize.s24),
                ),
              ),
            ),
            NUButton(
              onTap: () {
                model.save(context);
                context.navigatorProvider.pop();
              },
              child: Text(
                "Save",
                style: nuTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
              ),
            )
          ],
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
      );

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
          appBar: _appbar(context, model: model),
          body: Stack(
            children: [
              Container(
                color: secondaryColor(context, selected: model.theme[model.index - 1]),
                width: context.mediaSize.width,
                height: context.mediaSize.height,
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
                            child: NUIcon(
                              profile(context),
                              height: 100,
                            ),
                          ),
                          // Constants.myType != 'user' ? Container() : Text('change picture'),
                          const SizedBox(height: 24),
                          NUText(
                            text: 'setting.name',
                            customText: model.user?.name ?? '',
                            textStyle: nuTextStyle(
                              context: context,
                              typography: TextStyleTypography.headTextStyle,
                              fontSize: TextStyleSize.s24,
                            ),
                          ),
                          NUText(
                            text: 'setting.age',
                            customText: model.user?.age ?? '',
                            textStyle: nuTextStyle(
                              context: context,
                              typography: TextStyleTypography.headTextStyle,
                              fontSize: TextStyleSize.s19,
                            ),
                          ),
                          NUText(
                            text: 'setting.gender',
                            customText: model.user?.toGender(),
                            textStyle: nuTextStyle(
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
                          style: nuTextStyle(
                            context: context,
                            typography: TextStyleTypography.headTextStyle,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          tr('setting.select_theme'),
                          style: nuTextStyle(
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
                                          model.setTheme(context, index: index + 1);
                                        },
                                        child: NUIcon(model.themes[index]),
                                      ),
                                    ))
                                .values
                                .toList(),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        NUButton(
                          onTap: () {
                            if (!model.selectedTHLanguage(context)) {
                              context.setLocale(Locale('TH'));
                              ApplicationLanguage.setValue(context, Language.thai);
                            }
                          },
                          text: 'TH',
                          textStyle: nuTextStyle(
                            context: context,
                            customColor: primartTextColor(context),
                            fontWeight:
                                model.selectedTHLanguage(context) ? TextStyleWeight.black : TextStyleWeight.light,
                          ),
                          customColor: model.selectedTHLanguage(context) ? primaryColor(context) : Colors.transparent,
                          padding: EdgeInsets.all(16),
                          radius: 8,
                        ),
                        NUButton(
                          onTap: () {
                            if (model.selectedTHLanguage(context)) {
                              context.setLocale(Locale('EN'));
                              ApplicationLanguage.setValue(context, Language.english);
                            }
                          },
                          text: 'EN',
                          textStyle: nuTextStyle(
                            context: context,
                            customColor: primartTextColor(context),
                            fontWeight:
                                !model.selectedTHLanguage(context) ? TextStyleWeight.black : TextStyleWeight.light,
                          ),
                          customColor: !model.selectedTHLanguage(context) ? primaryColor(context) : Colors.transparent,
                          padding: EdgeInsets.all(16),
                          radius: 8,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        await model.logout();
                        context.navigatorProvider.pushToSignup();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(24),
                        child: Text(
                          tr('setting.logout'),
                          style: nuTextStyle(context: context),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NULoadingScreen(visible: model.busy)
            ],
          ),
        );
      },
    );
  }
}
