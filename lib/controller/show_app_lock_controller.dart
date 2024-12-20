import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import '../main.dart';

class ShowAppLockController extends GetxController {
  StreamController<bool> verificationNotifier =
      StreamController<bool>.broadcast();
  late String storedPassCode;
  late String storedPatternCode;

  onPatterncodeEntered(List<int> enteredPatterncode) async {
    if (enteredPatterncode.map((i) => i.toString()).join("") ==
        storedPatternCode) {
      print("========== Valid ==========");
      await FlutterOverlayWindow.closeOverlay();
    } else {
      print("========== NotValid ==========");
      Get.snackbar("Error", "The pattern not correct",
          backgroundColor: AppColor.whiteColor,
          margin: EdgeInsets.symmetric(
              vertical: Get.height / 15, horizontal: Get.width / 27));
    }
  }

  onPasscodeEntered(String enteredPasscode) async {
    print("========== enteredPasscode ========== $enteredPasscode");
    if (enteredPasscode == storedPassCode) {
      print("========== Valid ==========");
      await FlutterOverlayWindow.closeOverlay();
    } else {
      print("========== NotValid ==========");
      Get.snackbar("Error", "The password not correct",
          backgroundColor: AppColor.whiteColor,
          margin: EdgeInsets.symmetric(
              vertical: Get.height / 15, horizontal: Get.width / 27));
      verificationNotifier.add(false);
    }
  }

  @override
  void onInit() async {
    storedPatternCode = sharedPref!.getString("storedpatterncode") ?? "";
    storedPassCode = sharedPref!.getString("storedpasscode") ?? "";
    print("========== storedPassword ========== $storedPassCode");
    print("========== storedPattern ========== $storedPatternCode");
    FlutterOverlayWindow.overlayListener.listen((event) {
      storedPatternCode = event['storedPatternCode'];
      storedPassCode = event['storedPassCode'];
      print("========== shareDataBetweenOverlayAndMainApp ==========");
      print("storedPatternCode: ${event['storedPatternCode']}");
      print("storedPassCode: ${event['storedPassCode']}");
      // Get.delete<ShowAppLockController>();
      if (event['resetstreamcontroller'] == true) {
        verificationNotifier.add(false);
        print("========== resetstreamcontroller ==========");
      }
      update();
    });
    // ==================?????=======================
    String callerNumber = sharedPref!.getString('caller_number') ?? '';
    String callerName = sharedPref!.getString('caller_name') ?? '';
    if (callerNumber.isNotEmpty && callerName.isNotEmpty) {
      verificationNotifier.add(false);
    }
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    verificationNotifier.close();
    super.onClose();
  }
}
