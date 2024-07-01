import 'package:get/get.dart';

class HomeScreenController extends GetxController {
  bool activeSwitchLock = false;
  String selectedLockType = "Passcode";
  // String textSwitchLock = "Disable Lock";
  onClickSwitchLock(bool value) {
    activeSwitchLock = !activeSwitchLock;
    print("============================================================");
    print(
        "=====================================activeSwitchLock=======================$activeSwitchLock");
    update();
  }

  onChangedLockType(String value) {
    selectedLockType = value;
    print("============================================================");
    print(
        "=====================================selectedLockType=======================$selectedLockType");
    update();
  }
}
