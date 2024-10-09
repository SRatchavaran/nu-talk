import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_viewmodel.dart';
import 'package:nutalk/function/validator.dart';
import 'package:nutalk/helper/firestore_database_helper.dart';
import 'package:nutalk/helper/share_preference_helper.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:nutalk/service/auth_service.dart';

class SignupViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  SignupViewModel(BuildContext context) : _mainProvider = context.provide();

  String _password = '';
  String get password => _password;

  String email = '';

  bool isRepeat = false;

  String? errEmail;

  void checkValidateEmail(String val, {bool busy = true}) {
    if (!isRepeat) {
      email = val;
      if (val != '' && val.isNotEmpty) {
        errEmail = emailValidator(val);
      } else {
        errEmail = null;
      }
    } else {
      isRepeat = false;
    }
    if (busy) {
      notifyListeners();
    }
  }

  String? errPassword;

  void checkValidatePassword(String val, {bool busy = true}) {
    _password = val;
    if (val != '' && val.isNotEmpty) {
      errPassword = passwordValidator(val);
    } else {
      errPassword = null;
    }
    if (busy) {
      notifyListeners();
    }
  }

  String? errPasswordConfirm;

  void checkValidatePasswordComfirm(String val, {bool busy = true}) {
    if (val != '' && val.isNotEmpty) {
      errPasswordConfirm = confirmPasswordValidator(val, password: _password);
    } else {
      errPasswordConfirm = null;
    }
    if (busy) {
      notifyListeners();
    }
  }

  void setupProfile({required UserModel user}) => _mainProvider.user = user;

  bool isActive({required String email, required String password, required String passwordAG}) =>
      errEmail == null && errPassword == null && errPasswordConfirm == null && email.isNotEmpty && password.isNotEmpty;

  Future<bool> signup({required String email, required String password, required String passwordAG}) async {
    var isReturn = false;
    checkValidateEmail(email);
    checkValidatePassword(password);
    checkValidatePasswordComfirm(passwordAG);
    if (isActive(email: email, password: password, passwordAG: passwordAG)) {
      SharePreferenceHelper.saveUserEmailSharedPreference(email);
      busy = true;
      bool emailIsRepeat = await DatabaseMethods().checkEmail(email);
      if (!emailIsRepeat) {
        try {
          await AuthService().signUpWithEmailAndPassword(email, password).then((val) {
            if (val is UserModel) {
              setupProfile(user: val);
              DatabaseMethods().uploadUserInfo(email, val);
              SharePreferenceHelper.saveUserLoggedInSharedPreference(true);
              busy = false;
              isReturn = true;
            }
          });
        } catch (e) {
          errEmail = 'common.err.repeat_email';
          isReturn = false;
        }
      } else {
        errEmail = 'common.err.repeat_email';
        isReturn = false;
      }
    }
    busy = false;
    return isReturn;
  }
}
