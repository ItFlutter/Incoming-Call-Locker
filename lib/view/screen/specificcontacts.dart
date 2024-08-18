import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/specificcontacts_controller.dart';
import 'package:incoming_call_locker/view/widget/specificcontacts/customfloatingactionbuttonspecificcontacts.dart';
import 'package:incoming_call_locker/view/widget/specificcontacts/customlisttilespecificontacts.dart';
import 'package:incoming_call_locker/view/widget/specificcontacts/customloadingspecificcontacts.dart';
import '../../core/constant/appcolor.dart';
import '../../core/shared/customtext.dart';

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
