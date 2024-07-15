import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constant/appcolor.dart';

requestPermission() async {
  PermissionStatus phoneAndCallLogsPermissionsStatus =
      await Permission.phone.status;
  print("============================================================");
  print(
      "=====================================phoneAndCallLogsPermissionsStatus=======================$phoneAndCallLogsPermissionsStatus");
  if (phoneAndCallLogsPermissionsStatus == PermissionStatus.granted) {
    return true;
  } else if (phoneAndCallLogsPermissionsStatus == PermissionStatus.denied) {
    phoneAndCallLogsPermissionsStatus = await Permission.phone.request();
    print("============================================================");
    print(
        "=====================================request=======================$phoneAndCallLogsPermissionsStatus");
    if (phoneAndCallLogsPermissionsStatus == PermissionStatus.granted ||
        phoneAndCallLogsPermissionsStatus == PermissionStatus.denied) {
      phoneAndCallLogsPermissionsStatus = await Permission.phone.status;
    }

    print("============================================================");
    print(
        "=====================================phoneAndCallLogsPermissionsStatus=======================$phoneAndCallLogsPermissionsStatus");
    if (phoneAndCallLogsPermissionsStatus == PermissionStatus.denied) {
      Get.snackbar(
          "warning", "Please give phone and call log permission to the app");
    } else if (phoneAndCallLogsPermissionsStatus ==
        PermissionStatus.permanentlyDenied) {
      await Get.defaultDialog(
        title: "Error",
        middleText:
            "The application cannot be work correctly without the phone or call log permissions.\nPlease give the permissions in settings",
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.redColor),
      );
    }
  } else if (phoneAndCallLogsPermissionsStatus ==
      PermissionStatus.permanentlyDenied) {
    await Get.defaultDialog(
      title: "Error",
      middleText:
          "The application cannot be work correctly without the phone or call log permissions.\nPlease give the permissions in settings",
      titleStyle: const TextStyle(
          fontWeight: FontWeight.bold, color: AppColor.redColor),
    );
  }
  return phoneAndCallLogsPermissionsStatus ==
              PermissionStatus.permanentlyDenied ||
          phoneAndCallLogsPermissionsStatus == PermissionStatus.denied
      ? false
      : true;
}
