import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/app_routes.dart';
import 'package:incoming_call_locker/view/screen/confirm_password_lock_screen.dart';
import 'package:incoming_call_locker/view/screen/confirm_pattern_lock_screen.dart';
import 'package:incoming_call_locker/view/screen/home_screen.dart';
import 'package:incoming_call_locker/view/screen/password_lock_screen.dart';
import 'package:incoming_call_locker/view/screen/pattern_lock_screen.dart';
import 'package:incoming_call_locker/view/screen/repassword_lock_screen.dart';
import 'package:incoming_call_locker/view/screen/repattern_lock_screen.dart';
import 'package:incoming_call_locker/view/screen/specific_contacts.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen()),
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
  GetPage(
      name: AppRoutes.specificContacts, page: () => const SpecificContacts()),
  // GetPage(name: AppRoutes.otherSetting, page: () => const OtherSetting()),
];
