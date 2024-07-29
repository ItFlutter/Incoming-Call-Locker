import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constant/appcolor.dart';

requestContactsPermission() async {
  PermissionStatus contactsPermissionsStatus = await Permission.contacts.status;
  print("============================================================");
  print(
      "=====================================contactsPermissionsStatus=======================$contactsPermissionsStatus");
  if (contactsPermissionsStatus == PermissionStatus.granted) {
    return true;
  } else if (contactsPermissionsStatus == PermissionStatus.denied) {
    contactsPermissionsStatus = await Permission.contacts.request();
    print("============================================================");
    print(
        "=====================================request=======================$contactsPermissionsStatus");
    // if (contactsPermissionsStatus == PermissionStatus.granted ||
    //     contactsPermissionsStatus == PermissionStatus.denied) {
    //   contactsPermissionsStatus = await Permission.phone.status;
    // }

    // print("============================================================");
    // print(
    //     "=====================================contactsPermissionsStatus=======================$contactsPermissionsStatus");
    if (contactsPermissionsStatus == PermissionStatus.denied) {
      Get.snackbar("warning", "Please give contact permission to the app");
    } else if (contactsPermissionsStatus ==
        PermissionStatus.permanentlyDenied) {
      await Get.defaultDialog(
        title: "Error",
        middleText:
            "The application cannot be work correctly without the contact permission.\nPlease give the permission in settings",
        titleStyle: const TextStyle(
            fontWeight: FontWeight.bold, color: AppColor.redColor),
      );
    }
  }
  // else if (contactsPermissionsStatus == PermissionStatus.permanentlyDenied) {
  //   await Get.defaultDialog(
  //     title: "Error",
  //     middleText:
  //         "The application cannot be work correctly without the contact permission.\nPlease give the permissions in settings",
  //     titleStyle: const TextStyle(
  //         fontWeight: FontWeight.bold, color: AppColor.redColor),
  //   );
  // }
  return contactsPermissionsStatus == PermissionStatus.permanentlyDenied ||
          contactsPermissionsStatus == PermissionStatus.denied
      ? false
      : true;
}
