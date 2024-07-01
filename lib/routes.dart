import 'package:get/get.dart';
import 'package:incoming_call_locker/core/constant/approutes.dart';
import 'package:incoming_call_locker/view/screen/homescreen.dart';

List<GetPage<dynamic>>? routes = [
  GetPage(name: AppRoutes.homeScreen, page: () => const HomeScreen())
];
