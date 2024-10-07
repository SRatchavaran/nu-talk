import 'package:flutter/widgets.dart';
import 'package:nutalk/base/base_extension.dart';
import 'package:nutalk/constant.dart';
import 'package:nutalk/feature/home/viewmodel.dart';
import 'package:nutalk/widget/icon.dart';

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
        return Container(
          color: secondaryColor(context),
          child: Column(
            children: [
              SizedBox(height: 36),
              CustomIcon(IconName.headMap, width: context.mediaSize.width - 50),
              Expanded(
                child: Stack(
                  children: [
                    CustomIcon(IconName.mapNU),
                  ],
                ),
              ),
              SizedBox(height: 36),
            ],
          ),
        );
      },
    );
  }
}
