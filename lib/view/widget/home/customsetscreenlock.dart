import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared/customtext.dart';

class CustomSetScreenLock extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final bool isEnrolled;
  const CustomSetScreenLock(
      {Key? key, this.onTap, required this.text, required this.isEnrolled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 115.h,
        padding: EdgeInsets.symmetric(vertical: 13.h, horizontal: 20.w),
        margin: EdgeInsets.only(right: 10.w, left: 5.w),
        decoration: BoxDecoration(
            color: AppColor.primaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundColor: AppColor.blueColor,
              maxRadius: 15,
              child: Icon(
                Icons.https,
                color: AppColor.whiteColor,
                size: 20.w,
              ),
            ),
            SizedBox(
              width: 15.h,
            ),
            CustomText(
              text: text,
              color: AppColor.blackColor,
              // fontSize: 16.sp,
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
            isEnrolled
                ? CustomText(
                    text: "Enrolled",
                    color: AppColor.blackColor,
                    fontSize: 13.7.sp,
                    fontWeight: FontWeight.w300,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
