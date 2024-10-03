part of 'package:nutalk/constant.dart';

const primaryTheme1 = Color(0xfffceb91);
const secondaryTheme1 = Color(0xffdcedff);

const primaryTheme2 = Color(0xffc3c7e2);
const secondaryTheme2 = Color(0xffe7d3d3);

const primaryTheme3 = Color(0xffeaafae);
const secondaryTheme3 = Color(0xffbdc18c);

const primaryTheme4 = Color(0xffd6965a);
const secondaryTheme4 = Color(0xfffff4d1);

const primaryTheme5 = Color(0xffeaafae);
const secondaryTheme5 = Color(0xffdeecfd);

const disableColor = Color(0xff8c8c8c);
const whiteColor = Color(0xffffffff);
const blackColor = Color(0xff000000);
const black54Color = Color(0xff343434);
const black12Color = Color(0xff979797);
const redColor = Color(0xfffd450d);

const primaryText = Color(0xff080044);
const secondaryText = Color(0xff6465a4);

const blackTheme1 = Color(0x50dcedff);
const blackTheme2 = Color(0x50e7d3d3);
const blackTheme3 = Color(0x50bdc18c);
const blackTheme4 = Color(0x50fff4d1);
const blackTheme5 = Color(0xffdeecfd);

Color primaryColor(BuildContext context) {
  var theme = context.provide<MainProvider>(listen: false).theme;
  switch (theme) {
    case CustomTheme.theme1:
      return primaryTheme1;
    case CustomTheme.theme2:
      return primaryTheme2;
    case CustomTheme.theme3:
      return primaryTheme3;
    case CustomTheme.theme4:
      return primaryTheme4;
    case CustomTheme.theme5:
      return primaryTheme5;
    default:
      return primaryTheme1;
  }
}

Color secondaryColor(BuildContext context) {
  var theme = context.provide<MainProvider>(listen: false).theme;
  switch (theme) {
    case CustomTheme.theme1:
      return secondaryTheme1;
    case CustomTheme.theme2:
      return secondaryTheme2;
    case CustomTheme.theme3:
      return secondaryTheme3;
    case CustomTheme.theme4:
      return secondaryTheme4;
    case CustomTheme.theme5:
      return secondaryTheme5;
    default:
      return secondaryTheme1;
  }
}

Color blackThemeColor(BuildContext context) {
  var theme = context.provide<MainProvider>(listen: false).theme;
  switch (theme) {
    case CustomTheme.theme1:
      return blackTheme1;
    case CustomTheme.theme2:
      return blackTheme2;
    case CustomTheme.theme3:
      return blackTheme3;
    case CustomTheme.theme4:
      return blackTheme4;
    case CustomTheme.theme5:
      return blackTheme5;
    default:
      return blackTheme1;
  }
}
