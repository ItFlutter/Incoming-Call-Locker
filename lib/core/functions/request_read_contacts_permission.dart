import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/view/widget/dialogs/dialogs.dart';
import 'package:permission_handler/permission_handler.dart';
import '../constant/app_color.dart';

requestReadContactsPermission() async {
  PermissionStatus readContactsPermissionStatus =
      await Permission.contacts.status;
  print(
      "========== readContactsPermissionStatus ========== $readContactsPermissionStatus");
  if (readContactsPermissionStatus == PermissionStatus.granted) {
    return true;
  } else if (readContactsPermissionStatus == PermissionStatus.denied) {
    readContactsPermissionStatus = await Permission.contacts.request();
    print("========== request ========== $readContactsPermissionStatus");
    if (readContactsPermissionStatus == PermissionStatus.denied) {
      Get.snackbar(
          "warning", "Please give read contacts permission to the app");
    } else if (readContactsPermissionStatus ==
        PermissionStatus.permanentlyDenied) {
      await Dialogs.showDialog('Error',
          "The application cannot be work correctly without the read contacts permission.\nPlease give the permission in settings");
    }
  } else if (readContactsPermissionStatus ==
      PermissionStatus.permanentlyDenied) {
    await Dialogs.showDialog('Error',
        "The application cannot be work correctly without the read contacts permission.\nPlease give the permission in settings");
  }
  return readContactsPermissionStatus == PermissionStatus.permanentlyDenied ||
          readContactsPermissionStatus == PermissionStatus.denied
      ? false
      : true;
}
