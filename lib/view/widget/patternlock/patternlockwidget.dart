import 'package:flutter/material.dart';
import 'package:pattern_lock/pattern_lock.dart';
import '../../../core/constant/appcolor.dart';

class PatternLockWidget extends StatelessWidget {
  final Function(List<int>) onInputComplete;
  const PatternLockWidget({Key? key, required this.onInputComplete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PatternLock(
      onInputComplete: onInputComplete,
      selectedColor: AppColor.blueColor,
      notSelectedColor: AppColor.greyColor,
    );
  }
}
