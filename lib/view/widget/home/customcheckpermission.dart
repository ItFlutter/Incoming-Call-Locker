import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared/customtext.dart';

class CustomCheckPermission extends StatelessWidget {
  final void Function()? onTap;
  final String title;
  final String description;
  final bool isGranted;
  const CustomCheckPermission(
      {Key? key,
      this.onTap,
      required this.title,
      required this.description,
      required this.isGranted})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 10.w),
        margin: EdgeInsets.symmetric(horizontal: 5.w),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: title,
                    color: AppColor.blackColor,
                    fontSize: 14.5.sp,
                    fontWeight: FontWeight.w600,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  CustomText(
                    text: isGranted ? "Permission Granted" : description,
                    color: AppColor.blackColor,
                    fontSize: 13.7.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ],
              ),
            ),
            isGranted
                ? Icon(
                    Icons.done,
                    size: 28.h,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
