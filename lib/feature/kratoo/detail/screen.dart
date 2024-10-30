import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/base/base_widget.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/kratoo/detail/viewmodel.dart';
import 'package:nutalk/main.dart';
import 'package:nutalk/model/community/post_community_model.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/icon.dart';
import 'package:nutalk/widget/text.dart';
import 'package:nutalk/widget/textstyle.dart';
import 'package:nutalk/widget/user_profile.dart';

class DetailPostArguments {
  final PostCommunityModel detail;

  DetailPostArguments({required this.detail});
}

class DetailPostScreen extends StatelessWidget {
  const DetailPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var arguments = context.settingsArguments as DetailPostArguments?;
    if (arguments == null) {
      return Container();
    }
    return BaseWidget<DetailPostViewModel>(
      model: DetailPostViewModel(post: arguments.detail),
      onModelReady: (model) {},
      onPageResume: (model) {},
      builder: (context, model, _) {
        return Stack(
          children: [
            Container(
              color: whiteColor,
              width: context.mediaSize.width,
              height: context.mediaSize.height,
            ),
            Scaffold(
              backgroundColor: secondaryColor(context).withOpacity(0.5),
              appBar: AppBar(
                systemOverlayStyle: SystemUiOverlayStyle.dark,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: Colors.transparent,
                leading: GestureDetector(
                  onTap: () => context.navigatorProvider.pop(),
                  child: Icon(
                    Icons.keyboard_arrow_left,
                    color: primaryColor(context),
                  ),
                ),
              ),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NUIcon(
                          profile(context),
                          width: 50,
                          height: 50,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            NUText(
                              text: model.post.userName,
                              isTranslate: false,
                              textStyle: nuTextStyle(
                                context: context,
                                typography: TextStyleTypography.headTextStyle,
                              ),
                            ),
                            SizedBox(height: 2),
                            NUText(
                              text: model.post.createTime.toFormat(),
                              isTranslate: false,
                              textStyle: nuTextStyle(
                                context: context,
                                typography: TextStyleTypography.smallTextStyle,
                                colorFont: TextStyleColor.disableColor,
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: NUText(
                      text: model.post.post,
                      isTranslate: false,
                      maxLines: 30,
                      textStyle: nuTextStyle(
                        context: context,
                        typography: TextStyleTypography.simpleTextStyle,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 12),
                    color: blackThemeColor(context),
                    height: 2,
                    width: context.mediaSize.width,
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
