import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  RxString emailError = ''.obs;
  RxString passwordError = ''.obs;

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
    } else if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
    } else {
      passwordError.value = '';
    }
  }

  bool validateForm() {
    validateEmail(emailController.text);
    validatePassword(passwordController.text);
    return emailError.value == '' && passwordError.value == '';
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
