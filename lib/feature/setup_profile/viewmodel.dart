import 'package:easy_localization/easy_localization.dart';
import 'package:nutalk/function/validator.dart';
import 'package:nutalk/widget/icon.dart';

import '../../base/base_viewmodel.dart';

enum Gender { female, male, other }

class GenderValue {
  String text;
  Gender gender;
  GenderValue({required this.text, required this.gender});
}

class SetupProfileViewModel extends BaseViewModel {
  List<GenderValue> genders = [
    GenderValue(gender: Gender.male, text: tr('common.gender.male')),
    GenderValue(gender: Gender.female, text: tr('common.gender.female')),
    GenderValue(gender: Gender.other, text: tr('common.gender.other'))
  ];

  List<String> ageList = List<String>.generate(21, (int index) => '${index + 15}');

  String? errUsername;

  String name = '';

  int image = 1;

  IconName _profile = IconName.profileUser1;
  IconName get profile => _profile;
  set profile(IconName icon) {
    if (_profile != icon) {
      _profile = icon;
      switch (icon) {
        case IconName.profileUser1:
          image = 1;
          break;
        case IconName.profileUser2:
          image = 2;
          break;
        case IconName.profileUser3:
          image = 3;
          break;
        case IconName.profileUser4:
          image = 4;
          break;
        case IconName.profileUser5:
          image = 5;
          break;
        case IconName.profileUser6:
          image = 6;
          break;
        default:
          image = 1;
          break;
      }
      notifyListeners();
    }
  }

  GenderValue? _selectGender;
  GenderValue? get selectGender => _selectGender;
  set selectGender(GenderValue? value) {
    if (_selectGender != value) {
      _selectGender = value;
      notifyListeners();
    }
  }

  String _selectAge = '15';
  String get selectAge => _selectAge;
  set selectAge(String value) {
    if (_selectAge != value) {
      _selectAge = value;
      notifyListeners();
    }
  }

  void init() {
    _selectGender = genders.first;
  }

  void checkValidateUsername(String val, {bool busy = true}) {
    name = val;
    if (val != '' && val.isNotEmpty) {
      errUsername = usernameValidator(val);
    } else {
      errUsername = null;
    }
    if (busy) {
      notifyListeners();
    }
  }
}
