import 'dart:async';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';

class PasswordLockScreenController extends GetxController {
  late int currentIndex;
  late int numberOfPage;
  late final StreamController<bool> verificationNotifier;
  backPage() {
    print("========== PressedCancel ==========");
    Get.back();
  }

  onPasscodeEntered(String enteredPasscode) {
    print("========== enteredPasscode ========== $enteredPasscode");
    Get.toNamed(AppRoutes.confirmPasswordlockScreen, arguments: {
      "passcode": enteredPasscode,
      "StreamController": verificationNotifier,
      "currentindex": currentIndex + 1,
      "numberofpage": numberOfPage,
    });
  }

  @override
  void onInit() {
    numberOfPage = Get.previousRoute == "/" ? 2 : Get.arguments['numberofpage'];
    currentIndex = Get.previousRoute == "/" ? 0 : Get.arguments['currentindex'];
    verificationNotifier = numberOfPage == 3
        ? Get.arguments['StreamController']
        : StreamController<bool>.broadcast();
    print("========== currentIndex ========== $currentIndex");
    print("========== numberOfPage ========== $numberOfPage");
    // TODO: implement onInit
    super.onInit();
  }
}
