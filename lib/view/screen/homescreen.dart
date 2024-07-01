import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/cntroller/homescreen_controller.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';
import 'package:incoming_call_locker/view/widget/home/customtext.dart';
import 'package:incoming_call_locker/view/widget/home/switchbuttonenableanddisablelock.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(HomeScreenController());
    return Scaffold(
        appBar: AppBar(
          title: CustomTextHomeScreen(
            text: "Incoming Call Locker",
            fontSize: 22.sp,
            fontWeight: FontWeight.w500,
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
                    height: 10.h,
                  ),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 5.h, horizontal: 20.w),
                    // margin: EdgeInsets.symmetric(
                    //   vertical: 15.h,
                    // ),
                    decoration: BoxDecoration(
                        color: AppColor.greenColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextHomeScreen(
                          text: controller.activeSwitchLock == false
                              ? "Enable Lock"
                              : "Disable Lock",
                          color: AppColor.whiteColor,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w300,
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
                    height: 20.h,
                  ),
                  CustomTextHomeScreen(
                    text: "SETTINGS",
                    color: AppColor.whiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.security,
                        color: AppColor.whiteColor,
                        size: 25.w,
                      ),
                      SizedBox(
                        width: 15.w,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextHomeScreen(
                            text: "Security Type",
                            color: AppColor.whiteColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                          ),
                          DropdownButton(
                              isDense: true,
                              iconEnabledColor: AppColor.blackColor,
                              itemHeight: 50.h,
                              // value: controller.selectedLockType,
                              hint: Padding(
                                padding: EdgeInsets.only(right: 20.w),
                                child: Text(
                                  "${controller.selectedLockType} Lock",
                                  style: const TextStyle(
                                      color: AppColor.primaryColor),
                                ),
                              ),
                              underline: Container(),
                              onChanged: (String? value) {
                                controller.onChangedLockType(value!);
                              },
                              dropdownColor: AppColor.whiteColor,
                              items: ["Passcode", "Pattern"]
                                  .map(
                                    (e) => DropdownMenuItem(
                                        value: e,
                                        child: CustomTextHomeScreen(
                                          text: "$e Lock",
                                        )),
                                  )
                                  .toList())
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(
                          Icons.https,
                          color: AppColor.whiteColor,
                          size: 25.w,
                        ),
                        SizedBox(
                          width: 15.w,
                        ),
                        CustomTextHomeScreen(
                          text: "${controller.selectedLockType} Lock",
                          color: AppColor.whiteColor,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w300,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  CustomTextHomeScreen(
                    text: "CONTACT SETTINGS",
                    color: AppColor.whiteColor,
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w300,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.contact_phone,
                            color: AppColor.whiteColor,
                            size: 25.w,
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          CustomTextHomeScreen(
                            text: "All Contacts",
                            color: AppColor.whiteColor,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w300,
                          ),
                        ],
                      ),
                      Radio(
                          activeColor: AppColor.primaryColor,
                          value: "",
                          groupValue: "",
                          onChanged: (value) {})
                    ],
                  ),
                  const Divider(
                    color: AppColor.whiteColor,
                  )
                ],
              ),
            );
          },
        ));
  }
}
