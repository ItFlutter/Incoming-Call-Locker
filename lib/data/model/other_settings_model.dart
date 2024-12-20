import 'package:flutter/material.dart';

class OtherSettingsModel {
  final String title;
  final IconData iconTrealing;
  final IconData iconLeading;
  final void Function()? onTap;
  OtherSettingsModel({
    required this.title,
    required this.iconTrealing,
    required this.iconLeading,
    required this.onTap,
  });
}
