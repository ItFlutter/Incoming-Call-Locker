import 'package:flutter/services.dart';
import 'package:get/get.dart';

class TestController extends GetxController {
  static const channel =
      MethodChannel("com.example.incoming_call_locker/incomingCall");
  String isCallIncoming = "";

  // Future playMusic() async {
  //   print(
  //       "=======================Before Run=====================================");

  //   await channel.invokeMethod("playMusic").then((value) {
  //     print("============================================================");
  //     print(
  //         "=====================================fromAndroidSide=======================$value");
  //   });
  // }

  int i = 0;
  @override
  void onInit() {
    channel.setMethodCallHandler((call) async {
      print("============================================================");
      print("=====================================i=======================$i");
      switch (call.method) {
        case 'incomingCall':
          isCallIncoming = call.arguments as String;
          print("============================================================");
          print(
              "=====================================isCallIncoming=======================$isCallIncoming");
          update();
          break;
        default:
          print("============================================================");
          print(
              "=====================================default=======================$isCallIncoming");
          throw MissingPluginException('Not implemented: ${call.method}');
      }
      i = 1;
    });
    // TODO: implement onInit
    super.onInit();
  }
}
