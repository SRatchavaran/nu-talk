import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_widget.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/authentication/signup/viewmodel.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/loading_screen.dart';
import 'package:nutalk/widget/textfield_input.dart';
import 'package:nutalk/widget/textstyle.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  Widget _mainContent(
    BuildContext context, {
    required GlobalKey formKey,
    required TextEditingController emailEditingController,
    required TextEditingController passwordEditingController,
    required TextEditingController passwordAGEditingController,
    required FocusNode emailFocusNode,
    required FocusNode passwordAGFocusNode,
    required FocusNode passwordFocusNode,
    required SignupViewModel model,
  }) =>
      SingleChildScrollView(
        child: GestureDetector(
          onTap: () {
            context.unFocusScope();
            model.checkValidateEmail(emailEditingController.text);
            model.checkValidatePassword(passwordEditingController.text);
            model.checkValidatePasswordComfirm(passwordAGEditingController.text);
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
                  // height: 400,
                  padding: const EdgeInsets.symmetric(horizontal: 24), //ขอบซ้ายขวา
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(height: 24),
                      Form(
                        key: formKey,
                        child: Column(
                          children: <Widget>[
                            Text(
                              tr('auth.signup'),
                              style: customTextStyle(
                                context: context,
                                typography: TextStyleTypography.mainTextStyle,
                              ),
                            ),
                            const SizedBox(height: 8),
                            TextFieldCustom(
                              controller: emailEditingController,
                              focusNode: emailFocusNode,
                              labelText: tr('auth.input_email'),
                              backgroundColor: whiteColor,
                              errorText: model.errEmail,
                              onChanged: (val) => model.checkValidateEmail(val),
                              style: customTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                            ),
                            const SizedBox(height: 5),
                            TextFieldCustom(
                              controller: passwordEditingController,
                              focusNode: passwordFocusNode,
                              labelText: tr('auth.input_password'),
                              backgroundColor: whiteColor,
                              errorText: model.errPassword,
                              onChanged: (val) => model.checkValidatePassword(val),
                              obscureText: true,
                              style: customTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                            ),
                            const SizedBox(height: 5),
                            TextFieldCustom(
                              controller: passwordAGEditingController,
                              focusNode: passwordAGFocusNode,
                              labelText: tr('auth.input_confirm_password'),
                              backgroundColor: whiteColor,
                              errorText: model.errPasswordConfirm,
                              onChanged: (val) => model.checkValidatePasswordComfirm(val),
                              obscureText: true,
                              style: customTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 21),
                      GestureDetector(
                        onTap: () {
                          signMeUp(context, model: model, formKey: formKey);
                        },
                        child: Container(
                          //width: MediaQuery.of(context).size.width,
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
                            tr('auth.signup'),
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
      );

  void signMeUp(BuildContext context, {required GlobalKey formKey, required SignupViewModel model}) async {
    ////check user uid before regist
    // String fcmToken = await firebaseMessaging.getToken();
    //   databaseMethods.updatefcmToken(Constants.myEmail, fcmToken);

    //   Map<String, dynamic> userInfoMap = {
    //     "email": emailEditingController.text,
    //     "image": "1",
    //     "theme": 1,
    //     "type": 'user'
    //   };

    //   HelperFunctions.saveUserEmailSharedPreference(emailEditingController.text);
    //   model.busy = true;
    //   Constants.myEmail = emailEditingController.text;
    //   Constants.myTheme = 1;
    //   Constants.myType = 'user';

    //   authService.signUpWithEmailAndPassword(emailEditingController.text, passwordEditingController.text).then((val) {
    //     print("${Constants.myType} type");
    //     databaseMethods.uploadUserInfo(emailEditingController.text, userInfoMap);
    //     HelperFunctions.saveUserLoggedInSharedPreference(true);
    //     Navigator.pushReplacement(
    //         context, MaterialPageRoute(builder: (context) => Profile(emailEditingController.text)));
    //   });

    context.navigatorProvider.pushToHome();
  }

  @override
  Widget build(BuildContext context) {
    GlobalKey formKey = GlobalKey();
    TextEditingController emailEditingController = TextEditingController();
    TextEditingController passwordEditingController = TextEditingController();
    TextEditingController passwordAGEditingController = TextEditingController();
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordAGFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    return BaseWidget<SignupViewModel>(
      model: SignupViewModel(),
      onModelReady: (model) {},
      onPageResume: (model) {},
      builder: (context, model, _) {
        return Scaffold(
          //appBar: appBarMain(context),
          body: Stack(
            children: [
              _mainContent(
                context,
                formKey: formKey,
                emailEditingController: emailEditingController,
                passwordAGEditingController: passwordAGEditingController,
                passwordEditingController: passwordEditingController,
                emailFocusNode: emailFocusNode,
                passwordFocusNode: passwordFocusNode,
                passwordAGFocusNode: passwordAGFocusNode,
                model: model,
              ),
              LoadingScreen(visible: model.busy)
            ],
          ),
        );
      },
    );
  }
}
