import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/widget/text.dart';
import 'package:nutalk/widget/textstyle.dart';

enum Community { general, learn, relatinoship, living, finance }

class CommunityContent {
  String title;
  Community community;
  CommunityContent({required this.community, required this.title});
}

List<CommunityContent> contentList = [
  CommunityContent(community: Community.general, title: ('community.content.head1')),
  CommunityContent(community: Community.learn, title: ('community.content.head2')),
  CommunityContent(community: Community.relatinoship, title: ('community.content.head3')),
  CommunityContent(community: Community.living, title: ('community.content.head4')),
  CommunityContent(community: Community.finance, title: ('community.content.head5')),
];

class CommunityContentWidget extends StatelessWidget {
  final Function(CommunityContent) onTap;
  final Function(CommunityContent) selecedContent;
  const CommunityContentWidget({required this.onTap, required this.selecedContent, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      height: 40,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: contentList.map(
          (e) {
            bool isSelected() => selecedContent(e) != null;
            return GestureDetector(
              onTap: () => onTap(e),
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 12),
                margin: EdgeInsets.only(left: e.community.index == 0 ? 12 : 8, right: e.community.index == 4 ? 12 : 0),
                decoration: BoxDecoration(
                  color: isSelected() ? primaryColor(context) : whiteColor,
                  border: Border.all(color: primaryColor(context), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Center(
                  child: NUText(
                    text: e.title,
                    textStyle: nuTextStyle(
                      context: context,
                      typography: TextStyleTypography.simpleTextStyle,
                      customColor: primartTextColor(context),
                      fontWeight: isSelected() ? TextStyleWeight.black : TextStyleWeight.normal,
                    ),
                  ),
                ),
              ),
            );
          },
        ).toList(),
      ),
    );
  }
}
