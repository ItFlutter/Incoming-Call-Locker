import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';
import 'package:incoming_call_locker/view/widget/dialogs/dialogs.dart';
import '../core/services/my_services.dart';

class ConfirmPatternLockScreenController extends GetxController {
  late int numberOfPage;
  late int currentIndex;
  late String patterncode;

  MyServices myServices = Get.find();
  onPatterncodeEntered(List<int> enteredPatterncode) async {
    print(
        "========== enteredPatterncode ========== ${enteredPatterncode.map((i) => i.toString()).join("")}");
    if (patterncode == enteredPatterncode.map((i) => i.toString()).join("")) {
      print("========== Valid ==========");
      await myServices.sharedPreferences
          .setString("storedpatterncode", patterncode);
      await myServices.sharedPreferences.remove("storedpasscode");
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      print("========== NotValid ==========");
      await Dialogs.showDialog('Error', "Patterncodes do not match!",
          fontSizeMiddleText: 24.sp, isShowCancleButton: true);
    }
  }

  @override
  void onInit() {
    patterncode = Get.arguments['patterncode'];
    currentIndex = Get.arguments['currentindex'];
    numberOfPage = Get.arguments['numberofpage'];
    print("========== patterncode ========== $patterncode");
    print("========== currentIndex ========== $currentIndex");
    print("========== numberOfPage ========== $numberOfPage");
    // TODO: implement onInit
    super.onInit();
  }
}
