import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/shared/custom_text.dart';

class PasswordCodeWidget extends StatelessWidget {
  final String title;
  final void Function(String) passwordEnteredCallback;
  final Stream<bool> shouldTriggerVerification;

  const PasswordCodeWidget({
    Key? key,
    required this.title,
    required this.passwordEnteredCallback,
    required this.shouldTriggerVerification,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("========== ${ScreenUtil.defaultSize.height} ==========height");
      print("========== ${ScreenUtil.defaultSize.width} ==========width");
    }

    return PasscodeScreen(
      keyboardUIConfig: KeyboardUIConfig(
          keyboardSize: Size((ScreenUtil.defaultSize.height / 2) * 3 / 4,
              ScreenUtil.defaultSize.height / 2)),
      title: CustomText(
          text: title,
          fontWeight: FontWeight.w500,
          color: AppColor.whiteColor,
          fontSize: 18.sp),
      passwordDigits: 4,
      passwordEnteredCallback: passwordEnteredCallback,
      cancelButton: const Text(
        '',
        style: TextStyle(
          color: AppColor.blueColor,
        ),
      ),
      deleteButton:
          const Text('Delete', style: TextStyle(color: AppColor.blueColor)),
      shouldTriggerVerification: shouldTriggerVerification,
      // backgroundColor: AppColor.whiteColor,
      // isValidCallback: isValidCallback,
      // circleUIConfig: const CircleUIConfig(
      //     borderWidth: 0.0,
      //     fillColor: AppColor.blueColor,
      //     circleSize: 13,
      //     borderColor: AppColor.greyColor),
      //     digitInnerMargin:
      //         EdgeInsets.only(right: 65 * Get.width),
      //     digitTextStyle: TextStyle(
      //       color: AppColor.blackColor,
      //       fontSize: 17,
      //     ),
      //     primaryColor: AppColor.transparentColor),
    );
  }
}
