import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_widget.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/kratoo/detail/screen.dart';
import 'package:nutalk/feature/kratoo/viewmodel.dart';
import 'package:nutalk/feature/kratoo/widget/list_content.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/icon.dart';
import 'package:nutalk/widget/loading_screen.dart';
import 'package:nutalk/widget/text.dart';
import 'package:nutalk/widget/textstyle.dart';
import 'package:nutalk/widget/user_profile.dart';

class KratooScreen extends StatelessWidget {
  const KratooScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommunityViewModel>(
      model: CommunityViewModel(context),
      // onModelReady: (model) async {
      //   await model.init();
      // },
      onPageResume: (model) async {
        await model.init();
      },
      builder: (context, model, _) {
        return Stack(
          children: [
            ListView(
              padding: EdgeInsets.symmetric(vertical: 20),
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 20), child: NUIcon(IconName.headCommunity)),
                CommunityContentWidget(
                  onTap: (e) => model.setSelectContent(e),
                  selecedContent: (e) => model.selecedContent(e),
                ),
                if (model.communityList?.isNotEmpty ?? false)
                  ...model.communityList!
                      .asMap()
                      .map(
                        (index, element) => MapEntry(
                          index,
                          GestureDetector(
                            onTap: () => context.navigatorProvider.pushToDetailPost(post: element),
                            child: Container(
                              height: 125,
                              padding: EdgeInsets.all(16),
                              margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              decoration: BoxDecoration(
                                color: whiteColor,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  NUIcon(
                                    profile(context),
                                    height: 50,
                                  ),
                                  SizedBox(width: 4),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: 8),
                                        NUText(
                                          text: element.userName,
                                          maxLines: 1,
                                          textStyle: nuTextStyle(
                                            context: context,
                                            typography: TextStyleTypography.simpleTextStyle,
                                            fontWeight: TextStyleWeight.semiBold,
                                          ),
                                        ),
                                        SizedBox(height: 16),
                                        NUText(
                                          text: element.post,
                                          maxLines: 1,
                                          textStyle: nuTextStyle(
                                              context: context, typography: TextStyleTypography.simpleTextStyle),
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            NUText(
                                              text: element.createTime.toFormat(locale: context.locale.languageCode),
                                              textStyle: nuTextStyle(
                                                context: context,
                                                typography: TextStyleTypography.smallTextStyle,
                                                colorFont: TextStyleColor.disableColor,
                                              ),
                                            ),
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.message_outlined,
                                                  size: 20,
                                                  color: disableColor,
                                                ),
                                                SizedBox(width: 4),
                                                NUText(
                                                  text: element.countComment.toString(),
                                                  isTranslate: false,
                                                  textStyle: nuTextStyle(
                                                    context: context,
                                                    colorFont: TextStyleColor.disableColor,
                                                  ),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .values
                else
                  SizedBox(
                    height: context.mediaSize.height / 2,
                    child: Center(
                      child: NUText(
                        text: 'community.enter_post',
                        textStyle: nuTextStyle(
                          context: context,
                          typography: TextStyleTypography.smallTextStyle,
                          colorFont: TextStyleColor.disableColor,
                        ),
                      ),
                    ),
                  ),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 20,
              child: GestureDetector(
                onTap: () => context.navigatorProvider.pushToCreatePost(),
                child: NUIcon(
                  IconName.profileStaff1,
                  width: 50,
                ),
              ),
            ),
            NULoadingScreen(visible: model.busy),
          ],
        );
      },
    );
  }
}
