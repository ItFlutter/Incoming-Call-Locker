import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/home_screen_controller.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';

import 'custom_list_tile_select_contacts.dart';

class CallingSetting extends StatelessWidget {
  const CallingSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              text: "Calling Settings",
              color: AppColor.blackColor,
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
            CustomListTileSelectContacts(
              title: "All Contacts",
              subtitle: controller.selectedContactType == 0
                  ? "Enabled"
                  : "Not Enable",
              icon: Icons.contact_phone,
              value: controller.selectedContactType == 0 ? true : false,
              onPressedSwitch: (value) {
                controller.onSelectContactsType(0);
                controller.myServices.sharedPreferences
                    .setInt("callingsetting", 0);
                controller.sqlDb.mydeleteDatabase();
              },
            ),
            Divider(
              height: 0.1.h,
              thickness: 0.5.h,
            ),
            CustomListTileSelectContacts(
              title: "Unknown Contacts",
              subtitle: controller.selectedContactType == 1
                  ? "Enabled"
                  : "Not Enable",
              value: controller.selectedContactType == 1 ? true : false,
              icon: Icons.groups,
              onPressedSwitch: (value) {
                controller.onSelectContactsType(1);
                controller.myServices.sharedPreferences
                    .setInt("callingsetting", 1);
                controller.sqlDb.mydeleteDatabase();
              },
            ),
            Divider(
              height: 0.1.h,
              thickness: 0.5.h,
            ),
            InkWell(
              onTap: () async {
                await Get.toNamed(AppRoutes.specificContacts);
                Get.back();
              },
              child: CustomListTileSelectContacts(
                title: "Specific Contacts",
                subtitle: controller.selectedContactType == 2
                    ? "Select Contacts"
                    : "Not Selected",
                icon: Icons.manage_accounts,
                value: controller.selectedContactType == 2 ? true : false,
                onPressedSwitch: (value) async {
                  // controller.onSelectContactsType(2);
                  await Get.toNamed(AppRoutes.specificContacts);
                  Get.back();
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
