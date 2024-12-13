// import 'package:flutter/services.dart';
// import 'package:flutter_overlay_window/flutter_overlay_window.dart';
// import 'package:get/get.dart';
// import 'package:incoming_call_locker/core/services/myservices.dart';

// class MainController extends GetxController {
//   MyServices myServices = Get.find();
//   late String startActivity;
//   late int selectedContactType;
//   List<String> contactsSpecifiedNamesInDb = [];
//   String status = "";
//   static const channel =
//       MethodChannel("com.example.incoming_call_locker/incomingCall");

//   getContactsFromDb() async {
//     contactsSpecifiedNamesInDb.clear();
//     List<Map> data =
//         await myServices.sqlDb.readData('select * from incomingcalllocker');
//     print("====================");
//     print("========== data ========== $data");
//     if (data.isNotEmpty) {
//       contactsSpecifiedNamesInDb.addAll(data.map(
//         (e) => e['name'],
//       ));
//       print("====================");
//       print(
//           "========== contactsSpecifiedNamesInDb ========== $contactsSpecifiedNamesInDb");
//     }
//   }

//   Future<void> setupMethodChannel() async {
//     channel.setMethodCallHandler((call) async {
//       switch (call.method) {
//         case 'incomingCall':
//           status = "incomingCall";
//           processCall(call.arguments['number'], call.arguments['name']);
//           break;
//         case 'callEnded':
//           await handleCallEnded();
//           break;
//         default:
//           throw MissingPluginException('Not implemented: ${call.method}');
//       }
//     });
//   }

//   Future<void> processCall(String callerNumber, String callerName) async {
//     selectedContactType =
//         myServices.sharedPreferences.getInt("callingsetting") ?? 0;
//     if (selectedContactType == 2) {
//       await getContactsFromDb();
//     }
//     bool shouldShowOverlay =
//         selectedContactType == 0 || selectedContactType == 1;
//     if (selectedContactType == 2 &&
//         contactsSpecifiedNamesInDb.contains(callerName)) {
//       shouldShowOverlay = true;
//     }

//     if (shouldShowOverlay) {
//       await FlutterOverlayWindow.showOverlay(
//           alignment: OverlayAlignment.bottomCenter);
//       await FlutterOverlayWindow.shareData({
//         "storedPassCode":
//             myServices.sharedPreferences.getString("storedpasscode") ?? "",
//         "storedPatternCode":
//             myServices.sharedPreferences.getString("storedpatterncode") ?? "",
//       });
//     }
//     if (status != "incomingCall") {
//       print("========== status != incomingCall ==========");
//       MyServices myServices = Get.find();
//       await myServices.sharedPreferences.remove('caller_number');
//       await myServices.sharedPreferences.remove('caller_name');
//     }
//   }

//   Future<void> handleCallEnded() async {
//     if (await FlutterOverlayWindow.isActive()) {
//       await FlutterOverlayWindow.shareData({
//         "storedPassCode":
//             myServices.sharedPreferences.getString("storedpasscode") ?? "",
//         "storedPatternCode":
//             myServices.sharedPreferences.getString("storedpatterncode") ?? "",
//         "resetstreamcontroller": true,
//       });
//       print("========== ShareData from Main Controller Active ==========");
//       await FlutterOverlayWindow.closeOverlay();
//       if (myServices.sharedPreferences.getString("startactivity") == "start") {
//         await SystemNavigator.pop();
//       }
//     } else {
//       await FlutterOverlayWindow.shareData({
//         "storedPassCode":
//             myServices.sharedPreferences.getString("storedpasscode") ?? "",
//         "storedPatternCode":
//             myServices.sharedPreferences.getString("storedpatterncode") ?? "",
//         "resetstreamcontroller": true,
//       });
//       print("========== ShareData from Main Controller Not Active ==========");
//       if (myServices.sharedPreferences.getString("startactivity") == "start") {
//         await SystemNavigator.pop();
//       }
//     }
//     print("========== Call Ended Main ==========");
//   }

//   @override
//   void onInit() {
//     startActivity =
//         myServices.sharedPreferences.getString("startactivity") ?? "";
//     print("========== startActivityMainController ========== $startActivity");
//     super.onInit();
//   }
// }
