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
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      const SizedBox(height: 24),
                      Column(
                        children: <Widget>[
                          Text(
                            tr('auth.signup'),
                            style: nuTextStyle(
                              context: context,
                              typography: TextStyleTypography.mainTextStyle,
                            ),
                          ),
                          const SizedBox(height: 8),
                          NUTextField(
                            controller: emailEditingController,
                            focusNode: emailFocusNode,
                            labelText: tr('auth.input_email'),
                            backgroundColor: whiteColor,
                            errorText: model.errEmail,
                            onChanged: (val) => model.checkValidateEmail(val),
                            style: nuTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                          ),
                          const SizedBox(height: 5),
                          NUTextField(
                            controller: passwordEditingController,
                            focusNode: passwordFocusNode,
                            keyboardType: TextInputType.number,
                            labelText: tr('auth.input_password'),
                            backgroundColor: whiteColor,
                            errorText: model.errPassword,
                            onChanged: (val) => model.checkValidatePassword(val),
                            obscureText: true,
                            style: nuTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                          ),
                          const SizedBox(height: 5),
                          NUTextField(
                            controller: passwordAGEditingController,
                            focusNode: passwordAGFocusNode,
                            keyboardType: TextInputType.number,
                            labelText: tr('auth.input_confirm_password'),
                            backgroundColor: whiteColor,
                            errorText: model.errPasswordConfirm,
                            onChanged: (val) => model.checkValidatePasswordComfirm(val),
                            obscureText: true,
                            style: nuTextStyle(context: context, typography: TextStyleTypography.simpleTextStyle),
                          ),
                        ],
                      ),
                      const SizedBox(height: 21),
                      GestureDetector(
                        onTap: () async {
                          context.unFocusScope();
                          if (!model.isActive(
                              email: emailEditingController.text,
                              password: passwordEditingController.text,
                              passwordAG: passwordAGEditingController.text)) {
                            if (model.email.isEmpty) {
                              model.errEmail = 'common.err.repeat_email';
                              context.showToast(msg: 'common.err.repeat_email');
                            } else {
                              returnErr(context, model: model);
                            }
                            return;
                          }
                          var complete = await model.signup(
                              email: emailEditingController.text,
                              password: passwordEditingController.text,
                              passwordAG: passwordAGEditingController.text);
                          if (complete) {
                            context.navigatorProvider.pushToSetupProfile();
                          } else {
                            if (model.errEmail?.isNotEmpty ?? false) {
                              context.showToast(msg: model.errEmail!);
                            } else {
                              returnErr(context, model: model);
                            }
                          }
                        },
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
                            tr('auth.signup'),
                            style: nuTextStyle(context: context, typography: TextStyleTypography.biggerTextStyle),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                      Text(
                        tr('auth.have_user'),
                        textAlign: TextAlign.center,
                        style: nuTextStyle(context: context, typography: TextStyleTypography.smallTextStyle),
                      ),
                      GestureDetector(
                        onTap: () => context.navigatorProvider.pushToSignin(),
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                          child: Text(
                            tr('auth.signin'),
                            style: nuTextStyle(
                                context: context,
                                typography: TextStyleTypography.biggerTextStyle,
                                colorFont: TextStyleColor.primaryColor),
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

  void returnErr(BuildContext context, {required SignupViewModel model}) {
    var err = '';
    if (model.email.isEmpty) {
      err = 'auth.input_email_err';
      model.errEmail = tr(err);
    } else if (model.password.isEmpty) {
      err = 'auth.input_password_err';
      model.errPassword = tr(err);
      model.errPasswordConfirm = tr(err);
    }
    context.showToast(msg: err);
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController emailEditingController = TextEditingController();
    TextEditingController passwordEditingController = TextEditingController();
    TextEditingController passwordAGEditingController = TextEditingController();
    FocusNode emailFocusNode = FocusNode();
    FocusNode passwordAGFocusNode = FocusNode();
    FocusNode passwordFocusNode = FocusNode();
    return BaseWidget<SignupViewModel>(
      model: SignupViewModel(context),
      onModelReady: (model) {},
      onPageResume: (model) {},
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: secondaryColor(context),
          body: Stack(
            children: [
              _mainContent(
                context,
                emailEditingController: emailEditingController,
                passwordAGEditingController: passwordAGEditingController,
                passwordEditingController: passwordEditingController,
                emailFocusNode: emailFocusNode,
                passwordFocusNode: passwordFocusNode,
                passwordAGFocusNode: passwordAGFocusNode,
                model: model,
              ),
              NULoadingScreen(visible: model.busy)
            ],
          ),
        );
      },
    );
  }
}
