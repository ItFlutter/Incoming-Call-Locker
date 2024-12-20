import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/shared/custom_text.dart';
import '../../../core/shared/switch_button_enable_and_disable_lock.dart';

class CustomListTileSelectContacts extends StatelessWidget {
  final IconData? icon;
  final String title;
  final String subtitle;
  final bool value;
  final void Function(bool)? onPressedSwitch;

  const CustomListTileSelectContacts(
      {Key? key,
      this.icon,
      required this.title,
      required this.subtitle,
      this.onPressedSwitch,
      required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20.h,
      ),
      minLeadingWidth: 10.w,
      title:
          CustomText(text: title, fontSize: 14.sp, fontWeight: FontWeight.w500),
      trailing: SwitchButtonEnableAndDisable(
        value: value,
        onChanged: onPressedSwitch,
      ),
      subtitle: CustomText(
        text: subtitle,
        fontSize: 12.sp,
      ),
    );
  }
}
