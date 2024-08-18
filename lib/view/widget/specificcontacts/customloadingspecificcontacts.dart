import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:incoming_call_locker/core/shared/customtext.dart';

import '../../../core/constant/appcolor.dart';

class CustomLoadingSpecificContacts extends StatelessWidget {
  const CustomLoadingSpecificContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CustomText(
            text: "Please wait seconds",
            fontWeight: FontWeight.w400,
          ),
          SizedBox(
            height: 8.h,
          ),
          const CircularProgressIndicator(
            color: AppColor.blueColor,
          ),
        ],
      ),
    );
  }
}
