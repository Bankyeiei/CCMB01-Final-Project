import 'package:get/get.dart';

import '../core/controller/auth_state_controller.dart';
import '../core/controller/loading_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<LoadingController>(LoadingController(), permanent: true);
    Get.lazyPut<AuthStateController>(
      () =>
          AuthStateController(loadingController: Get.find<LoadingController>()),
    );
  }
}
