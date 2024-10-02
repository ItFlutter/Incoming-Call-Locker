import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passcode_screen/passcode_screen.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared/customtext.dart';

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
    return PasscodeScreen(
      // backgroundColor: AppColor.whiteColor,
      title: CustomText(
          text: title,
          fontWeight: FontWeight.w500,
          color: AppColor.whiteColor,
          fontSize: 18.sp),
      // isValidCallback: isValidCallback,
      // circleUIConfig: const CircleUIConfig(
      //     borderWidth: 0.0,
      //     fillColor: AppColor.blueColor,
      //     circleSize: 13,
      //     borderColor: AppColor.greyColor),
      // keyboardUIConfig: KeyboardUIConfig(
      //     keyboardSize:
      //         Size(Get.width - 200, Get.height - 200),
      //     digitInnerMargin:
      //         EdgeInsets.only(right: 65 * Get.width),
      //     digitTextStyle: TextStyle(
      //       color: AppColor.blackColor,
      //       fontSize: 17,
      //     ),
      //     primaryColor: AppColor.transparentColor),
      passwordDigits: 4,
      passwordEnteredCallback: passwordEnteredCallback,
      cancelButton: Padding(
        padding: EdgeInsets.only(bottom: 80.h),
        child: const Text(
          '',
          style: TextStyle(
            color: AppColor.blueColor,
          ),
        ),
      ),
      deleteButton: Padding(
        padding: EdgeInsets.only(bottom: 80.h),
        child:
            const Text('Delete', style: TextStyle(color: AppColor.blueColor)),
      ),
      shouldTriggerVerification: shouldTriggerVerification,
    );
  }
}
