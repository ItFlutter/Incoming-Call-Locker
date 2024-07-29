import 'package:flutter/material.dart';

import '../../../core/constant/appcolor.dart';

class CustomLoadingSpecificContacts extends StatelessWidget {
  const CustomLoadingSpecificContacts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        color: AppColor.blueColor,
      ),
    );
  }
}
