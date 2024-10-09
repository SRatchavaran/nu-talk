import 'package:flutter/widgets.dart';
import 'package:nutalk/base/base_extension.dart';
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
        return Column(
          children: [
            SizedBox(height: 36),
            NUIcon(IconName.headMap, width: context.mediaSize.width - 50),
            SizedBox(height: 15),
            Expanded(
              child: Stack(
                children: [
                  NUIcon(IconName.mapNU),
                  Positioned(top: 5, right: 0, child: NUIcon(IconName.subMap1, height: 110)),
                  Positioned(top: 120, right: 10, child: NUIcon(IconName.subMap2, height: 65)),
                  Positioned(bottom: 110, left: 5, child: NUIcon(IconName.subMap3, height: 75)),
                  Positioned(bottom: 30, right: 0, left: 0, child: NUIcon(IconName.subMap4, height: 55)),
                ],
              ),
            ),
            SizedBox(height: 36),
          ],
        );
      },
    );
  }
}
