import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';

class NULoadingScreen extends StatelessWidget {
  final bool visible;
  const NULoadingScreen({required this.visible, super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        color: black12Color.withOpacity(0.3),
        child: Center(
          child: CircularProgressIndicator(color: primartTextColor(context)),
        ),
      ),
    );
  }
}
