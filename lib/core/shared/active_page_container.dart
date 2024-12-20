import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constant/app_color.dart';

class ActivePageContainer extends StatelessWidget {
  final bool isActive;

  const ActivePageContainer({Key? key, required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      width: 80.w,
      decoration: BoxDecoration(
          border: Border.all(
              width: 2,
              color: isActive ? AppColor.blueColor : AppColor.greyColor),
          borderRadius: BorderRadius.circular(10),
          color: AppColor.blueColor),
    );
  }
}
