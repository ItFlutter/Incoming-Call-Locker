import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/home_screen_controller.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';
import 'package:incoming_call_locker/core/shared/switch_button_enable_and_disable_lock.dart';
import 'package:incoming_call_locker/view/widget/home/custom_app_bar_title.dart';

class CustomHomeAppBar extends StatelessWidget {
  const CustomHomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(builder: (controller) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              height: 150.h /*height*0.23*/,
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
            const CustomAppBarTitle(),
            Container(
                height: 62.h /*height * 0.18*/,
                margin: EdgeInsets.only(
                    top: 115.h /*height * 0.164*/, left: 20.w, right: 20.w),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 0.4),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
      );
    });
  }
}
