import 'package:flutter/cupertino.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';

class ShowAppLockController extends GetxController {
  // late SharedPreferences sharedPref;

  late String storedPassCode;
  late String storedPatternCode;
  // MyServices myServices = Get.find();

  onPatterncodeEntered(List<int> enteredPatterncode) async {
    if (enteredPatterncode.map((i) => i.toString()).join("") ==
        storedPatternCode) {
      print("============================================================");
      print(
          "============================================================Valid");
      await FlutterOverlayWindow.closeOverlay();
    } else {
      print("============================================================");
      print(
          "============================================================NotValid");
      Get.snackbar("Error", "The pattern not correct",
          margin: EdgeInsets.symmetric(
              vertical: Get.height / 15, horizontal: Get.width / 27));
      // await Get.defaultDialog(
      //   contentPadding: EdgeInsets.only(left: 5.w, right: 5.w),
      //   title: "Error",
      //   middleText: "Patterncodes not Correct!",
      //   cancel: InkWell(
      //     onTap: () {
      //       Get.back();
      //     },
      //     child: Padding(
      //       padding: EdgeInsets.only(right: 20.w, left: 20.w, bottom: 30.h),
      //       child: Container(
      //           alignment: Alignment.bottomRight,
      //           child: CustomText(
      //             text: "Try again",
      //             color: AppColor.blueColor,
      //             fontSize: 12.sp,
      //             fontWeight: FontWeight.w500,
      //           )),
      //     ),
      //   ),
      //   middleTextStyle: TextStyle(
      //     fontSize: 24.sp,
      //   ),
      //   titleStyle: const TextStyle(
      //       fontWeight: FontWeight.bold, color: AppColor.redColor),
      // );
    }
  }

  @override
  void onInit() async {
    storedPatternCode = sharedPref!.getString("storedpatterncode") ?? "";

    storedPassCode = sharedPref!.getString("storedpasscode") ?? "";
    print("============================================================");
    print(
        "=====================================storedPassword=======================$storedPassCode");
    print("============================================================");
    print(
        "=====================================storedPattern=======================$storedPatternCode");
    // TODO: implement onInit
    super.onInit();
  }
}
