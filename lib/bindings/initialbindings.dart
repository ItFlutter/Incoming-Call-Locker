import 'package:get/get.dart';

import '../core/class/sqldb.dart';

class InitialBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(SqlDb());
  }
}
