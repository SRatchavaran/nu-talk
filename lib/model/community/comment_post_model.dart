import 'package:json_annotation/json_annotation.dart';
import 'package:nutalk/network/datetime_converter.dart';

part 'comment_post_model.g.dart';

enum UserType { admin, user, professor }

@JsonSerializable()
@CustomDateTimeConverter()
class CommentPostModel {
  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'user_id')
  final String userId;

  final int image;

  final String comment;

  @JsonKey(name: 'create_time')
  final DateTime createTime;

  CommentPostModel({
    required this.createTime,
    required this.image,
    required this.comment,
    required this.userName,
    required this.userId,
  });

  factory CommentPostModel.fromJson(Map<String, dynamic> json) => _$CommentPostModelFromJson(json);

  Map<String, dynamic> toJson() => _$CommentPostModelToJson(this);
}
