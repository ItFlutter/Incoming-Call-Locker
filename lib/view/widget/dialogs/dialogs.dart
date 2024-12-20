import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';

class Dialogs {
  static void showDialogWithTwoButtonsCancelAndConfirm(
      String title, String middleText,
      {void Function()? onConfirm, void Function()? onCancel}) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      title: title,
      middleText: middleText,
      middleTextStyle: TextStyle(
        fontSize: 18.sp,
      ),
      textConfirm: "Grant",
      textCancel: "Cancel",
      onConfirm: onConfirm,
      onCancel: onCancel,
      // confirmTextColor: AppColor.blackColor,
      // cancelTextColor: AppColor.blackColor,
      // buttonColor: AppColor.blueColor,
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: AppColor.redColor),
    );
  }

  static showDialog(String title, String middleText,
      {Color? titleColor,
      bool isShowCancleButton = false,
      double? fontSizeMiddleText}) {
    Get.defaultDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 5.w),
      title: title,
      middleText: middleText,
      cancel: isShowCancleButton
          ? InkWell(
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
            )
          : null,
      middleTextStyle: TextStyle(
        fontSize: fontSizeMiddleText,
      ),
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, color: titleColor ?? AppColor.redColor),
    );
  }
}
