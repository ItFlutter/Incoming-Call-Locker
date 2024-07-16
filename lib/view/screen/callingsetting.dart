import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/callingsetting_controller.dart';
import 'package:incoming_call_locker/view/widget/callingsetting/customlisttileselectcontacts.dart';
import '../../core/constant/appcolor.dart';
import '../../core/shared/customtext.dart';
import '../../core/shared/switchbuttonenableanddisablelock.dart';

class CallingSetting extends StatelessWidget {
  const CallingSetting({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(CallingSettingController());
    return Scaffold(
        appBar: AppBar(
          title: CustomText(
            text: "CallingSetting",
            fontSize: 24.sp,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: GetBuilder<CallingSettingController>(
          builder: (controller) {
            return Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(8.0.w),
                  child: Card(
                    child: Column(
                      children: [
                        CustomListTileSelectContacts(
                          title: "All Contacts",
                          subtitle: controller.selectedContactType == 0
                              ? "Enabled"
                              : "",
                          icon: Icons.contact_phone,
                          value: controller.selectedContactType == 0
                              ? true
                              : false,
                          onPressedSwitch: (value) {
                            controller.onSelectContactsType(0);
                          },
                        ),
                        const Divider(),
                        CustomListTileSelectContacts(
                          title: "Unknown Contacts",
                          subtitle: controller.selectedContactType == 1
                              ? "Enabled"
                              : "",
                          value: controller.selectedContactType == 1
                              ? true
                              : false,
                          icon: Icons.groups,
                          onPressedSwitch: (value) {
                            controller.onSelectContactsType(1);
                          },
                        ),
                        const Divider(),
                        CustomListTileSelectContacts(
                          title: "Specific Contacts",
                          subtitle: controller.selectedContactType == 2
                              ? "select contacts"
                              : "",
                          icon: Icons.manage_accounts,
                          value: controller.selectedContactType == 2
                              ? true
                              : false,
                          onPressedSwitch: (value) {
                            controller.onSelectContactsType(2);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }
}
