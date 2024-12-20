import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/constant/app_image_asset.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';
import 'package:incoming_call_locker/core/shared/switch_button_enable_and_disable_lock.dart';
import 'package:incoming_call_locker/view/widget/home/custom_check_permission.dart';
import 'package:incoming_call_locker/view/widget/home/custom_home_app_bar.dart';
import 'package:incoming_call_locker/view/widget/home/custom_set_screen_lock.dart';
import 'package:incoming_call_locker/view/widget/home/permissions_section.dart';
import 'package:incoming_call_locker/view/widget/home/set_passwords_section.dart';

import '../../controller/home_screen_controller.dart';
import '../widget/home/custom_app_bar_title.dart';
import '../widget/home/calling_setting.dart';
import '../widget/home/custom_list_tile_select_setting.dart';

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
              const CustomHomeAppBar(),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const PermissionsSection(),
                        const SetPasswordsSection(),
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
                            ListView.separated(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemBuilder: (context, int index) {
                                  return CustomListTileSelectSetting(
                                    onTap:
                                        controller.otherSettings[index].onTap,
                                    title:
                                        controller.otherSettings[index].title,
                                    iconLeading: controller
                                        .otherSettings[index].iconLeading,
                                    iconTrealing: controller
                                        .otherSettings[index].iconTrealing,
                                  );
                                },
                                separatorBuilder: (context, int index) {
                                  return Divider(
                                    height: 0.1.h,
                                    thickness: 0.5.h,
                                  );
                                },
                                itemCount: controller.otherSettings.length),
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
