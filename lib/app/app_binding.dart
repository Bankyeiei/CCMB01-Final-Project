import 'package:get/get.dart';

import '../core/controller/auth_state_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthStateController>(() => AuthStateController());
  }
}
