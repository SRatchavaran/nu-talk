import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/widget/textstyle.dart';

class NUTextField extends StatelessWidget {
  final String? errorText;
  final TextEditingController? controller;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Widget? label;
  final TextStyle? style;
  final TextStyle? labelStyle;
  final TextStyle? floatingLabelStyle;
  final TextStyle? focusFloatingLabelStyle;
  final TextStyle? errorStyle;
  final TextStyle? errorFloatingLabelStyle;
  final String? labelText;
  final Color? borderColor;
  final Color? focusColor;
  final Color? errorColor;
  final Color? cursorColor;
  final Color? backgroundColor;
  final Color? fillColor;
  final Color? disableColor;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final GestureTapCallback? onTap;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onEditingComplete;
  final VoidCallback? onNeedNotifyListeners;
  final int? maxLines;
  final int? minLines;
  final bool expands;
  final int? maxLength;
  final bool enabled;
  final bool readOnly;
  final double height;
  final bool forceError;
  final double? baseline;
  final String? hintText;
  final TextStyle? hintStyle;
  final bool autocorrect;
  final double paddingLeft;
  final double paddingRight;
  final TextAlign textAlign;
  final Widget? trailing;
  final double borderRadius;
  final bool showErr;
  final bool autoFocus;
  final Widget? prefixIcon;
  final bool obscureText;

  const NUTextField({
    required this.controller,
    this.errorText,
    this.textInputAction,
    this.focusNode,
    this.label,
    this.style,
    this.labelStyle,
    this.floatingLabelStyle,
    this.focusFloatingLabelStyle,
    this.errorStyle,
    this.errorFloatingLabelStyle,
    this.labelText,
    this.borderColor,
    this.focusColor,
    this.cursorColor,
    this.backgroundColor,
    this.fillColor,
    this.errorColor,
    this.disableColor,
    this.inputFormatters,
    this.keyboardType,
    this.onTap,
    this.onChanged,
    this.onEditingComplete,
    this.onNeedNotifyListeners,
    this.maxLength,
    this.expands = false,
    this.maxLines = 1,
    this.minLines,
    this.enabled = true,
    this.readOnly = false,
    this.height = 52,
    this.forceError = false,
    this.baseline,
    this.hintText,
    this.hintStyle,
    this.autocorrect = true,
    this.paddingLeft = 24,
    this.paddingRight = 24,
    this.textAlign = TextAlign.start,
    this.trailing,
    this.borderRadius = 16,
    this.showErr = false,
    this.prefixIcon,
    this.autoFocus = false,
    this.obscureText = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var isFocus = focusNode?.hasPrimaryFocus ?? false;

    var isError = (errorText != null && errorText!.isNotEmpty) || forceError;

    var lineColor = showErr
        ? errorColor ?? redColor
        : !enabled
            ? borderColor ?? black12Color
            : isFocus
                ? focusColor ?? primaryTheme1
                : isError
                    ? errorColor ?? redColor
                    : borderColor ?? black12Color.withOpacity(0.2);

    var fillBackgroundColor = !enabled
        ? disableColor ?? black12Color
        : isFocus
            ? fillColor ?? backgroundColor ?? Colors.transparent //kPrimaryColor(context).withOpacity(0.1)
            : backgroundColor ?? Colors.transparent;

    var defaultLabelStyle = nuTextStyle(
        context: context, typography: TextStyleTypography.simpleTextStyle, colorFont: TextStyleColor.disableColor);

    var defaultFloatingLabelStyle = nuTextStyle(
        context: context, typography: TextStyleTypography.smallTextStyle, colorFont: TextStyleColor.disableColor);

    var defaultFocusFloatingLabelStyle = nuTextStyle(
      context: context,
      typography: TextStyleTypography.smallTextStyle,
    );

    var defaultErrorFloatingLabelStyle = nuTextStyle(
        context: context, typography: TextStyleTypography.smallTextStyle, colorFont: TextStyleColor.errorColor);

    var defaultHintStyle = nuTextStyle(
        context: context, typography: TextStyleTypography.smallTextStyle, colorFont: TextStyleColor.disableColor);

    return Material(
      color: Colors.transparent,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: height,
            padding: EdgeInsets.only(
              left: paddingLeft,
              right: paddingRight,
            ),
            decoration: BoxDecoration(
              color: fillBackgroundColor,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(
                color: lineColor,
                width: 2,
              ),
            ),
            child: Baseline(
              baseline: baseline ?? height * 0.70,
              baselineType: TextBaseline.alphabetic,
              child: TextFormField(
                readOnly: readOnly,
                controller: controller,
                textInputAction: textInputAction,
                obscureText: obscureText,
                textAlign: textAlign,
                onTap: (onTap != null) || (onNeedNotifyListeners != null)
                    ? () {
                        if (onTap != null) {
                          onTap!();
                        }

                        if (onNeedNotifyListeners != null) {
                          onNeedNotifyListeners!();
                        }
                      }
                    : null,
                onEditingComplete: (onEditingComplete != null) || (onNeedNotifyListeners != null)
                    ? () {
                        if (onEditingComplete != null) {
                          onEditingComplete!();
                        }

                        if (onNeedNotifyListeners != null) {
                          onNeedNotifyListeners!();
                        }
                      }
                    : null,
                onChanged: onChanged,
                focusNode: focusNode,
                autofocus: autoFocus,
                inputFormatters: inputFormatters,
                cursorColor: cursorColor ?? primaryTheme1,
                style: style ??
                    nuTextStyle(
                      context: context,
                      typography: TextStyleTypography.simpleTextStyle,
                    ),
                keyboardType: keyboardType,
                autocorrect: autocorrect,
                maxLength: maxLength,
                expands: expands,
                maxLines: maxLines,
                minLines: minLines,
                buildCounter: (
                  _, {
                  required currentLength,
                  required isFocused,
                  maxLength,
                }) =>
                    null,
                enabled: enabled,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText,
                  hintStyle: hintStyle ?? defaultHintStyle,
                  label: label,
                  labelStyle: labelStyle ?? defaultLabelStyle,
                  labelText: labelText,
                  floatingLabelStyle: !enabled
                      ? (floatingLabelStyle ?? defaultFloatingLabelStyle)
                      : isFocus
                          ? (focusFloatingLabelStyle ?? defaultFocusFloatingLabelStyle)
                          : isError
                              ? (errorFloatingLabelStyle ?? defaultErrorFloatingLabelStyle)
                              : (floatingLabelStyle ?? defaultFocusFloatingLabelStyle),
                  border: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  disabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  errorBorder: const UnderlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                  prefixIconConstraints: const BoxConstraints(
                    maxHeight: 40,
                    maxWidth: 40,
                  ),
                  prefixIcon: prefixIcon,
                  suffixIconConstraints: const BoxConstraints(
                    maxHeight: 40,
                    maxWidth: 40,
                  ),
                ),
              ),
            ),
          ),
          if (showErr || (enabled && isError && !isFocus && (errorText?.isNotEmpty ?? false))) ...[
            const SizedBox(height: 4),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Text(
                errorText!,
                style: errorStyle ?? defaultErrorFloatingLabelStyle,
              ),
            )
          ]
        ],
      ),
    );
  }
}
