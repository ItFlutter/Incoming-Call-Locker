import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';
import 'package:incoming_call_locker/view/widget/home/customcheckpermission.dart';
import 'package:incoming_call_locker/view/widget/home/customsetscreenlock.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';
import 'package:incoming_call_locker/core/shared/switchbuttonenableanddisablelock.dart';
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
                        SwitchButtonEnableAndDisable(
                          onChanged: (value) {
                            controller.onClickSwitchLock(value);
                          },
                          value: controller.activeSwitchLock,
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
                    onTap: () {
                      controller.onClickDisplayOverOtherAppsGranted();
                    },
                    isGranted: controller.isDisplayOverOtherAppsGranted,
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  CustomCheckPermission(
                    title: "Read phone state call log and contacts",
                    description:
                        "The read phone state call log and contacts are important for this app. Please grant the permissions",
                    onTap: () {
                      controller
                          .checkReadPhoneStateCallLogAndContactsPermissionsHomeScreen();
                    },
                    isGranted: controller
                            .isReadPhoneStateAndCallLogPermissionsGranted &&
                        controller.isReadContactsPermissionGranted,
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
                  InkWell(
                    onTap: () {
                      controller.showCallingSetting();
                    },
                    child: CustomText(
                      text: "Calling Setting",
                      color: AppColor.blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  InkWell(
                    onTap: () {
                      controller.goToPageOtherSetting();
                    },
                    child: CustomText(
                      text: "Other Setting",
                      color: AppColor.blackColor,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
