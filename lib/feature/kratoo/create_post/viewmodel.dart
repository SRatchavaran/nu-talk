import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_viewmodel.dart';
import 'package:nutalk/feature/kratoo/widget/list_content.dart';
import 'package:nutalk/function/datetime_now.dart';
import 'package:nutalk/helper/firestore_database_helper.dart';
import 'package:nutalk/model/community/post_community_model.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:collection/collection.dart';

class CreatePostViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  CreatePostViewModel(BuildContext context) : _mainProvider = context.provide();

  UserModel? get user => _mainProvider.user;

  List<CommunityContent>? _selectContent;
  List<CommunityContent>? get selectContent => _selectContent;
  void setSelectContent(CommunityContent content) {
    if (_selectContent?.isNotEmpty ?? false) {
      CommunityContent? check = selecedContent(content);
      if (check != null) {
        _selectContent?.remove(content);
      } else {
        _selectContent?.add(content);
      }
    } else {
      _selectContent = [content];
    }
    notifyListeners();
  }

  CommunityContent? selecedContent(CommunityContent content) =>
      _selectContent?.firstWhereOrNull((e) => content.community == e.community);

  void createPost({required String post}) async {
    busy = true;
    List<int> tag = [];
    for (CommunityContent content in _selectContent ?? []) {
      tag.add(content.community.index);
    }
    await DatabaseMethods().addPostCommunity(
      postRoomId: 'nu-kt${dateTimeNowCode()}',
      postMap: PostCommunityModel(
        createTime: DateTime.now(),
        image: user!.image,
        post: post,
        postId: 'nu-kt${dateTimeNowCode()}',
        tag: tag,
        userName: user!.name ?? '',
        userId: user!.userId ?? '',
      ),
    );
    busy = false;
  }
}
