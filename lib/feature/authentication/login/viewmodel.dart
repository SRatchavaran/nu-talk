import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_viewmodel.dart';
import 'package:nutalk/function/validator.dart';
import 'package:nutalk/helper/firestore_database_helper.dart';
import 'package:nutalk/helper/share_preference_helper.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:nutalk/service/auth_service.dart';

class SignInViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  SignInViewModel(BuildContext context) : _mainProvider = context.provide();

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

  void setupProfile({required UserModel user}) => _mainProvider.user = user;

  Future<bool> signin({required String email, required String password}) async {
    bool isReturn = false;
    checkValidateEmail(email);
    checkValidatePassword(password);

    busy = true;
    if (errEmail == null && errPassword == null && email.isNotEmpty && password.isNotEmpty) {
      ////check user uid before regist
      // String fcmToken = await firebaseMessaging.getToken();
      //   databaseMethods.updatefcmToken(Constants.myEmail, fcmToken);

      SharePreferenceHelper.saveUserEmailSharedPreference(email);

      bool emailIsRepeat = await DatabaseMethods().checkEmail(email);
      if (emailIsRepeat) {
        await AuthService().signInWithEmailAndPassword(email, password).then((val) {
          if (val is UserModel) {
            SharePreferenceHelper.saveUserLoggedInSharedPreference(true);
            isReturn = true;
          }
        });
      } else {
        errEmail = 'auth.signin_err';
        isReturn = false;
      }
      busy = false;
    }
    return isReturn;
  }
}
