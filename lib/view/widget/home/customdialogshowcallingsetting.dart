import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/homescreen_controller.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';

import 'customlisttileselectcontacts.dart';

class CustomDialogShowCallingSetting extends StatelessWidget {
  const CustomDialogShowCallingSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeScreenController>(
      builder: (controller) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.all(8.0.w),
              child: Card(
                child: Column(
                  children: [
                    CustomListTileSelectContacts(
                      title: "All Contacts",
                      subtitle:
                          controller.selectedContactType == 0 ? "Enabled" : "",
                      icon: Icons.contact_phone,
                      value: controller.selectedContactType == 0 ? true : false,
                      onPressedSwitch: (value) {
                        controller.onSelectContactsType(0);
                      },
                    ),
                    const Divider(),
                    CustomListTileSelectContacts(
                      title: "Unknown Contacts",
                      subtitle:
                          controller.selectedContactType == 1 ? "Enabled" : "",
                      value: controller.selectedContactType == 1 ? true : false,
                      icon: Icons.groups,
                      onPressedSwitch: (value) {
                        controller.onSelectContactsType(1);
                        controller.myServices.sharedPreferences
                            .setInt("callingsetting", 1);
                      },
                    ),
                    const Divider(),
                    InkWell(
                      onTap: () async {
                        await Get.toNamed(AppRoutes.specificContacts);
                        Get.back();
                      },
                      child: CustomListTileSelectContacts(
                        title: "Specific Contacts",
                        subtitle: controller.selectedContactType == 2
                            ? "click to select contacts"
                            : "",
                        icon: Icons.manage_accounts,
                        value:
                            controller.selectedContactType == 2 ? true : false,
                        onPressedSwitch: (value) async {
                          // controller.onSelectContactsType(2);
                          await Get.toNamed(AppRoutes.specificContacts);
                          Get.back();
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
