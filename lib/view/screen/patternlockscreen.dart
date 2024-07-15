import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';
import 'package:incoming_call_locker/core/shared/activepagecontainer.dart';
import 'package:incoming_call_locker/view/widget/patternlock/patternlockwidget.dart';
import '../../controller/patternlock_controller.dart';

class PatternLockScreen extends StatelessWidget {
  const PatternLockScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    Get.put(PatternLockScreenController());
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: "Pattern",
          fontSize: 24.sp,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<PatternLockScreenController>(
        builder: (controller) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...List.generate(
                    controller.numberOfPage,
                    (int index) {
                      return ActivePageContainer(
                          isActive:
                              controller.currentIndex == index ? true : false);
                    },
                  ),
                ],
              ),
              SizedBox(
                height: 166.h,
              ),
              CustomText(
                text: "Enter New Pattern",
                color: AppColor.blueColor,
                fontSize: 18.sp,
                fontWeight: FontWeight.w500,
              ),
              Expanded(
                  child: PatternLockWidget(onInputComplete: (List<int> input) {
                controller.onPatterncodeEntered(input);
              })),
            ],
          );
        },
      ),
    );
  }
}
