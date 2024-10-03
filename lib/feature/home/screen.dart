import 'package:flutter/widgets.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/home/viewmodel.dart';

import '../../base/base_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseWidget<HomeViewModel>(
      model: HomeViewModel(),
      onModelReady: (model) {},
      onPageResume: (model) {},
      builder: (context, model, _) {
        return Container(color: secondaryColor(context), child: const Center(child: Text('data')));
      },
    );
  }
}
