import 'package:flutter/material.dart';
import 'package:nutalk/constant.dart';

class LoadingScreen extends StatelessWidget {
  final bool visible;
  const LoadingScreen({required this.visible,super.key});

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: visible,
      child: Container(
        color: black12Color.withOpacity(0.3),
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
