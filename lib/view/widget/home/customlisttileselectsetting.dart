import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/constant/appcolor.dart';
import '../../../core/shared/customtext.dart';

class CustomListTileSelectSetting extends StatelessWidget {
  final IconData? iconLeading;
  final IconData? iconTrealing;
  final String title;
  final void Function()? onTap;

  const CustomListTileSelectSetting(
      {Key? key,
      this.iconLeading,
      this.iconTrealing,
      required this.title,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(iconLeading),
      title: CustomText(
        text: title,
        color: AppColor.greyColor,
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      trailing: Icon(iconTrealing),
    );
  }
}
