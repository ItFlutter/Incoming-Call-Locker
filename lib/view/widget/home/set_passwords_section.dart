import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/home_screen_controller.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';
import 'package:incoming_call_locker/view/widget/home/custom_set_screen_lock.dart';

class SetPasswordsSection extends StatelessWidget {
  const SetPasswordsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(
              text: "Password & Security",
              color: AppColor.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CustomSetScreenLock(
                  text: "Password \nScreen Lock",
                  path: "assets/images/pin.png",
                  onTap: () {
                    controller.goToPagePasswordLock();
                  },
                  isEnrolled: controller.storedPassCode != "" ? true : false,
                ),
                CustomSetScreenLock(
                  text: "Pattern \nScreen Lock",
                  path: "assets/images/pattern.png",
                  onTap: () {
                    controller.goToPagePatternLock();
                  },
                  isEnrolled: controller.storedPatternCode != "" ? true : false,
                ),
              ],
            ),
            SizedBox(
              height: 10.h,
            ),
          ],
        );
      },
    );
  }
}
