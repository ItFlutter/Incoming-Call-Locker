import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/class/sqldb.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import 'package:incoming_call_locker/core/services/myservices.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/constant/appcolor.dart';
import '../core/functions/requestreadcontactspermission.dart';
import '../core/functions/requestreadphonestateandcalllogpermissions.dart';
import '../core/shared/customtext.dart';

class HomeScreenController extends GetxController with WidgetsBindingObserver {
  SqlDb sqlDb = Get.find();
  late String storedPassCode;
  late String storedPatternCode;
  MyServices myServices = Get.find();
  bool isDisplayOverOtherAppsGranted = false;
  bool isReadPhoneStateAndCallLogPermissionsGranted = false;
  bool isReadContactsPermissionGranted = false;
  late bool activeSwitchLock;
  // String selectedLockType = "Passcode";
  // String textSwitchLock = "Disable Lock";
  onClickSwitchLock(bool value) async {
    if (isReadPhoneStateAndCallLogPermissionsGranted == false ||
        isReadContactsPermissionGranted == false ||
        isDisplayOverOtherAppsGranted == false) {
      activeSwitchLock = false;

      await myServices.sharedPreferences.remove("lockactivited");
      await Get.defaultDialog(
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
        title: "Error",
        middleText:
            "Please give All permissions to the app and sure give display over app",
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
    } else if (storedPassCode.isEmpty && storedPatternCode.isEmpty) {
      activeSwitchLock = false;
      await myServices.sharedPreferences.remove("lockactivited");
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
      await myServices.sharedPreferences
          .setBool("lockactivited", activeSwitchLock);
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

  checkReadPhoneStateCallLogAndContactsPermissionsHomeScreen() async {
    if (isReadPhoneStateAndCallLogPermissionsGranted == false) {
      requestReadPhoneStateAndCallLogPermissionsHomeScreen();
    }
    if (isReadContactsPermissionGranted == false) {
      requestReadContactsPermissionHomeScreen();
    } else {
      Get.defaultDialog(
        title: "Success",
        middleText: "The permissions are granted.",
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.greenColor),
      );
    }

    update();
  }

  requestReadContactsPermissionHomeScreen() async {
    isReadContactsPermissionGranted = await requestReadContactsPermission();
    print("============================================================");
    print(
        "=====================================isReadContactsPermissionGranted=======================$isReadContactsPermissionGranted");
    update();
  }

  requestReadPhoneStateAndCallLogPermissionsHomeScreen() async {
    isReadPhoneStateAndCallLogPermissionsGranted =
        await requestReadPhoneStateAndCallLogPermissions();
    print("============================================================");
    print(
        "=====================================isReadPhoneStateAndCallLogPermissionsGranted=======================$isReadPhoneStateAndCallLogPermissionsGranted");
    update();
  }

  requestAllPermissions() async {
    await requestReadPhoneStateAndCallLogPermissionsHomeScreen();
    await requestReadContactsPermissionHomeScreen();
  }

  onClickDisplayOverOtherAppsGranted() async {
    isDisplayOverOtherAppsGranted == false
        ? await FlutterOverlayWindow.requestPermission()
        : Get.defaultDialog(
            title: "Success",
            middleText: "The permissions is granted.",
            titleStyle: const TextStyle(
                fontWeight: FontWeight.bold, color: AppColor.greenColor),
          );

    update();
  }

  requestDisplayOverOtherApps() async {
    isDisplayOverOtherAppsGranted =
        await await FlutterOverlayWindow.isPermissionGranted();
    print("============================================================");
    print(
        "=====================================isDisplayOverOtherAppsGranted=======================$isDisplayOverOtherAppsGranted");
    if (isDisplayOverOtherAppsGranted == false) {
      Get.defaultDialog(
        contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
        title: "Warning",
        middleText:
            "The Draw Over Other App is important for this app. Please grant the permission.",
        middleTextStyle: TextStyle(
          fontSize: 18.sp,
        ),
        onCancel: () {
          Get.back();
        },
        textCancel: "Cancel",
        onConfirm: () async {
          Get.back();
          await FlutterOverlayWindow.requestPermission();
        },
        textConfirm: "Grant",
        confirmTextColor: AppColor.greenColor,
        cancelTextColor: AppColor.redColor,
        buttonColor: AppColor.whiteColor,
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.redColor),
      );
    }
    update();
  }

  checkReadPhoneStateCallLogAndContactsPermissionsWhenAppStateResumed() async {
    isReadContactsPermissionGranted = await Permission.contacts.isGranted;
    isReadPhoneStateAndCallLogPermissionsGranted =
        await Permission.phone.isGranted;
    update();
  }

  checkDisplayOverOtherAppsGranted() async {
    isDisplayOverOtherAppsGranted =
        await FlutterOverlayWindow.isPermissionGranted();

    update();
  }
  // checkDisplayOverOtherAppsGranted() async {
  //   isDisplayOverOtherAppsGranted == false
  //       ? await FlutterOverlayWindow.requestPermission()
  //       : Get.defaultDialog(
  //           title: "Success",
  //           middleText: "The permissions are granted.",
  //           titleStyle: const TextStyle(
  //               fontWeight: FontWeight.bold, color: AppColor.greenColor),
  //         );
  //   isDisplayOverOtherAppsGranted =
  //       await FlutterOverlayWindow.isPermissionGranted();
  //   print("============================================================");
  //   print(
  //       "=====================================isDisplayOverOtherAppsGranted=======================$isDisplayOverOtherAppsGranted");
  //   update();
  // }

  goToPagePasswordLock() {
    if (storedPassCode.isEmpty) {
      Get.toNamed(AppRoutes.passwordlockScreen);
    } else {
      Get.toNamed(AppRoutes.rePasswordlockScreen,
          arguments: {"storedpasscode": storedPassCode});
    }
  }

  late int selectedContactType;
  onSelectContactsType(int type) {
    print("============================================================");
    print(
        "=====================================onSelectContactsType=======================");
    myServices.sharedPreferences.remove("callingsetting");

    selectedContactType = type;
    update();
  }

  // showCallingSetting() {
  //   Get.dialog(const CustomDialogShowCallingSetting());
  // }

  // goToPageOtherSetting() {
  //   Get.toNamed(AppRoutes.otherSetting);
  // }

  goToPagePatternLock() {
    if (storedPatternCode.isEmpty) {
      Get.toNamed(AppRoutes.patternlockScreen);
    } else {
      Get.toNamed(AppRoutes.rePatternlockScreen,
          arguments: {"storedpatterncode": storedPatternCode});
    }
  }

  requestNecessaryPermissionsHomeScreen() async {
    await requestAllPermissions();
    await requestDisplayOverOtherApps();
  }

  @override
  void onInit() {
    selectedContactType =
        myServices.sharedPreferences.getInt("callingsetting") ?? 0;
    print("============================================================");
    print(
        "=====================================selectedContactType=======================$selectedContactType");
    activeSwitchLock =
        myServices.sharedPreferences.getBool("lockactivited") ?? false;
    print("============================================================");
    print(
        "=====================================activeSwitchLock=======================$activeSwitchLock");
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

    WidgetsBinding.instance.addObserver(this);
    requestNecessaryPermissionsHomeScreen();
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);

    // TODO: implement onClose
    super.onClose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print(state);
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.paused) {
      print(
          "============================================================================");

      print("App moved to background");
      // Handle app moving to background
    } else if (state == AppLifecycleState.resumed) {
      checkReadPhoneStateCallLogAndContactsPermissionsWhenAppStateResumed();
      checkDisplayOverOtherAppsGranted();
      print(
          "===========================================================================");

      print("App moved to foreground");
      // Handle app coming back to foreground
    }
  }
}
