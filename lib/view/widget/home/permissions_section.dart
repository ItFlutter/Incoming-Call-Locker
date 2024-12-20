import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/home_screen_controller.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';
import 'package:incoming_call_locker/view/widget/home/custom_check_permission.dart';

class PermissionsSection extends StatelessWidget {
  const PermissionsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          CustomText(
            text: "Need Permission",
            color: AppColor.blackColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomCheckPermission(
            title: "Read phone state",
            description:
                "The read phone state call log and contacts are important for this app. Please grant the permissions",
            onTap: () {
              controller
                  .checkReadPhoneStateCallLogAndContactsPermissionsHomeScreen();
            },
            isGranted:
                controller.isReadPhoneStateAndCallLogPermissionsGranted &&
                    controller.isReadContactsPermissionGranted,
          ),
          SizedBox(
            height: 10.h,
          ),
          CustomCheckPermission(
            title: "Draw over other app",
            description:
                "The Draw Over Other App is important for this app. Please grant the permission.",
            onTap: () {
              controller.onClickDisplayOverOtherAppsGranted();
            },
            isGranted: controller.isDisplayOverOtherAppsGranted,
          ),
          SizedBox(
            height: 10.h,
          ),
        ],
      );
    });
  }
}
