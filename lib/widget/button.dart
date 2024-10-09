import 'package:flutter/material.dart';
import 'package:nutalk/widget/text.dart';
import 'package:nutalk/widget/textstyle.dart';

class NUButton extends StatelessWidget {
  final VoidCallback? onTap;
  final Widget? child;
  final String? text;
  final TextStyle? textStyle;
  final Color? customColor;
  final EdgeInsetsGeometry? padding;
  final double radius;
  const NUButton({
    this.onTap,
    this.child,
    this.text,
    this.textStyle,
    this.customColor,
    this.padding = EdgeInsets.zero,
    this.radius = 0,
    super.key,
  }) : assert((child == null || text == null));

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child ??
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: customColor ?? Colors.transparent,
              borderRadius: BorderRadius.circular(radius),
            ),
            child: Center(
              child: NUText(
                text: text ?? '',
                textStyle: textStyle ?? nuTextStyle(context: context, typography: TextStyleTypography.smallTextStyle),
              ),
            ),
          ),
    );
  }
}
