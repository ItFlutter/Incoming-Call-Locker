import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/view/widget/callingsetting/customlisttileselectcontacts.dart';
import 'package:incoming_call_locker/view/widget/othersetting/customlisttileselectsetting.dart';
import '../../controller/Othersetting_controller.dart';
import '../../core/constant/appcolor.dart';
import '../../core/shared/customtext.dart';

class OtherSetting extends StatelessWidget {
  const OtherSetting({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(OtherSettingController());
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "OtherSetting",
            fontSize: 24.sp,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: GetBuilder<OtherSettingController>(
          builder: (controller) {
            return Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Column(
                children: [
                  CustomListTileSelectSetting(
                    title: "Privacy Policy",
                    iconLeading: Icons.lock_outline,
                    iconTrealing: Icons.chevron_right,
                  ),
                  Divider(
                    height: 1.h,
                    thickness: 1.3,
                  ),
                  CustomListTileSelectSetting(
                    title: "Share App",
                    iconLeading: Icons.share_outlined,
                    iconTrealing: Icons.chevron_right,
                  ),
                  Divider(
                    height: 1.h,
                    thickness: 1.3,
                  ),
                  CustomListTileSelectSetting(
                    title: "Rate Us",
                    iconLeading: Icons.thumb_up_alt_outlined,
                    iconTrealing: Icons.chevron_right,
                  ),
                  Divider(
                    height: 1.h,
                    thickness: 1.3,
                  ),
                  CustomListTileSelectSetting(
                    title: "Your Feed Back",
                    iconLeading: Icons.chat_outlined,
                    iconTrealing: Icons.chevron_right,
                  ),
                  Divider(
                    height: 1.h,
                    thickness: 1.3,
                  ),
                  CustomListTileSelectSetting(
                    title: "Language Setting",
                    iconLeading: Icons.translate_outlined,
                    iconTrealing: Icons.chevron_right,
                  ),
                  Divider(
                    height: 1.h,
                    thickness: 1.3,
                  ),
                ],
              ),
            );
          },
        ));
  }
}
