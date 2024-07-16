import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import 'package:incoming_call_locker/test.dart';
import 'package:incoming_call_locker/view/screen/callingsetting.dart';
import 'package:incoming_call_locker/view/screen/confirmpasswordlockscreen.dart';
import 'package:incoming_call_locker/view/screen/confirmpatternlockscreen.dart';
import 'package:incoming_call_locker/view/screen/homescreen.dart';
import 'package:incoming_call_locker/view/screen/othersetting.dart';
import 'package:incoming_call_locker/view/screen/passwordlockscreen.dart';
import 'package:incoming_call_locker/view/screen/patternlockscreen.dart';
import 'package:incoming_call_locker/view/screen/repasswordlockscreen.dart';
import 'package:incoming_call_locker/view/screen/repatternlockscreen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),
  GetPage(name: AppRoutes.testScreen, page: () => const Test()),
  GetPage(
      name: AppRoutes.passwordlockScreen,
      page: () => const PasswordLockScreen()),
  GetPage(
      name: AppRoutes.confirmPasswordlockScreen,
      page: () => const ConfirmPasswordLockScreen()),
  GetPage(
      name: AppRoutes.rePasswordlockScreen,
      page: () => const RePasswordLockScreen()),
  GetPage(
      name: AppRoutes.patternlockScreen, page: () => const PatternLockScreen()),
  GetPage(
      name: AppRoutes.confirmPatternlockScreen,
      page: () => const ConfirmPatternLockScreen()),
  GetPage(
      name: AppRoutes.rePatternlockScreen,
      page: () => const RePatternLockScreen()),
  GetPage(name: AppRoutes.callingSetting, page: () => const CallingSetting()),
  GetPage(name: AppRoutes.otherSetting, page: () => const OtherSetting()),
];
