// import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nutalk/feature/setup_profile/viewmodel.dart';

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

  @JsonKey(defaultValue: 'user')
  final String type;

  @JsonKey(defaultValue: '')
  final String? userId;

  final String? name;

  final String? age;

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
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
