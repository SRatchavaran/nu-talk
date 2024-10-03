import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/setup_profile/viewmodel.dart';
import 'package:nutalk/helper/firestore_database_helper.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/icon.dart';
import 'package:nutalk/widget/textfield_input.dart';
import 'package:nutalk/widget/textstyle.dart';

import '../../base/base_widget.dart';

class SetupProfileScreen extends StatelessWidget {
  const SetupProfileScreen({super.key});

  void setupProfile(BuildContext context, {required SetupProfileViewModel model}) async {
    if (model.name.isEmpty) {
      context.showToast(msg: 'common.err.input_name');
    } else {
      model.busy = true;
      bool nameIsRepeat = await DatabaseMethods().checkName(model.name);
      if (nameIsRepeat) {
        context.showToast(msg: 'common.err.repeat_name');
      } else {
        await DatabaseMethods().updateUserInfo(
          context,
          image: model.image,
          age: model.selectAge,
          gender: model.selectGender?.gender.index ?? 0,
          name: model.name,
        );
        context.navigatorProvider.pushToHome();
      }

      model.busy = false;
    }
  }

  void selectProfile(BuildContext context, {required SetupProfileViewModel model}) {
    List<IconName> listProfile = [
      IconName.profileUser1,
      IconName.profileUser2,
      IconName.profileUser3,
      IconName.profileUser4,
      IconName.profileUser5,
      IconName.profileUser6,
    ];
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          elevation: 24,
          backgroundColor: Color(0xfffcec9e),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(40.0))),
          title: SizedBox(
            width: 100,
            height: 200,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'select profile',
                  style: customTextStyle(
                    context: context,
                    typography: TextStyleTypography.headTextStyle,
                    fontSize: TextStyleSize.s24,
                  ),
                ),
                SizedBox(height: 16),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 3,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1,
                    children: List.generate(
                      listProfile.length,
                      (index) {
                        var item = listProfile[index];
                        return GestureDetector(
                          onTap: () {
                            model.profile = item;
                            context.navigatorProvider.pop();
                          },
                          child: CustomIcon(item, height: 60),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _mainContent(
    BuildContext context, {
    required SetupProfileViewModel model,
    required TextEditingController usernameEditingController,
    required FocusNode usernameFocusNode,
  }) =>
      Scaffold(
        body: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              context.unFocusScope();
            },
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const SizedBox(height: 50),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: secondaryTheme4,
                    ),
                    width: MediaQuery.of(context).size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const SizedBox(height: 24),
                        Column(
                          children: <Widget>[
                            Text(
                              tr('profile.title'),
                              style: customTextStyle(
                                context: context,
                                typography: TextStyleTypography.mainTextStyle,
                              ),
                            ),
                            const SizedBox(height: 8),
                            GestureDetector(
                              onTap: () => selectProfile(context, model: model),
                              child: Column(
                                children: [
                                  CustomIcon(model.profile, height: 100),
                                  const SizedBox(height: 4),
                                  Text(
                                    tr('common.choose_img'),
                                    style: customTextStyle(
                                      context: context,
                                      typography: TextStyleTypography.smallTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            TextFieldCustom(
                              controller: usernameEditingController,
                              focusNode: usernameFocusNode,
                              labelText: tr('profile.username_hint'),
                              backgroundColor: whiteColor,
                              errorText: model.errUsername,
                              onChanged: (val) => model.checkValidateUsername(val),
                              style: customTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tr('profile.select_gender'),
                                  style: customTextStyle(
                                    context: context,
                                    typography: TextStyleTypography.simpleTextStyle,
                                  ),
                                ),
                                SizedBox(width: 10),
                                DropdownButton<GenderValue>(
                                  value: model.selectGender,
                                  icon: Icon(
                                    Icons.arrow_downward,
                                    color: primaryColor(context),
                                  ),
                                  elevation: 16,
                                  style: customTextStyle(
                                      context: context, typography: TextStyleTypography.simpleTextStyle),
                                  underline: Container(
                                    height: 2,
                                    color: primaryColor(context),
                                  ),
                                  onChanged: (GenderValue? value) {
                                    model.selectGender = value;
                                  },
                                  items: model.genders.map<DropdownMenuItem<GenderValue>>((GenderValue value) {
                                    return DropdownMenuItem<GenderValue>(
                                      value: value,
                                      child: Text(
                                        value.text,
                                        style: customTextStyle(
                                            context: context, typography: TextStyleTypography.simpleTextStyle),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  tr('profile.select_age'),
                                  style: customTextStyle(
                                    context: context,
                                    typography: TextStyleTypography.simpleTextStyle,
                                  ),
                                ),
                                SizedBox(width: 10),
                                DropdownButton<String>(
                                  value: model.selectAge,
                                  icon: Icon(
                                    Icons.arrow_downward,
                                    color: primaryColor(context),
                                  ),
                                  elevation: 16,
                                  style: customTextStyle(
                                      context: context, typography: TextStyleTypography.simpleTextStyle),
                                  underline: Container(
                                    height: 2,
                                    color: primaryColor(context),
                                  ),
                                  onChanged: (String? value) {
                                    model.selectAge = value ?? '';
                                  },
                                  items: model.ageList.map<DropdownMenuItem<String>>((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: customTextStyle(
                                            context: context, typography: TextStyleTypography.simpleTextStyle),
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ],
                            ),
                          ],
                        ),
                        const SizedBox(height: 21),
                        GestureDetector(
                          onTap: () => setupProfile(context, model: model),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                gradient: const LinearGradient(
                                  colors: [
                                    Color(0xffffccb1),
                                    Color(0xfffab28c),
                                  ],
                                )),
                            child: Text(
                              tr('profile.title'),
                              style: customTextStyle(context: context, typography: TextStyleTypography.biggerTextStyle),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameEditingController = TextEditingController();
    FocusNode usernameFocusNode = FocusNode();
    return BaseWidget<SetupProfileViewModel>(
      model: SetupProfileViewModel(),
      onModelReady: (model) {
        model.init();
      },
      onPageResume: (model) {},
      builder: (context, model, _) => _mainContent(
        context,
        model: model,
        usernameEditingController: usernameEditingController,
        usernameFocusNode: usernameFocusNode,
      ),
    );
  }
}
