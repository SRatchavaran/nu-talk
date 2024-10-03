import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/widget/textstyle.dart';

InputDecoration textFieldInputDecoration(BuildContext context, {required String hintText}) {
  return InputDecoration(
    hintText: hintText,
    hintStyle: customTextStyle(context: context, colorFont: TextStyleColor.disableColor),
    focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: whiteColor, width: 35.0), borderRadius: BorderRadius.circular(18)),
    //SizedBox(height: 1),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(color: whiteColor, width: 35.0),
      borderRadius: BorderRadius.circular(18),
    ),
  );
}
