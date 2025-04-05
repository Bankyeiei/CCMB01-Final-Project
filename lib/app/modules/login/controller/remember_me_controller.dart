import 'package:get/get.dart';

class RememberMeController extends GetxController {
  RxBool isRememberMe = false.obs;

  void check(bool value) {
    isRememberMe.value = value;
  }
}
