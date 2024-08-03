import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/bindings/initialbindings.dart';
import 'package:incoming_call_locker/core/constant/apptheme.dart';
import 'package:incoming_call_locker/core/services/myservices.dart';
import 'package:incoming_call_locker/view/screen/showapplock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes.dart';

void main() async {
  print("============================================================");
  print("=====================================main=======================");
  WidgetsFlutterBinding.ensureInitialized();
  await initialServices();
  runApp(const MyApp());
}

SharedPreferences? sharedPref;
// overlay entry point
@pragma("vm:entry-point")
void overlayMain() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();
  print("============================================================");
  print(
      "=====================================overlayMain=======================");
  runApp(const ShowAppLock());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
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
          initialBinding: InitialBindings(),
          theme: theme,
          getPages: routes,
        );
      },
    );
  }
}
