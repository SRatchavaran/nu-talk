// import 'package:easy_localization/easy_localization.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nutalk/feature/setup_profile/viewmodel.dart';
import 'package:nutalk/provider/main_provider.dart';

part 'user_model.g.dart';
// part 'user_model.dart';

enum UserType { admin, user, professor }

@JsonSerializable()
class UserModel {
  @JsonKey(defaultValue: '')
  final String email;

  @JsonKey(defaultValue: 1)
  final int image;

  @JsonKey(defaultValue: 1)
  final int theme;

  @JsonKey(name: 'user')
  final String type;

  @JsonKey(defaultValue: '')
  final String? userId;

  final String? name;

  final String? age;

  final String? uid;

  @JsonKey(name: 'gender', defaultValue: 2)
  final int? genderStr;

  Gender gender() {
    switch (genderStr) {
      case 0:
        return Gender.female;
      case 1:
        return Gender.male;
      default:
        return Gender.other;
    }
  }

  String toGender() {
    switch (genderStr) {
      case 0:
        return tr('common.gender.female');
      case 1:
        return tr('common.gender.male');
      default:
        return tr('common.gender.other');
    }
  }

  CustomTheme toTheme() {
    switch (theme) {
      case 1:
        return CustomTheme.theme1;
      case 2:
        return CustomTheme.theme2;
      case 3:
        return CustomTheme.theme3;
      case 4:
        return CustomTheme.theme4;
      case 5:
        return CustomTheme.theme5;
      default:
        return CustomTheme.theme1;
    }
  }

  UserType userType() {
    switch (type) {
      case 'user':
        return UserType.user;
      case 'admin':
        return UserType.admin;
      case 'professor':
        return UserType.professor;
      default:
        return UserType.user;
    }
  }

  UserModel({
    this.email = '',
    this.image = 1,
    this.theme = 1,
    this.type = 'user',
    this.userId,
    this.name = '',
    this.age,
    this.genderStr,
    this.uid,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
