import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import '../core/constant/appcolor.dart';
import '../core/shared/customtext.dart';

class RePatternLockScreenController extends GetxController {
  int numberOfPage = 3;
  int currentIndex = 0;
  late String storedPatterncode;
  onPatterncodeEntered(List<int> enteredPatterncode) async {
    print("============================================================");
    print(
        "=====================================enteredPatterncode=======================${enteredPatterncode.map((i) => i.toString()).join("")}");
    if (enteredPatterncode.map((i) => i.toString()).join("") ==
        storedPatterncode) {
      print("============================================================");
      print(
          "============================================================Valid");
      Get.toNamed(AppRoutes.patternlockScreen, arguments: {
        "numberofpage": numberOfPage,
        "currentindex": currentIndex + 1,
      });
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
    storedPatterncode = Get.arguments['storedpatterncode'];
    print("============================================================");
    print(
        "=====================================storedPatterncode=======================$storedPatterncode");
    // TODO: implement onInit
    super.onInit();
  }
}
