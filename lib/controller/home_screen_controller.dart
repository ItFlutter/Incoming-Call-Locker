import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/class/sqldb.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';
import 'package:incoming_call_locker/core/services/my_services.dart';
import 'package:incoming_call_locker/data/model/other_settings_model.dart';
import 'package:incoming_call_locker/view/widget/dialogs/dialogs.dart';
import 'package:incoming_call_locker/view/widget/home/custom_show_instruction.dart';
import 'package:permission_handler/permission_handler.dart';
import '../core/constant/app_color.dart';
import '../core/functions/request_read_contacts_permission.dart';
import '../core/functions/request_read_phone_state_and_call_log_permissions.dart';

class HomeScreenController extends GetxController with WidgetsBindingObserver {
  static const channel =
      MethodChannel("com.example.incoming_call_locker/incomingCall");
  SqlDb sqlDb = Get.find();
  late String storedPassCode;
  late String storedPatternCode;
  MyServices myServices = Get.find();
  bool isDisplayOverOtherAppsGranted = false;
  bool isReadPhoneStateAndCallLogPermissionsGranted = false;
  bool isReadContactsPermissionGranted = false;
  late bool activeSwitchLock;
  List<OtherSettingsModel> otherSettings = [
    OtherSettingsModel(
        title: 'Notes For Some Devices (Xiaomi)',
        iconTrealing: Icons.chevron_right,
        iconLeading: Icons.chat_outlined,
        onTap: () {
          Get.dialog(const CustomShowInstruction());
        }),
    OtherSettingsModel(
        title: 'Privacy Policy',
        iconTrealing: Icons.chevron_right,
        iconLeading: Icons.lock_outline,
        onTap: () {}),
    OtherSettingsModel(
        title: 'Share App"',
        iconTrealing: Icons.chevron_right,
        iconLeading: Icons.share_outlined,
        onTap: () {}),
    OtherSettingsModel(
        title: 'Rate Us',
        iconTrealing: Icons.chevron_right,
        iconLeading: Icons.thumb_up_alt_outlined,
        onTap: () {}),
    OtherSettingsModel(
        title: 'Language Setting',
        iconTrealing: Icons.chevron_right,
        iconLeading: Icons.translate_outlined,
        onTap: () {}),
  ];
  onClickSwitchLock(bool value) async {
    if (isReadPhoneStateAndCallLogPermissionsGranted == false ||
        isReadContactsPermissionGranted == false ||
        isDisplayOverOtherAppsGranted == false) {
      activeSwitchLock = false;

      await myServices.sharedPreferences.remove("lockactivited");
      Dialogs.showDialog('Error',
          "Please give All permissions to the app and sure give display over app",
          isShowCancleButton: true);
    } else if (storedPassCode.isEmpty && storedPatternCode.isEmpty) {
      activeSwitchLock = false;
      await myServices.sharedPreferences.remove("lockactivited");
      Dialogs.showDialog(
          'Error', "Please set any types of lock before enable locker app",
          isShowCancleButton: true);
    } else {
      activeSwitchLock = !activeSwitchLock;
      await myServices.sharedPreferences
          .setBool("lockactivited", activeSwitchLock);
      print("========== activeSwitchLock ========== $activeSwitchLock");
    }
    update();
  }

  onTapRequiredStepToActivateDeviceAdminApp() async {
    try {
      await channel.invokeMethod("activatedeviceadminapp");
    } on PlatformException catch (ex) {
      print(ex.message);
    }
  }

  checkReadPhoneStateCallLogAndContactsPermissionsHomeScreen() async {
    if (isReadPhoneStateAndCallLogPermissionsGranted == false) {
      requestReadPhoneStateAndCallLogPermissionsHomeScreen();
    }
    if (isReadContactsPermissionGranted == false) {
      requestReadContactsPermissionHomeScreen();
    } else {
      Dialogs.showDialog('Success', 'The permissions are granted.',
          titleColor: AppColor.greenColor);
    }

    update();
  }

  requestReadContactsPermissionHomeScreen() async {
    isReadContactsPermissionGranted = await requestReadContactsPermission();
    print(
        "========== isReadContactsPermissionGranted ========== $isReadContactsPermissionGranted");
    update();
  }

  requestReadPhoneStateAndCallLogPermissionsHomeScreen() async {
    isReadPhoneStateAndCallLogPermissionsGranted =
        await requestReadPhoneStateAndCallLogPermissions();
    print(
        "============= isReadPhoneStateAndCallLogPermissionsGranted ========== $isReadPhoneStateAndCallLogPermissionsGranted");
    update();
  }

  requestAllPermissions() async {
    await requestReadPhoneStateAndCallLogPermissionsHomeScreen();
    await requestReadContactsPermissionHomeScreen();
  }

  onClickDisplayOverOtherAppsGranted() async {
    isDisplayOverOtherAppsGranted == false
        ? await FlutterOverlayWindow.requestPermission()
        : Dialogs.showDialog("Success", "The permissions is granted.",
            titleColor: AppColor.greenColor);

    update();
  }

  requestDisplayOverOtherApps() async {
    isDisplayOverOtherAppsGranted =
        await FlutterOverlayWindow.isPermissionGranted();
    print(
        "========== isDisplayOverOtherAppsGranted ========== $isDisplayOverOtherAppsGranted");
    if (isDisplayOverOtherAppsGranted == false) {
      Dialogs.showDialogWithTwoButtonsCancelAndConfirm("Warning",
          "The Draw Over Other App is important for this app. Please grant the permission.",
          onConfirm: () async {
        Get.back();
        await FlutterOverlayWindow.requestPermission();
      }, onCancel: () {
        Get.back();
      });
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
    print("========== onSelectContactsType ==========");
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
    print("========== selectedContactTypeHome ========== $selectedContactType");
    activeSwitchLock =
        myServices.sharedPreferences.getBool("lockactivited") ?? false;
    print("========== activeSwitchLockHome ========== $activeSwitchLock");
    storedPassCode =
        myServices.sharedPreferences.getString("storedpasscode") ?? "";

    print("========== storedPassCodeHome ==========$storedPassCode");
    storedPatternCode =
        myServices.sharedPreferences.getString("storedpatterncode") ?? "";
    print("========== storedPatternCodeHome ==========$storedPatternCode");
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
      print("========== App moved to background ==========");
      // Handle app moving to background
    } else if (state == AppLifecycleState.resumed) {
      checkReadPhoneStateCallLogAndContactsPermissionsWhenAppStateResumed();
      checkDisplayOverOtherAppsGranted();
      print("========== App moved to foreground ==========");
      // Handle app coming back to foreground
    }
  }
}
