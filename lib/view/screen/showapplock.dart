import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:incoming_call_locker/view/widget/showapplock/passwordcodewidget.dart';
import '../../controller/showapplock_controller.dart';
import '../widget/patternlock/patternlockwidget.dart';

class OverlayMyApp extends StatelessWidget {
  const OverlayMyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    print("============================================================");
    print(
        "=====================================OverlayMyApp=======================");
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          getPages: [
            GetPage(name: "/", page: () => const ShowAppLock()),
          ],
        );
      },
    );
  }
}

class ShowAppLock extends StatelessWidget {
  const ShowAppLock({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("============================================================");
    print(
        "===================================height=========================${Get.height}");
    Get.put(ShowAppLockController());

    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: GetBuilder<ShowAppLockController>(builder: (controller) {
          print(
              "===================================heightGetBuilder=========================${Get.height}");
          return ScreenUtilInit(
            designSize: const Size(360, 690),
            minTextAdapt: true,
            splitScreenMode: true,
            builder: (_, child) {
              return controller.storedPatternCode.isNotEmpty
                  ? PatternLockWidget(onInputComplete: (List<int> input) {
                      controller.onPatterncodeEntered(input);
                    })
                  : controller.storedPassCode.isNotEmpty
                      ? SizedBox(
                          // width: 200,
                          height: Get.height,
                          child: PasswordCodeWidget(
                              title: "Enter Password",
                              passwordEnteredCallback:
                                  (String passwordEntered) {
                                controller.onPasscodeEntered(passwordEntered);
                              },
                              shouldTriggerVerification:
                                  controller.verificationNotifier.stream))
                      : Container();
            },
          );
        })));
  }
}
