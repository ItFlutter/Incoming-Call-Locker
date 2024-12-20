import 'dart:async';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';

class RePasswordLockScreenController extends GetxController {
  int numberOfPage = 3;
  int currentIndex = 0;
  late String storedPassCode;

  final StreamController<bool> verificationNotifier =
      StreamController<bool>.broadcast();
  backPage() {
    print("========== PressedCancel ==========");
    Get.back();
  }

  onPasscodeEntered(String enteredPasscode) async {
    print("========== enteredPasscode ========== $enteredPasscode");
    if (enteredPasscode == storedPassCode) {
      print("========== Valid ==========");
      // verificationNotifier.add(true);
      Get.toNamed(AppRoutes.passwordlockScreen, arguments: {
        "numberofpage": numberOfPage,
        "StreamController": verificationNotifier,
        "currentindex": currentIndex + 1,
      });
    } else {
      print("========== NotValid ==========");
      verificationNotifier.add(false);
    }
  }

  // goToPagePasswordLock() {}

  @override
  void onInit() {
    storedPassCode = Get.arguments['storedpasscode'];
    print("========== storedPassCode ========== $storedPassCode");
    // TODO: implement onInit
    super.onInit();
  }
}
