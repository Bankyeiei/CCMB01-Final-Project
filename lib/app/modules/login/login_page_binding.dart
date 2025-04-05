import 'package:get/get.dart';

import 'controller/login_controller.dart';
import 'controller/remember_me_controller.dart';

class LoginPageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController());
    Get.lazyPut<RememberMeController>(() => RememberMeController());
  }
}
