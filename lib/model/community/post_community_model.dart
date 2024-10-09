// import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:nutalk/model/community/comment_post_model.dart';
import 'package:nutalk/network/datetime_converter.dart';

part 'post_community_model.g.dart';
// part 'user_model.dart';

enum UserType { admin, user, professor }

@JsonSerializable()
@CustomDateTimeConverter()
class PostCommunityModel {
  @JsonKey(name: 'user_name')
  final String userName;

  @JsonKey(name: 'user_id')
  final String userId;

  final int image;

  final String post;

  @JsonKey(name: 'post_id')
  final String postId;

  final List<int> tag;

  @JsonKey(name: 'create_time')
  final DateTime createTime;

  final List<CommentPostModel>? comments;

  PostCommunityModel({
    required this.createTime,
    required this.image,
    required this.post,
    required this.postId,
    required this.tag,
    required this.userName,
    required this.userId,
    this.comments,
  });

  factory PostCommunityModel.fromJson(Map<String, dynamic> json) => _$PostCommunityModelFromJson(json);

  Map<String, dynamic> toJson() => _$PostCommunityModelToJson(this);
}
