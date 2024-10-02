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
            border:
            Border.all(color: Colors.grey, width: 0.4),
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
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
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),

                  CustomText(
                    text: isGranted ? "Permission Granted" : description,
                    color: AppColor.blackColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ],
              ),
            ),
            isGranted
                ? Icon(
                    Icons.done,
                    size: 25.h,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
