import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/controller/main_controller.dart';
import 'package:incoming_call_locker/core/constant/app_theme.dart';
import 'package:incoming_call_locker/core/services/my_services.dart';
import 'package:incoming_call_locker/view/screen/show_app_lock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes.dart';

void main() async {
  print("========== main ==========");
  MyServices? myServices = await initialServices();
  MainController mainController = Get.put(MainController());
  if (mainController.startActivity == "start") {
    sharedPref = await SharedPreferences.getInstance();

    String callerNumber = sharedPref!.getString('caller_number') ?? '';
    String callerName = sharedPref!.getString('caller_name') ?? '';
    print("========== callerNumber ==========$callerNumber");
    print("========== callerName ==========$callerName");
    await mainController.processCall(callerNumber, callerName);
  } else {
    runApp(const MyApp());
  }
}

SharedPreferences? sharedPref;
// overlay entry point
@pragma("vm:entry-point")
void overlayMain() async {
  print("========== overlayMain ==========");
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  runApp(const ShowAppLock());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Incoming Call Locker',
          // initialBinding: InitialBindings(),
          theme: theme,
          getPages: routes,
        );
      },
    );
  }
}
