import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import 'package:incoming_call_locker/core/services/myservices.dart';

import '../core/constant/appcolor.dart';
import '../core/functions/requestpermission.dart';
import '../core/shared/customtext.dart';

class HomeScreenController extends GetxController with WidgetsBindingObserver {
  late String storedPassCode;
  late String storedPatternCode;
  MyServices myServices = Get.find();
  bool isDisplayOverOtherAppsGranted = false;
  bool isPhoneAndCallLogPermissionsGranted = false;
  bool activeSwitchLock = false;
  // String selectedLockType = "Passcode";
  // String textSwitchLock = "Disable Lock";
  onClickSwitchLock(bool value) async {
    if (storedPassCode.isEmpty && storedPatternCode.isEmpty) {
      await Get.defaultDialog(
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
        title: "Error",
        middleText: "Please set any types of lock before enable locker app",
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
          fontSize: 18.sp,
        ),
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.redColor),
      );
    } else {
      activeSwitchLock = !activeSwitchLock;
      print("============================================================");
      print(
          "=====================================activeSwitchLock=======================$activeSwitchLock");
    }
    update();
  }

  // onChangedLockType(String value) {
  //   selectedLockType = value;
  //   print("============================================================");
  //   print(
  //       "=====================================selectedLockType=======================$selectedLockType");
  //   update();
  // }

  requestPhoneAndCallLogsPermissions() async {
    isPhoneAndCallLogPermissionsGranted = await requestPermission();
    print("============================================================");
    print(
        "=====================================isPhoneAndCallLogPermissionsGranted=======================$isPhoneAndCallLogPermissionsGranted");
    update();
  }

  checkPhoneAndCallLogsPermissions() async {
    isPhoneAndCallLogPermissionsGranted == false
        ? requestPhoneAndCallLogsPermissions()
        : Get.defaultDialog(
            title: "Success",
            middleText: "The permissions are granted.",
            titleStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColor.greenColor),
          );

    update();
  }

  goToPagePasswordLock() {
    if (storedPassCode.isEmpty) {
      Get.toNamed(AppRoutes.passwordlockScreen);
    } else {
      Get.toNamed(AppRoutes.rePasswordlockScreen,
          arguments: {"storedpasscode": storedPassCode});
    }
  }

  goToPagePatternLock() {
    if (storedPatternCode.isEmpty) {
      Get.toNamed(AppRoutes.patternlockScreen);
    } else {
      Get.toNamed(AppRoutes.rePatternlockScreen,
          arguments: {"storedpatterncode": storedPatternCode});
    }
  }

  @override
  void onInit() {
    storedPassCode =
        myServices.sharedPreferences.getString("storedpasscode") ?? "";
    print("============================================================");
    print(
        "=====================================storedPassCode=======================$storedPassCode");
    storedPatternCode =
        myServices.sharedPreferences.getString("storedpatterncode") ?? "";
    print("============================================================");
    print(
        "=====================================storedPatternCode=======================$storedPatternCode");
    // myServices.sharedPreferences.clear();

    // WidgetsBinding.instance.addObserver(this);
    requestPhoneAndCallLogsPermissions();
    // TODO: implement onInit
    super.onInit();
  }

  // @override
  // void onClose() {
  //   WidgetsBinding.instance.removeObserver(this);

  //   // TODO: implement onClose
  //   super.onClose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   print(state);
  //   if (state == AppLifecycleState.resumed) {
  //     print("==============================Resumed");
  //   }
  //   // TODO: implement didChangeAppLifecycleState
  //   super.didChangeAppLifecycleState(state);
  // }
}
