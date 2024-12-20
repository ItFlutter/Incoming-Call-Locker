import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';

class CustomAppBarTitle extends StatelessWidget {
  const CustomAppBarTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20.h, left: 30.w, right: 30.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomText(
            text: "Incoming Call Locker",
            color: Colors.white,
            fontSize: 22.sp,
            fontWeight: FontWeight.w600,
          ),
          SizedBox(
            height: 4.h,
          ),
          Text(
            "Incoming call locker help you to protect and secure your call from unauthorized person",
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w300,
                fontSize: 14.sp),
          ),
        ],
      ),
    );
  }
}
