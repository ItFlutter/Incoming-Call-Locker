import 'package:flutter/material.dart';

import '../constant/appcolor.dart';

class SwitchButtonEnableAndDisable extends StatelessWidget {
  final void Function(bool)? onChanged;
  final bool value;

  const SwitchButtonEnableAndDisable(
      {Key? key, required this.onChanged, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: AppColor.blueColor, value: value, onChanged: onChanged);
  }
}
