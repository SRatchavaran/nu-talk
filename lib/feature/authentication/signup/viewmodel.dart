import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_viewmodel.dart';
import 'package:nutalk/function/validator.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';

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
}
