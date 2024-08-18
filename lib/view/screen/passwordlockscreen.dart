import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/passwordlock_controller.dart';
import 'package:incoming_call_locker/core/constant/appcolor.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';
import 'package:incoming_call_locker/core/shared/activepagecontainer.dart';
import 'package:incoming_call_locker/view/widget/passwordlock/passcodewidget.dart';

class PasswordLockScreen extends StatelessWidget {
  const PasswordLockScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(PasswordLockScreenController());
    return Scaffold(
      backgroundColor: AppColor.whiteColor,
      appBar: AppBar(
        title: CustomText(
          text: "Password",
          fontSize: 24.sp,
          color: AppColor.blackColor,
          fontWeight: FontWeight.w600,
        ),
      ),
      body: GetBuilder<PasswordLockScreenController>(
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
              // SizedBox(
              // height: 166.h,
              // ),
              SizedBox(
                height: 130.h,
              ),
              Expanded(
                  child: PasscodeWidget(
                title: "Enter New Password",
                passwordEnteredCallback: (String passwordEntered) {
                  controller.onPasscodeEntered(passwordEntered);
                },
                shouldTriggerVerification:
                    controller.verificationNotifier.stream,
                cancelCallback: () {
                  controller.backPage();
                  // controller.verificationNotifier.add(false);
                  // print("==================================Cancel");
                },
                // isValidCallback: () {
                //   print("==================================valid");
                // }
              )),
            ],
          );
        },
      ),
    );
  }
}
