import 'dart:developer';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutalk/base/base_widget.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/main/viewmodel.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/icon.dart';
import 'package:nutalk/widget/textstyle.dart';

class MainNavigatorBar extends StatelessWidget {
  final StatefulNavigationShell child;
  const MainNavigatorBar({required this.child, super.key});

  void _onTapHelp(BuildContext context, {required MainViewModel model}) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: model.primaryColorTheme,
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
                      CustomIcon(IconName.help1),
                      CustomIcon(IconName.help2),
                      CustomIcon(IconName.help3),
                      CustomIcon(IconName.help4)
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
                          color: model.currentIndex == i ? whiteColor : blackTheme1,
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
      backgroundColor: model.primaryColorTheme,
      title: Row(
        children: [
          const CustomIcon(
            IconName.profileUser1,
            height: 45,
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Text(
              'NAME',
              style: customTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
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
        icon: CustomIcon(
          icon,
          height: height ?? 20,
          color: color,
        ),
        label: tr('bottom_bar.$lable'),
      );

  Widget _bottomNavigationBar(BuildContext context,{required MainViewModel model}) {
    return SizedBox(
      height: 85,
      child: BottomNavigationBar(
        elevation: 0,
        selectedLabelStyle: customTextStyle(
            context: context, typography: TextStyleTypography.simpleTextStyle, fontWeight: TextStyleWeight.bold),
        unselectedLabelStyle: customTextStyle(
          context: context,
          typography: TextStyleTypography.smallTextStyle,
          colorFont: TextStyleColor.secondaryColor,
        ),
        currentIndex: child.currentIndex,
        backgroundColor: model.primaryColorTheme,
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom == 0.0 ? 41 : 23),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: GestureDetector(
            onTap: () => child.goBranch(2, initialLocation: 2 == child.currentIndex),
            child: const CustomIcon(
              IconName.profileStaff1,
              height: 60,
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    log('BOTTOM: ${MediaQuery.of(context).viewInsets.bottom}');
    return BaseWidget<MainViewModel>(
      model: MainViewModel(context),
      onModelReady: (model) {},
      onPageResume: (model) {},
      builder: (context, model, _) {
        return Scaffold(
          appBar: _appBar(context, model: model),
          body: child,
          bottomNavigationBar: _bottomNavigationBar(context,model: model),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          floatingActionButton: _floatingActionButton(context),
        );
      },
    );
  }
}
