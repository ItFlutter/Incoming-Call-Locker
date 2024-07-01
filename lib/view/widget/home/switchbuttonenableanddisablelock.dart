import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/cntroller/homescreen_controller.dart';

import '../../../core/constant/appcolor.dart';

class SwitchButtonEnableAndDisableLock extends GetView<HomeScreenController> {
  final void Function(bool)? onChanged;
  const SwitchButtonEnableAndDisableLock({Key? key, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: AppColor.primaryColor,
        value: controller.activeSwitchLock,
        onChanged: onChanged);
  }
}
