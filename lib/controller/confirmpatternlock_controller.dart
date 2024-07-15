import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';

import '../core/constant/appcolor.dart';
import '../core/services/myservices.dart';

class ConfirmPatternLockScreenController extends GetxController {
  late int numberOfPage;

  late int currentIndex;
  late String patterncode;

  MyServices myServices = Get.find();
  onPatterncodeEntered(List<int> enteredPatterncode) async {
    print("============================================================");
    print(
        "=====================================enteredPatterncode=======================${enteredPatterncode.map((i) => i.toString()).join("")}");
    if (patterncode == enteredPatterncode.map((i) => i.toString()).join("")) {
      print("============================================================");
      print(
          "============================================================Valid");
      await myServices.sharedPreferences
          .setString("storedpatterncode", patterncode);
      await myServices.sharedPreferences.remove("storedpasscode");
      Get.offAllNamed(AppRoutes.homeScreen);
    } else {
      print("============================================================");
      print(
          "============================================================NotValid");
      await Get.defaultDialog(
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
        title: "Error",
        middleText: "Patterncodes do not match!",
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
    }
  }

  @override
  void onInit() {
    patterncode = Get.arguments['patterncode'];
    currentIndex = Get.arguments['currentindex'];
    numberOfPage = Get.arguments['numberofpage'];

    print("============================================================");
    print(
        "=====================================patterncode=======================$patterncode");
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
