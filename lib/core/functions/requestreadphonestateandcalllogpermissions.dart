import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constant/appcolor.dart';

requestReadPhoneStateAndCallLogPermissions() async {
  PermissionStatus readPhoneStateAndCallLogPermissionsStatus =
      await Permission.phone.status;
  print("============================================================");
  print(
      "=====================================readPhoneStateAndCallLogPermissionsStatus=======================$readPhoneStateAndCallLogPermissionsStatus");
  if (readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.granted) {
    return true;
  } else if (readPhoneStateAndCallLogPermissionsStatus ==
      PermissionStatus.denied) {
    readPhoneStateAndCallLogPermissionsStatus =
        await Permission.phone.request();
    print("============================================================");
    print(
        "=====================================request=======================$readPhoneStateAndCallLogPermissionsStatus");
    if (readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.granted ||
        readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.denied) {
      readPhoneStateAndCallLogPermissionsStatus = await Permission.phone.status;
    }

    print("============================================================");
    print(
        "=====================================readPhoneStateAndCallLogPermissionsStatus=======================$readPhoneStateAndCallLogPermissionsStatus");
    if (readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.denied) {
      Get.snackbar("warning",
          "Please give read phone state and call log permissions to the app");
    } else if (readPhoneStateAndCallLogPermissionsStatus ==
        PermissionStatus.permanentlyDenied) {
      await Get.defaultDialog(
        title: "Error",
        middleText:
            "The application cannot be work correctly without the read phone state or call log permissions.\nPlease give the permissions in settings",
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.redColor),
      );
    }
  } else if (readPhoneStateAndCallLogPermissionsStatus ==
      PermissionStatus.permanentlyDenied) {
    await Get.defaultDialog(
      title: "Error",
      middleText:
          "The application cannot be work correctly without the read phone state or call log permissions.\nPlease give the permissions in settings",
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: AppColor.redColor),
    );
  }
  return readPhoneStateAndCallLogPermissionsStatus ==
              PermissionStatus.permanentlyDenied ||
          readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.denied
      ? false
      : true;
}
