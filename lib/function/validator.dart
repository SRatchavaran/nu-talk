import 'package:easy_localization/easy_localization.dart';

String? emailValidator(String? val) {
  return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(val ?? '')
      ? null
      : tr('auth.input_email_err');
}

String? passwordValidator(String? val) {
  if (val != null) {
    return val.length > 5 ? null : tr('auth.input_password_err');
  }
  return null;
}

String? confirmPasswordValidator(String? val, {required String password}) {
  if (val != null) {
    return val == password && val.length > 5 ? null : tr('auth.input_confirm_password_err');
  }
  return null;
}

String? usernameValidator(String? val) {
  return RegExp(r"^[a-zA-Z0-9]").hasMatch(val ?? '') ? null : tr('profile.username_err');
}
