import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_widget.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/kratoo/create_post/viewmodel.dart';
import 'package:nutalk/feature/kratoo/widget/list_content.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/button.dart';
import 'package:nutalk/widget/text.dart';
import 'package:nutalk/widget/textfield_input.dart';
import 'package:nutalk/widget/textstyle.dart';

class CreatePostScreen extends StatelessWidget {
  const CreatePostScreen({super.key});

  PreferredSizeWidget _appbar(
    BuildContext context, {
    required CreatePostViewModel model,
    required TextEditingController postController,
  }) =>
      AppBar(
        elevation: 0,
        titleSpacing: 0,
        automaticallyImplyLeading: false,
        backgroundColor: primaryColor(context),
        title: SizedBox(
          height: 78,
          width: context.mediaSize.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                flex: 1,
                child: NUButton(
                  onTap: () => context.navigatorProvider.pop(),
                  text: 'common.cancle',
                  textStyle: nuTextStyle(
                    context: context,
                    typography: TextStyleTypography.smallTextStyle,
                    colorFont: TextStyleColor.disableColor,
                  ),
                ),
              ),
              Flexible(
                flex: 3,
                child: NUText(
                  text: 'nu_talk',
                  textStyle: nuTextStyle(
                    context: context,
                    typography: TextStyleTypography.mainTextStyle,
                    fontSize: TextStyleSize.s32,
                  ),
                ),
              ),
              Flexible(
                flex: 1,
                child: NUButton(
                  onTap: () {
                    if ((model.selectContent?.isEmpty ?? true)) {
                      context.showToast(msg: 'community.create.err_tag');
                      return;
                    } else if (postController.text.isEmpty) {
                      context.showToast(msg: 'community.create.err_post');
                      return;
                    }
                    model.createPost(post: postController.text);

                    context.navigatorProvider.pop();
                  },
                  text: 'community.create.post',
                  textStyle: nuTextStyle(
                    context: context,
                    typography: TextStyleTypography.simpleTextStyle,
                    fontWeight: TextStyleWeight.bold,
                    customColor: primartTextColor(context),
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  Widget _mainContent(
    BuildContext context, {
    required CreatePostViewModel model,
    required TextEditingController postController,
    required FocusNode postFocusNode,
  }) =>
      GestureDetector(
        onTap: () {
          context.unFocusScope();
          model.forceRefresh();
        },
        child: SizedBox(
          height: context.mediaSize.height,
          child: ListView(
            children: [
              CommunityContentWidget(
                onTap: (e) => model.setSelectContent(e),
                selecedContent: (e) => model.selecedContent(e),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: NUTextField(
                  backgroundColor: whiteColor,
                  height: 200,
                  baseline: 30,
                  hintText: tr('community.create.description'),
                  controller: postController,
                  focusNode: postFocusNode,
                  maxLines: 5,
                  onNeedNotifyListeners: () => model.forceRefresh(),
                ),
              ),
            ],
          ),
        ),
      );

  @override
  Widget build(BuildContext context) {
    TextEditingController postController = TextEditingController();
    FocusNode postFocusNode = FocusNode();
    return BaseWidget<CreatePostViewModel>(
      model: CreatePostViewModel(context),
      onModelReady: (model) {},
      onPageResume: (model) {},
      builder: (context, model, _) {
        return Scaffold(
          backgroundColor: secondaryColor(context),
          appBar: _appbar(context, model: model, postController: postController),
          body: _mainContent(context, model: model, postController: postController, postFocusNode: postFocusNode),
        );
      },
    );
  }
}
