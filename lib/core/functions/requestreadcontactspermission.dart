import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constant/appcolor.dart';

requestReadContactsPermission() async {
  PermissionStatus readContactsPermissionStatus =
      await Permission.contacts.status;
  print("============================================================");
  print(
      "=====================================readContactsPermissionStatus=======================$readContactsPermissionStatus");
  if (readContactsPermissionStatus == PermissionStatus.granted) {
    return true;
  } else if (readContactsPermissionStatus == PermissionStatus.denied) {
    readContactsPermissionStatus = await Permission.contacts.request();
    print("============================================================");
    print(
        "=====================================request=======================$readContactsPermissionStatus");
    // if (readContactsPermissionStatus == PermissionStatus.granted ||
    //     readContactsPermissionStatus == PermissionStatus.denied) {
    //   readContactsPermissionStatus = await Permission.phone.status;
    // }

    // print("============================================================");
    // print(
    //     "=====================================readContactsPermissionStatus=======================$readContactsPermissionStatus");
    if (readContactsPermissionStatus == PermissionStatus.denied) {
      Get.snackbar(
          "warning", "Please give read contacts permission to the app");
    } else if (readContactsPermissionStatus ==
        PermissionStatus.permanentlyDenied) {
      await Get.defaultDialog(
        title: "Error",
        middleText:
            "The application cannot be work correctly without the read contacts permission.\nPlease give the permission in settings",
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.redColor),
      );
    }
  }
  // else if (readContactsPermissionStatus == PermissionStatus.permanentlyDenied) {
  //   await Get.defaultDialog(
  //     title: "Error",
  //     middleText:
  //         "The application cannot be work correctly without the contact permission.\nPlease give the permissions in settings",
  //     titleStyle: const TextStyle(
  //         fontWeight: FontWeight.bold, color: AppColor.redColor),
  //   );
  // }
  return readContactsPermissionStatus == PermissionStatus.permanentlyDenied ||
          readContactsPermissionStatus == PermissionStatus.denied
      ? false
      : true;
}
