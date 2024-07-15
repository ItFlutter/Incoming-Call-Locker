import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';

import '../core/constant/appcolor.dart';
import '../core/shared/customtext.dart';

class RePasswordLockScreenController extends GetxController {
  int numberOfPage = 3;
  int currentIndex = 0;
  late String storedPassCode;

  final StreamController<bool> verificationNotifier =
      StreamController<bool>.broadcast();
  backPage() {
    print("============================================================");
    print(
        "============================================================PressedCancel");
    Get.back();
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
      Get.toNamed(AppRoutes.passwordlockScreen, arguments: {
        "numberofpage": numberOfPage,
        "StreamController": verificationNotifier,
        "currentindex": currentIndex + 1,
      });
    } else {
      print("============================================================");
      print(
          "============================================================NotValid");
      await Get.defaultDialog(
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
        title: "Error",
        middleText: "Passcodes do not match!",
        cancel: InkWell(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 30.h),
            child: Container(
                alignment: Alignment.bottomRight,
                child: CustomText(
                  text: "Try again",
                  color: AppColor.blueColor,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                )),
          ),
        ),
        middleTextStyle: TextStyle(
          fontSize: 24.sp,
        ),
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.redColor),
      );

      verificationNotifier.add(false);
    }
  }

  // goToPagePasswordLock() {}

  @override
  void onInit() {
    storedPassCode = Get.arguments['storedpasscode'];
    print("============================================================");
    print(
        "=====================================storedPassCode=======================$storedPassCode");
    // TODO: implement onInit
    super.onInit();
  }
}
