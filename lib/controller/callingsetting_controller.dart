import 'package:get/get.dart';

class CallingSettingController extends GetxController {
  int selectedContactType = 0;
  onSelectContactsType(int type) {
    selectedContactType = type;
    update();
  }
}
