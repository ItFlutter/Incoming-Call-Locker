import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controller/homescreen_controller.dart';
import '../../../core/constant/appcolor.dart';

class SwitchButtonEnableAndDisableLock extends GetView<HomeScreenController> {
  final void Function(bool)? onChanged;
  const SwitchButtonEnableAndDisableLock({Key? key, this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Switch(
        activeColor: AppColor.blueColor,
        value: controller.activeSwitchLock,
        onChanged: onChanged);
  }
}
