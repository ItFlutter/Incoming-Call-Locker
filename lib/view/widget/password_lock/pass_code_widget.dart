import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:passcode_screen/circle.dart';
import 'package:passcode_screen/keyboard.dart';
import 'package:passcode_screen/passcode_screen.dart';

import '../../../core/constant/app_color.dart';
import '../../../core/shared/custom_text.dart';

class PasscodeWidget extends StatelessWidget {
  final String title;
  final void Function()? cancelCallback;
  final void Function()? isValidCallback;
  final void Function(String) passwordEnteredCallback;
  final Stream<bool> shouldTriggerVerification;

  const PasscodeWidget(
      {Key? key,
      required this.title,
      this.cancelCallback,
      this.isValidCallback,
      required this.passwordEnteredCallback,
      required this.shouldTriggerVerification})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PasscodeScreen(
      backgroundColor: AppColor.whiteColor,
      title: CustomText(
          text: title,
          fontWeight: FontWeight.w500,
          color: AppColor.blueColor,
          fontSize: 18.sp),
      cancelCallback: cancelCallback,
      isValidCallback: isValidCallback,
      circleUIConfig: const CircleUIConfig(
          borderWidth: 0.0,
          fillColor: AppColor.blueColor,
          circleSize: 13,
          borderColor: AppColor.greyColor),
      keyboardUIConfig: KeyboardUIConfig(
          // keyboardSize: Size(360.w, 260.h),
          digitInnerMargin: EdgeInsets.only(right: 65.w),
          digitTextStyle: TextStyle(
            color: AppColor.blackColor,
            fontSize: 17.sp,
          ),
          primaryColor: AppColor.transparentColor),
      passwordDigits: 4,
      passwordEnteredCallback: passwordEnteredCallback,
      cancelButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child: const Text(
          'Cancel',
          style: TextStyle(
            color: AppColor.blueColor,
          ),
        ),
      ),
      deleteButton: Padding(
        padding: EdgeInsets.only(bottom: 20.h),
        child:
            const Text('Delete', style: TextStyle(color: AppColor.blueColor)),
      ),
      shouldTriggerVerification: shouldTriggerVerification,
    );
  }
}
