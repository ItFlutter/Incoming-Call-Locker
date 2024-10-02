import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';
import 'package:incoming_call_locker/core/constant/appimageasset.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';
import 'package:incoming_call_locker/core/shared/switchbuttonenableanddisablelock.dart';
import 'package:incoming_call_locker/view/widget/home/customcheckpermission.dart';
import 'package:incoming_call_locker/view/widget/home/customsetscreenlock.dart';

import '../../controller/homescreen_controller.dart';
import '../widget/home/appbarwidget.dart';
import '../widget/home/callingsetting.dart';
import '../widget/home/customlisttileselectsetting.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenController());
    return SafeArea(
      child: Scaffold(body: GetBuilder<HomeScreenController>(
        builder: (controller) {
          return Column(
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      height: 150 /*height*0.23*/,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.blue],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          )),
                    ),
                    const AppBarWidget(),
                    Container(
                        height: 62 /*height * 0.18*/,
                        margin: const EdgeInsets.only(
                            top: 115 /*height * 0.164*/, left: 20, right: 20),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.4),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 10.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text: "Enable Call Locker",
                                    color: AppColor.blackColor,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  CustomText(
                                    text: controller.activeSwitchLock == false
                                        ? "Enable Locker"
                                        : "Disable Locker",
                                    color: AppColor.blackColor,
                                    fontSize: 12.sp,
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
                        ))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
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
                          isGranted: controller
                                  .isReadPhoneStateAndCallLogPermissionsGranted &&
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
                              isEnrolled:
                                  controller.storedPassCode != "" ? true : false,
                            ),
                            CustomSetScreenLock(
                              text: "Pattern \nScreen Lock",
                              path: "assets/images/pattern.png",
                              onTap: () {
                                controller.goToPagePatternLock();
                              },
                              isEnrolled: controller.storedPatternCode != ""
                                  ? true
                                  : false,
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomText(
                          text: "Calling Settings",
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        const CallingSetting(),
                        SizedBox(
                          height: 15.h,
                        ),
                        CustomText(
                          text: "Other Settings",
                          color: AppColor.blackColor,
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                        Column(
                          children: [
                            CustomListTileSelectSetting(
                              onTap: () {
                                Get.dialog(Column(children: [
                                  InteractiveViewer(
                                      child: Image.asset(AppImageAsset.guide)),
                                  Expanded(
                                    child: Container(
                                      color: const Color(0xfffdfbfe),
                                      child: CustomText(
                                        text:
                                            "Please apply this instruction to work app correctly",
                                        textAlign: TextAlign.center,
                                        fontSize: 12.sp,
                                        color: AppColor.blackColor,
                                      ),
                                    ),
                                  )
                                ]));
                              },
                              title: "Notes For Some Devices (Xiaomi)",
                              iconLeading: Icons.chat_outlined,
                              iconTrealing: Icons.chevron_right,
                            ),
                            Divider(
                              height: 0.1.h,
                              thickness: 0.5.h,
                            ),
                            const CustomListTileSelectSetting(
                              title: "Privacy Policy",
                              iconLeading: Icons.lock_outline,
                              iconTrealing: Icons.chevron_right,
                            ),
                            Divider(
                              height: 0.1.h,
                              thickness: 0.5.h,
                            ),
                            const CustomListTileSelectSetting(
                              title: "Share App",
                              iconLeading: Icons.share_outlined,
                              iconTrealing: Icons.chevron_right,
                            ),
                            Divider(
                              height: 0.1.h,
                              thickness: 0.5.h,
                            ),
                            const CustomListTileSelectSetting(
                              title: "Rate Us",
                              iconLeading: Icons.thumb_up_alt_outlined,
                              iconTrealing: Icons.chevron_right,
                            ),
                            Divider(
                              height: 0.1.h,
                              thickness: 0.5.h,
                            ),
                            const CustomListTileSelectSetting(
                              title: "Language Setting",
                              iconLeading: Icons.translate_outlined,
                              iconTrealing: Icons.chevron_right,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      )),
    );
  }
}
