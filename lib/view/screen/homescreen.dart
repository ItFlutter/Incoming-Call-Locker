import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';
import 'package:incoming_call_locker/view/widget/home/customcheckpermission.dart';
import 'package:incoming_call_locker/view/widget/home/customsetscreenlock.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';
import 'package:incoming_call_locker/view/widget/home/switchbuttonenableanddisablelock.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../controller/homescreen_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenController());
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "Incoming Call Locker",
            fontSize: 24.sp,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: GetBuilder<HomeScreenController>(
          builder: (controller) {
            return Container(
              margin: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
                    margin: EdgeInsets.symmetric(horizontal: 5.w),
                    decoration: BoxDecoration(
                        color: AppColor.primaryColor,
                        borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: "Enable Call Locker",
                              color: AppColor.blackColor,
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w500,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            CustomText(
                              text: controller.activeSwitchLock == false
                                  ? "Locker Disable Now"
                                  : "Locker Enable",
                              color: AppColor.blackColor,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                            ),
                          ],
                        ),
                        SwitchButtonEnableAndDisableLock(
                          onChanged: (value) {
                            controller.onClickSwitchLock(value);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomText(
                    text: "Need Permission",
                    color: AppColor.blackColor,
                    fontSize: 19.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomCheckPermission(
                    title: "Draw over other app",
                    description:
                        "The Draw Over Other App is important for this app. Please grant the permission.",
                    onTap: () {},
                    isGranted: controller.isDisplayOverOtherAppsGranted,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomCheckPermission(
                    title: "Read phone state and call log",
                    description:
                        "The Read Phone State and Read Phone Call Log are important for this app. Please grant the permissions",
                    onTap: () {
                      controller.checkPhoneAndCallLogsPermissions();
                    },
                    isGranted: controller.isPhoneAndCallLogPermissionsGranted,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomText(
                    text: "Password & Security",
                    color: AppColor.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Row(
                    children: [
                      CustomSetScreenLock(
                        text: "Password \nScreen Lock",
                        onTap: () {
                          controller.goToPagePasswordLock();
                        },
                        isEnrolled:
                            controller.storedPassCode != "" ? true : false,
                      ),
                      CustomSetScreenLock(
                        text: "Pattern \nScreen Lock",
                        onTap: () {
                          controller.goToPagePatternLock();
                        },
                        isEnrolled:
                            controller.storedPatternCode != "" ? true : false,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomText(
                    text: "Calling Setting",
                    color: AppColor.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  CustomText(
                    text: "Other Setting",
                    color: AppColor.blackColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
