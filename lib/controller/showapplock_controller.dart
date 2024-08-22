import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';

import '../main.dart';

class ShowAppLockController extends GetxController {
  StreamController<bool> verificationNotifier =
      StreamController<bool>.broadcast();
  // late SharedPreferences sharedPref;

  late String storedPassCode;
  late String storedPatternCode;
  // MyServices myServices = Get.find();

  onPatterncodeEntered(List<int> enteredPatterncode) async {
    if (enteredPatterncode.map((i) => i.toString()).join("") ==
        storedPatternCode) {
      print("============================================================");
      print(
          "============================================================Valid");
      // String callerNumber = sharedPref!.getString('caller_number') ?? '';
      // String callerName = sharedPref!.getString('caller_name') ?? '';
      // if (callerNumber.isNotEmpty && callerName.isNotEmpty) {
      //   exit(0);
      // }
      await FlutterOverlayWindow.closeOverlay();
      // if (sharedPref!.getString("startactivity") == "start") {
      //   print(
      //       "===========================App Started From Android Call Ended And pattern valid =================================");
      //   await sharedPref!.remove("startactivity");
      //   print(
      //       "=====================================startactivity=======================${sharedPref!.getString("startactivity")}");
      //   exit(0);
      // }
    } else {
      print("============================================================");
      print(
          "============================================================NotValid");
      Get.snackbar("Error", "The pattern not correct",
          backgroundColor: AppColor.whiteColor,
          margin: EdgeInsets.symmetric(
              vertical: Get.height / 15, horizontal: Get.width / 27));
      // await Get.defaultDialog(
      //   contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
      //   title: "Error",
      //   middleText: "Patterncodes not Correct!",
      //   cancel: InkWell(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 30.h),
      //       child: Container(
      //           alignment: Alignment.bottomRight,
      //           child: CustomText(
      //             text: "Try again",
      //             color: AppColor.blueColor,
      //             fontSize: 12.sp,
      //             fontWeight: FontWeight.w500,
      //           )),
      //     ),
      //   ),
      //   middleTextStyle: TextStyle(
      //     fontSize: 24.sp,
      //   ),
      //   titleStyle: const TextStyle(
      //       fontWeight: FontWeight.bold, color: AppColor.redColor),
      // );
    }
  }

  onPasscodeEntered(String enteredPasscode) async {
    print("============================================================");
    print(
        "=====================================enteredPasscode=======================$enteredPasscode");
    if (enteredPasscode == storedPassCode) {
      print("============================================================");
      print(
          "============================================================Valid");
      // verificationNotifier.add(true);
      // String callerNumber = sharedPref!.getString('caller_number') ?? '';
      // String callerName = sharedPref!.getString('caller_name') ?? '';
      // if (callerNumber.isNotEmpty && callerName.isNotEmpty) {
      //   exit(0);
      // }
      await FlutterOverlayWindow.closeOverlay();
      // SystemNavigator.pop();

      // MyServices myServices = Get.find();
      // print(
      //     "=====================================startactivity=======================$startactivity");
      // if (startactivity== "start") {
      //   print(
      //       "===========================App Started From Android Call Ended And password valid =================================");
      //   await sharedPref!.remove("startactivity");
      //   print(
      //       "=====================================startactivity=======================${sharedPref!.getString("startactivity")}");
      //   SystemNavigator.pop();

      //   // const channel =
      //   //     MethodChannel("com.example.incoming_call_locker/incomingCall");
      //   // try {
      //   //   await channel.invokeMethod('moveToBackground');
      //   // } on PlatformException catch (e) {
      //   //   print("Failed to move app to background: '${e.message}'.");
      //   // }
      // }
    } else {
      print("============================================================");
      print(
          "============================================================NotValid");
      Get.snackbar("Error", "The password not correct",
          backgroundColor: AppColor.whiteColor,
          margin: EdgeInsets.symmetric(
              vertical: Get.height / 15, horizontal: Get.width / 27));
      verificationNotifier.add(false);
    }
  }

  @override
  void onInit() async {
    FlutterOverlayWindow.overlayListener.listen((event) {
      storedPatternCode = event['storedPatternCode'];
      storedPassCode = event['storedPassCode'];
      print(
          "===========================shareDataBetweenOverlayAndMainApp=================================");

      print("storedPatternCode: ${event['storedPatternCode']}");
      print("storedPassCode: ${event['storedPassCode']}");
      // Get.delete<ShowAppLockController>();
      if (event['resetstreamcontroller'] == true) {
        verificationNotifier.add(false);
        print(
            "===========================resetstreamcontroller=================================");
      }
      update();
    });
    String callerNumber = sharedPref!.getString('caller_number') ?? '';
    String callerName = sharedPref!.getString('caller_name') ?? '';
    if (callerNumber.isNotEmpty && callerName.isNotEmpty) {
      verificationNotifier.add(false);
    }
    storedPatternCode = sharedPref!.getString("storedpatterncode") ?? "";

    storedPassCode = sharedPref!.getString("storedpasscode") ?? "";
    print("============================================================");
    print(
        "=====================================storedPassword=======================$storedPassCode");
    print("============================================================");
    print(
        "=====================================storedPattern=======================$storedPatternCode");
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
