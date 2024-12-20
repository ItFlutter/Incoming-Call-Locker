import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';
import 'package:incoming_call_locker/core/constant/app_image_asset.dart';
import 'package:incoming_call_locker/core/shared/custom_text.dart';

class CustomShowInstruction extends StatelessWidget {
  const CustomShowInstruction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      InteractiveViewer(child: Image.asset(AppImageAsset.guide)),
      Expanded(
        child: Container(
          color: const Color(0xfffdfbfe),
          child: CustomText(
            text: "Please apply this instruction to work app correctly",
            textAlign: TextAlign.center,
            fontSize: 12.sp,
            color: AppColor.blackColor,
          ),
        ),
      )
    ]);
  }
}
