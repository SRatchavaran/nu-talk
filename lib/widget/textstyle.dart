import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';

enum TextStyleColor {
  primaryColor,
  secondaryColor,
}

enum TextStyleSize { s12, s16, s17, s19, s20, s24, s45 }

enum TextStyleWeight { thin, extraLight, light, normal, medium, semiBold, bold, extraBold, black }

extension TextStyleColorExtension on TextStyleColor {
  Color? toColor(BuildContext context) {
    switch (this) {
      case TextStyleColor.primaryColor:
        return primaryText;

      case TextStyleColor.secondaryColor:
        return secondaryText;

      default:
        return null;
    }
  }
}

extension TextStyleWeightExtension on TextStyleWeight {
  FontWeight get toFontWeight {
    switch (this) {
      case TextStyleWeight.thin:
        return FontWeight.w100;

      case TextStyleWeight.extraLight:
        return FontWeight.w200;

      case TextStyleWeight.light:
        return FontWeight.w300;

      case TextStyleWeight.normal:
        return FontWeight.w400;

      case TextStyleWeight.medium:
        return FontWeight.w500;

      case TextStyleWeight.semiBold:
        return FontWeight.w600;

      case TextStyleWeight.bold:
        return FontWeight.w700;

      case TextStyleWeight.extraBold:
        return FontWeight.w800;

      case TextStyleWeight.black:
        return FontWeight.w900;
    }
  }
}

extension TextStyleSizeExtension on TextStyleSize {
  double? get toDouble {
    switch (this) {
      case TextStyleSize.s12:
        return 12;

      case TextStyleSize.s16:
        return 16;

      case TextStyleSize.s17:
        return 17;

      case TextStyleSize.s19:
        return 19;

      case TextStyleSize.s20:
        return 20;

      case TextStyleSize.s24:
        return 24;

      case TextStyleSize.s45:
        return 45;

      default:
        return null;
    }
  }
}

enum TextStyleTypography {
  simpleTextStyle,
  simpleTextErrorStyle,
  simpleHeadTextStyle,
  mainTextStyle,
  biggerTextStyle,
  headTextStyle,
  smallTextStyle
}

TextStyle customTextStyle({
  required BuildContext context,
  TextStyleColor? colorFont,
  TextStyleSize? fontSize,
  TextStyleWeight? fontWeight,
  TextStyleTypography? typography,
}) {
  TextStyleSize? size;
  Color? color;
  switch (typography) {
    case TextStyleTypography.biggerTextStyle:
      color = whiteColor;
      size = TextStyleSize.s17;
      break;

    case TextStyleTypography.headTextStyle:
      color = blackColor;
      size = TextStyleSize.s20;
      fontWeight = fontWeight ?? TextStyleWeight.bold;
      break;

    case TextStyleTypography.mainTextStyle:
      color = blackColor;
      size = TextStyleSize.s45;
      fontWeight = fontWeight ?? TextStyleWeight.bold;
      break;

    case TextStyleTypography.simpleHeadTextStyle:
      color = blackColor;
      size = TextStyleSize.s19;
      break;

    case TextStyleTypography.simpleTextErrorStyle:
      color = redColor;
      size = TextStyleSize.s16;
      break;

    case TextStyleTypography.simpleTextStyle:
      color = black54Color;
      size = TextStyleSize.s16;
      break;

    case TextStyleTypography.smallTextStyle:
      color = black54Color;
      size = TextStyleSize.s12;
      break;

    default:
      break;
  }
  return TextStyle(
    color: colorFont?.toColor(context) ?? color ?? TextStyleColor.primaryColor.toColor(context),
    fontSize: fontSize?.toDouble ?? size?.toDouble,
    fontWeight: fontWeight?.toFontWeight,
  );
}
