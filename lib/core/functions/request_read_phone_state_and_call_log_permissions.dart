import 'package:get/get.dart';
import 'package:incoming_call_locker/view/widget/dialogs/dialogs.dart';
import 'package:permission_handler/permission_handler.dart';

requestReadPhoneStateAndCallLogPermissions() async {
  PermissionStatus readPhoneStateAndCallLogPermissionsStatus =
      await Permission.phone.status;
  print(
      "========== readPhoneStateAndCallLogPermissionsStatus ========== $readPhoneStateAndCallLogPermissionsStatus");
  if (readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.granted) {
    return true;
  } else if (readPhoneStateAndCallLogPermissionsStatus ==
      PermissionStatus.denied) {
    readPhoneStateAndCallLogPermissionsStatus =
        await Permission.phone.request();
    print(
        "========== request ========== $readPhoneStateAndCallLogPermissionsStatus");

    if (readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.denied) {
      Get.snackbar("warning",
          "Please give read phone state and call log permissions to the app");
    } else if (readPhoneStateAndCallLogPermissionsStatus ==
        PermissionStatus.permanentlyDenied) {
      await Dialogs.showDialog('Error',
          "The application cannot be work correctly without the read phone state or call log permissions.\nPlease give the permissions in settings");
    }
  } else if (readPhoneStateAndCallLogPermissionsStatus ==
      PermissionStatus.permanentlyDenied) {
    await Dialogs.showDialog('Error',
        "The application cannot be work correctly without the read phone state or call log permissions.\nPlease give the permissions in settings");
  }
  return readPhoneStateAndCallLogPermissionsStatus ==
              PermissionStatus.permanentlyDenied ||
          readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.denied
      ? false
      : true;
}
    // //===================???======================
    // if (readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.granted ||
    //     readPhoneStateAndCallLogPermissionsStatus == PermissionStatus.denied) {
    //   readPhoneStateAndCallLogPermissionsStatus = await Permission.phone.status;
    // }
    // print(
    //     "========== readPhoneStateAndCallLogPermissionsStatus ========== $readPhoneStateAndCallLogPermissionsStatus");
    // //===================???======================