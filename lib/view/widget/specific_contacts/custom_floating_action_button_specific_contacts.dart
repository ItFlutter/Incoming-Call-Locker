import 'package:flutter/material.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';
import '../../../core/constant/app_color.dart';

class CustomFloatingActionButtonSpecificContacts extends StatelessWidget {
  final String text;
  final void Function()? onPressed;
  const CustomFloatingActionButtonSpecificContacts(
      {Key? key, required this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      label: CustomText(
        text: text,
        color: AppColor.whiteColor,
      ),
      onPressed: onPressed,
      backgroundColor: AppColor.blueColor,
    );
  }
}
