import 'package:get/get.dart';
import '../core/constant/approutes.dart';

class PatternLockScreenController extends GetxController {
  late int currentIndex;
  late int numberOfPage;
  String patterncode = "";

  onPatterncodeEntered(List<int> enteredPatterncode) {
    // patterncode = utf8.decode(enteredPatterncode);
    patterncode = enteredPatterncode.map((i) => i.toString()).join("");
    print("============================================================");
    print(
        "=====================================patterncode=======================$patterncode");
    Get.toNamed(AppRoutes.confirmPatternlockScreen, arguments: {
      "patterncode": patterncode,
      "currentindex": currentIndex + 1,
      "numberofpage": numberOfPage,
    });
  }

  @override
  void onInit() {
    numberOfPage = Get.previousRoute == "/" ? 2 : Get.arguments['numberofpage'];
    currentIndex = Get.previousRoute == "/" ? 0 : Get.arguments['currentindex'];
    print(
        "=====================================currentIndex=======================$currentIndex");
    print("============================================================");
    print(
        "=====================================numberOfPage=======================$numberOfPage");
    // TODO: implement onInit
    super.onInit();
  }
}
