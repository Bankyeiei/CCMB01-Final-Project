import 'package:get/get.dart';

import 'controller/login_validate_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginValidateController>(() => LoginValidateController());
  }
}
