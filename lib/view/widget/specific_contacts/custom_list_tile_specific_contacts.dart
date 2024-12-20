import 'package:flutter/material.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';

import '../../../core/constant/app_color.dart';

class CustomListTileSpecificContacts extends StatelessWidget {
  final String title;
  final String subTitle;
  final Widget iconSelectedOrNot;
  final void Function()? onTap;
  const CustomListTileSpecificContacts(
      {Key? key,
      required this.title,
      required this.subTitle,
      required this.iconSelectedOrNot,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
          backgroundColor: AppColor.blueColor, child: Icon(Icons.person)),
      title: CustomText(text: title),
      subtitle: CustomText(text: subTitle),
      trailing: iconSelectedOrNot,
      onTap: onTap,
    );
  }
}
