import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';

import '../core/constant/appcolor.dart';
import '../core/services/myservices.dart';

class ConfirmPasswordLockScreenController extends GetxController {
  late int numberOfPage;

  late int currentIndex;
  late String passCode;
  MyServices myServices = Get.find();

  late final StreamController<bool> verificationNotifier;
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
    if (enteredPasscode == passCode) {
      print("============================================================");
      print(
          "============================================================Valid");
      verificationNotifier.add(true);
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

    print("============================================================");
    print(
        "=====================================passCode=======================$passCode");
    print("============================================================");
    print(
        "=====================================currentIndex=======================$currentIndex");
    print("============================================================");
    print(
        "=====================================numberOfPage=======================$numberOfPage");
    // TODO: implement onInit
    super.onInit();
  }
}
