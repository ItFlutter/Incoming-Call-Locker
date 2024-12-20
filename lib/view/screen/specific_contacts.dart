import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/specific_contacts_controller.dart';
import 'package:incoming_call_locker/view/widget/specific_contacts/custom_floating_action_button_specific_contacts.dart';
import 'package:incoming_call_locker/view/widget/specific_contacts/custom_list_tile_specific_contacts.dart';
import 'package:incoming_call_locker/view/widget/specific_contacts/custom_loading_specific_contacts.dart';
import '../../core/constant/app_color.dart';
import '../../core/shared/custom_text.dart';

class SpecificContacts extends StatelessWidget {
  const SpecificContacts({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SpecificContactsController());
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: GetBuilder<SpecificContactsController>(
          builder: (controller) {
            return CustomFloatingActionButtonSpecificContacts(
              text: "Select ${controller.contactsSpecified.length}",
              onPressed: () {
                controller.addContactsSpecifiedToDb();
              },
            );
          },
        ),
        appBar: AppBar(
          title: CustomText(
            text: "SpecificContacts",
            fontSize: 24.sp,
            color: AppColor.blackColor,
            fontWeight: FontWeight.w600,
          ),
        ),
        body: GetBuilder<SpecificContactsController>(
          builder: (controller) {
            return controller.isLoading
                ? const CustomLoadingSpecificContacts()
                : ListView.builder(
                    itemCount: controller.contactsModel.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CustomListTileSpecificContacts(
                            title: controller.contactsModel[index].name,
                            subTitle: controller.contactsModel[index].phone,
                            iconSelectedOrNot:
                                controller.contactsModel[index].isSelected
                                    ? const Icon(
                                        Icons.check_circle,
                                        color: AppColor.greenColor,
                                      )
                                    : const Icon(Icons.check_circle_outline),
                            onTap: () {
                              controller.onTapContact(index);
                            },
                          ),
                          Divider(
                            height: 0.1.h,
                            thickness: 1.5.h,
                          )
                        ],
                      );
                    },
                  );
          },
        ));
  }
}
