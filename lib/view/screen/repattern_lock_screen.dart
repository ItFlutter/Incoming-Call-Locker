import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';
import 'package:incoming_call_locker/core/shared/active_page_container.dart';
import '../../controller/repattern_lock_controller.dart';
import '../widget/pattern_lock/pattern_lock_widget.dart';

class RePatternLockScreen extends StatelessWidget {
  const RePatternLockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(RePatternLockScreenController());
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: "RePattern",
          fontSize: 24.sp,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<RePatternLockScreenController>(
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
                text: "Enter Old Pattern",
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
