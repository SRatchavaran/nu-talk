import 'dart:developer';

import 'package:nutalk/base/base_viewmodel.dart';
import 'package:nutalk/function/validator.dart';

class SignupViewModel extends BaseViewModel {
  String _password = '';
  String get password => _password;
  set password(String pass) {
    _password = pass;
  }

  String? errEmail;

  void checkValidateEmail(String val, {bool busy = true}) {
    log('EMAIL: $val');
    if (val != '' && val.isNotEmpty) {
      errEmail = emailValidator(val);
    } else {
      errEmail = null;
    }
    if (busy) {
      notifyListeners();
    }
  }

  String? errPassword;

  void checkValidatePassword(String val, {bool busy = true}) {
    password = val;
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
      errPasswordConfirm = confirmPasswordValidator(val, password: password);
    } else {
      errPasswordConfirm = null;
    }
    if (busy) {
      notifyListeners();
    }
  }
}
