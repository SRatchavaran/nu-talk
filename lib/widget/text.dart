import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class NUText extends StatelessWidget {
  final TextStyle? textStyle;
  final bool isTranslate;
  final String text;
  final String? customText;
  final int? maxLines;
  const NUText({
    required this.text,
    this.isTranslate = true,
    this.textStyle,
    this.customText,
    this.maxLines,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      isTranslate ? tr(text) + (customText ?? '') : text + (customText ?? ''),
      style: textStyle,
      maxLines: maxLines,
      overflow: TextOverflow.ellipsis,
    );
  }
}
