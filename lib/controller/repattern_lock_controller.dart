import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';
import 'package:incoming_call_locker/view/widget/dialogs/dialogs.dart';
import '../core/constant/app_color.dart';
import '../core/shared/custom_text.dart';

class RePatternLockScreenController extends GetxController {
  int numberOfPage = 3;
  int currentIndex = 0;
  late String storedPatterncode;
  onPatterncodeEntered(List<int> enteredPatterncode) async {
    print(
        "========== enteredPatterncode ========== ${enteredPatterncode.map((i) => i.toString()).join("")}");
    if (enteredPatterncode.map((i) => i.toString()).join("") ==
        storedPatterncode) {
      print("========== Valid ==========");
      Get.toNamed(AppRoutes.patternlockScreen, arguments: {
        "numberofpage": numberOfPage,
        "currentindex": currentIndex + 1,
      });
    } else {
      print("========== NotValid ==========");
      await Dialogs.showDialog('Error', "Patterncodes do not match!",
          fontSizeMiddleText: 24.sp, isShowCancleButton: true);
    }
  }

  @override
  void onInit() {
    storedPatterncode = Get.arguments['storedpatterncode'];
    print("========== storedPatterncode ========== $storedPatterncode");
    // TODO: implement onInit
    super.onInit();
  }
}
