import 'package:flutter/material.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/feature/kratoo/widget/list_content.dart';
import 'package:nutalk/model/user/user_model.dart';
import 'package:nutalk/provider/main_provider.dart';
import 'package:collection/collection.dart';

import '../../base/base_viewmodel.dart';

class CommunityViewModel extends BaseViewModel {
  final MainProvider _mainProvider;

  CommunityViewModel(BuildContext context) : _mainProvider = context.provide();

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

  UserModel? get user => _mainProvider.user;
}
