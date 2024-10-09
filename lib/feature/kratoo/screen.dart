import 'package:flutter/widgets.dart';
import 'package:nutalk/base/base_widget.dart';
import 'package:nutalk/feature/kratoo/viewmodel.dart';
import 'package:nutalk/feature/kratoo/widget/list_content.dart';
import 'package:nutalk/provider/navigator_provider.dart';
import 'package:nutalk/widget/icon.dart';

class KratooScreen extends StatelessWidget {
  const KratooScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CommunityViewModel>(
      model: CommunityViewModel(context),
      onModelReady: (model) {},
      onPageResume: (model) {},
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
                )
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
            )
          ],
        );
      },
    );
  }
}
