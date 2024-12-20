import 'package:flutter/material.dart';
import 'package:incoming_call_locker/core/constant/app_color.dart';

ThemeData? theme = ThemeData(
    appBarTheme: const AppBarTheme(
        elevation: 0.0,
        backgroundColor: AppColor.transparentColor,
        iconTheme: IconThemeData(color: AppColor.blackColor)),
    canvasColor: AppColor.backgroundcolor);
