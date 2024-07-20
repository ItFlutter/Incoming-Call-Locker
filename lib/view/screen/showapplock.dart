import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/showapplock_controller.dart';
import '../widget/patternlock/patternlockwidget.dart';

class ShowAppLock extends StatelessWidget {
  const ShowAppLock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(ShowAppLockController());

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: GetBuilder<ShowAppLockController>(
          builder: (controller) {
            return controller.storedPatternCode.isNotEmpty
                ? PatternLockWidget(onInputComplete: (List<int> input) {
                    controller.onPatterncodeEntered(input);
                  })
                : Container();
          },
        ),
      ),
    );
  }
}
