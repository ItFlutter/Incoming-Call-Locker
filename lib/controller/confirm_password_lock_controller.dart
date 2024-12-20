import 'dart:async';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';
import '../core/services/my_services.dart';

class ConfirmPasswordLockScreenController extends GetxController {
  late int numberOfPage;
  late int currentIndex;
  late String passCode;
  MyServices myServices = Get.find();
  late final StreamController<bool> verificationNotifier;

  backPage() {
    print("========== PressedCancel ==========");
    Get.back();
  }

  onPasscodeEntered(String enteredPasscode) async {
    print("========== enteredPasscode ========== $enteredPasscode");
    if (enteredPasscode == passCode) {
      print("========== Valid ==========");
      verificationNotifier.add(true);
    } else {
      print("========== NotValid ==========");
      verificationNotifier.add(false);
    }
  }

  savePassCodeAndGoHomeScreen() async {
    await myServices.sharedPreferences.setString("storedpasscode", passCode);
    await myServices.sharedPreferences.remove("storedpatterncode");

    Get.offAllNamed(AppRoutes.homeScreen);
  }

  @override
  void onInit() {
    verificationNotifier = Get.arguments['StreamController'];
    passCode = Get.arguments['passcode'];
    currentIndex = Get.arguments['currentindex'];
    numberOfPage = Get.arguments['numberofpage'];
    print("========== passCode ========== $passCode");
    print("========== currentIndex ========== $currentIndex");
    print("========== numberOfPage ========== $numberOfPage");
    // TODO: implement onInit
    super.onInit();
  }
}
