import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_widget.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/main/viewmodel.dart';
import 'package:nutalk/helper/share_preference_helper.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/icon.dart';
import 'package:nutalk/widget/loading_screen.dart';
import 'package:nutalk/widget/textstyle.dart';
import 'package:nutalk/widget/user_profile.dart';

class MainNavigatorBarArguments {
  final bool initScreen;

  MainNavigatorBarArguments({
    this.initScreen = true,
  });
}

class MainNavigatorBar extends StatelessWidget {
  final StatefulNavigationShell child;
  const MainNavigatorBar({required this.child, super.key});

  void _onTapHelp(BuildContext context, {required MainViewModel model}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: primaryColor(context),
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
          title: SizedBox(
            width: 200,
            height: MediaQuery.of(context).size.height - (MediaQuery.of(context).size.height / 2) - 140,
            child: Column(
              children: [
                Expanded(
                  child: CarouselSlider(
                    options: CarouselOptions(
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        model.currentIndex = index;
                        (context as Element).markNeedsBuild();
                      },
                    ),
                    items: const [
                      NUIcon(IconName.help1),
                      NUIcon(IconName.help2),
                      NUIcon(IconName.help3),
                      NUIcon(IconName.help4)
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: 4,
                    itemBuilder: (context, i) {
                      return Container(
                        width: 8.0,
                        height: 8.0,
                        margin: const EdgeInsets.symmetric(horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: model.currentIndex == i ? whiteColor : blackThemeColor(context),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  PreferredSizeWidget _appBar(BuildContext context, {required MainViewModel model}) {
    return AppBar(
      systemOverlayStyle: SystemUiOverlayStyle.light,
      backgroundColor: primaryColor(context),
      title: Row(
        children: [
          NUIcon(
            profile(context),
            height: 45,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              model.user?.name ?? 'E',
              style: nuTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
            ),
          )
        ],
      ),
      actions: [
        GestureDetector(
          onTap: () {
            model.currentIndex = 0;
            _onTapHelp(context, model: model);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: const Icon(Icons.help, size: 32),
          ),
        ),
        GestureDetector(
          onTap: () => context.navigatorProvider.pushToSetting(),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: const Icon(Icons.settings, size: 32),
          ),
        )
      ],
    );
  }

  BottomNavigationBarItem _contentBottomNavigationBar({
    required String lable,
    required IconName icon,
    Color? color,
    double? height,
  }) =>
      BottomNavigationBarItem(
        icon: NUIcon(
          icon,
          height: height ?? 20,
          color: color,
        ),
        label: tr('bottom_bar.$lable'),
      );

  Widget _bottomNavigationBar(BuildContext context, {required MainViewModel model}) {
    return SizedBox(
      height: 60,
      child: BottomNavigationBar(
        elevation: 0,
        selectedLabelStyle: nuTextStyle(
            context: context, typography: TextStyleTypography.simpleTextStyle, fontWeight: TextStyleWeight.bold),
        unselectedLabelStyle: nuTextStyle(
          context: context,
          typography: TextStyleTypography.smallTextStyle,
          colorFont: TextStyleColor.secondaryColor,
        ),
        currentIndex: child.currentIndex,
        backgroundColor: primaryColor(context),
        type: BottomNavigationBarType.fixed,
        selectedItemColor: whiteColor,
        unselectedItemColor: disableColor,
        items: [
          _contentBottomNavigationBar(
            icon: IconName.bottomBarIconCommunity,
            color: blackColor.withOpacity(0.4),
            height: 15,
            lable: 'community',
          ),
          _contentBottomNavigationBar(
            icon: IconName.bottomBarIconChat,
            lable: 'chat',
          ),
          _contentBottomNavigationBar(
            icon: IconName.profileStaff1,
            lable: 'home',
          ),
          _contentBottomNavigationBar(
            icon: IconName.bottomBarIconNote,
            lable: 'note',
          ),
          _contentBottomNavigationBar(
            icon: IconName.bottomBarIconBooking,
            lable: 'booking',
          ),
        ],
        onTap: (index) {
          child.goBranch(index, initialLocation: index == child.currentIndex);
        },
      ),
    );
  }

  Widget _floatingActionButton(BuildContext context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom == 0.0 ? 25 : 20),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () => child.goBranch(2, initialLocation: 2 == child.currentIndex),
            child: const NUIcon(
              IconName.profileStaff1,
              height: 60,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    var arguments = context.settingsArguments as MainNavigatorBarArguments?;

    log('BOTTOM: ${MediaQuery.of(context).viewInsets.bottom}');
    return BaseWidget<MainViewModel>(
      model: MainViewModel(context),
      onModelReady: (model) async {
        await model.init(init: arguments?.initScreen ?? true);
        if (!model.isLogin) {
          Future.delayed(
            Duration.zero,
            () async {
              if (!(await SharePreferenceHelper.getUserLoggedInSharedPreference())) {
                context.navigatorProvider.pushToSignup();
              }
            },
          );
        }
      },
      onPageResume: (model) {},
      builder: (context, model, _) {
        if (model.busy) {
          return Container(
            color: primaryColor(context),
            child: Center(
              child: NUIcon(IconName.profileStaff1, height: 100),
            ),
          );
        }
        return Scaffold(
          resizeToAvoidBottomInset: true,
          backgroundColor: secondaryColor(context),
          appBar: _appBar(context, model: model),
          body: Stack(
            children: [
              child,
              NULoadingScreen(visible: model.user == null),
            ],
          ),
          bottomNavigationBar: _bottomNavigationBar(context, model: model),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _floatingActionButton(context),
        );
      },
    );
  }
}
