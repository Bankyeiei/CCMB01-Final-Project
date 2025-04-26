import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginValidateController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final RxString emailError = ''.obs;
  final RxString passwordError = ''.obs;

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Invalid email format';
    } else {
      emailError.value = '';
    }
  }

  void validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Please enter your password';
    } else if (value.length < 8) {
      passwordError.value = 'Password must be at least 8 characters';
    } else {
      passwordError.value = '';
    }
  }

  bool validateForm() {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    return emailError.isEmpty && passwordError.isEmpty;
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
