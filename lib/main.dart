import 'package:flutter/material.dart';
import 'package:flutter_overlay_window/flutter_overlay_window.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/core/class/sqldb.dart';
import 'package:incoming_call_locker/core/constant/apptheme.dart';
import 'package:incoming_call_locker/core/services/myservices.dart';
import 'package:incoming_call_locker/view/screen/showapplock.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'routes.dart';

//shared
late bool activeSwitchLock;
late int selectedContactType;
late String storedPassCode;
late String storedPatternCode;
List<String> contactsSpecifiedNamesInDb = [];
late SqlDb sqlDb;

getContactsFromDb() async {
  List<Map> data = await sqlDb.readData('select * from incomingcalllocker');
  print("============================================================");
  print(
      "=====================================data=======================$data");
  if (data.isNotEmpty) {
    contactsSpecifiedNamesInDb.addAll(data.map(
      (e) => e['name'],
    ));
    print("============================================================");
    print(
        "=====================================contactsSpecifiedNamesInDb=======================$contactsSpecifiedNamesInDb");
  }
}

void main() async {
  print("============================================================");
  print("=====================================main=======================");
  WidgetsFlutterBinding.ensureInitialized();
  sqlDb = Get.put(SqlDb());
  await initialServices();
  MyServices myServices = Get.find();
  String startactivity =
      myServices.sharedPreferences.getString("startactivity") ?? "";
  print(
      "=====================================startactivity=======================$startactivity");
  activeSwitchLock =
      myServices.sharedPreferences.getBool("lockactivited") ?? false;
  print("============================================================");
  print(
      "=====================================activeSwitchLock=======================$activeSwitchLock");
  selectedContactType =
      myServices.sharedPreferences.getInt("callingsetting") ?? 0;
  print("============================================================");
  print(
      "=====================================selectedContactType=======================$selectedContactType");
  if (selectedContactType == 2) {
    await getContactsFromDb();
  }
  storedPassCode =
      myServices.sharedPreferences.getString("storedpasscode") ?? "";
  print("============================================================");
  print(
      "=====================================storedPassCode=======================$storedPassCode");
  storedPatternCode =
      myServices.sharedPreferences.getString("storedpatterncode") ?? "";
  print("============================================================");
  print(
      "=====================================storedPatternCode=======================$storedPatternCode");
  String callerNumber =
      myServices.sharedPreferences.getString('caller_number') ?? '';
  String callerName =
      myServices.sharedPreferences.getString('caller_name') ?? '';
  print("============================================================");
  print(
      "=====================================callerNumber=======================$callerNumber");
  print("============================================================");
  print(
      "=====================================callerName=======================$callerName");
  if (callerNumber.isNotEmpty) {
    if (selectedContactType == 2 &&
        contactsSpecifiedNamesInDb.contains(callerName)) {
      await FlutterOverlayWindow.showOverlay(
          alignment: OverlayAlignment.bottomCenter);
      await FlutterOverlayWindow.shareData({
        "storedPassCode": storedPassCode,
        "storedPatternCode": storedPatternCode,
      });
    }
    if (selectedContactType == 0 || selectedContactType == 1) {
      await FlutterOverlayWindow.showOverlay(
          alignment: OverlayAlignment.bottomCenter);
      await FlutterOverlayWindow.shareData({
        "storedPassCode": storedPassCode,
        "storedPatternCode": storedPatternCode,
      });
    }
    await myServices.sharedPreferences.remove('caller_number');
    await myServices.sharedPreferences.remove('caller_name');
  }
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
          // initialBinding: InitialBindings(),
          theme: theme,
          getPages: routes,
        );
      },
    );
  }
}
