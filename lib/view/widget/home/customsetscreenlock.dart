import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared/customtext.dart';

class CustomSetScreenLock extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final String path;
  final bool isEnrolled;

  const CustomSetScreenLock(
      {Key? key, this.onTap, required this.text, required this.path, required this.isEnrolled})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 120.h,
        padding: EdgeInsets.symmetric(vertical: 15.h, horizontal: 20.w),
        margin: EdgeInsets.only(right: 8.w, left: 5.w),
        decoration: BoxDecoration(
            border:
            Border.all(color: Colors.grey, width: 0.4),
            color: AppColor.whiteColor,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(path, height: 30, width: 30,),
            // SvgPicture.asset(path, allowDrawingOutsideViewBox: true,),
            SizedBox(
              width: 10.h,
            ),
            CustomText(
              text: text,
              color: AppColor.blackColor,
              // fontSize: 16.sp,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
            isEnrolled
                ? CustomText(
                    text: "Enrolled",
                    color: AppColor.blackColor,
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w300,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
