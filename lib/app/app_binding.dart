import 'package:get/get.dart';

import '../core/controller/global/auth_state_controller.dart';
import '../core/controller/global/loading_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoadingController>(LoadingController(), permanent: true);
    Get.put<AuthStateController>(AuthStateController(), permanent: true);
  }
}
