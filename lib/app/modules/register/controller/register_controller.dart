import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  RxString emailError = ''.obs;
  RxString usernameError = ''.obs;
  RxString phoneError = ''.obs;
  RxString passwordError = ''.obs;
  RxString confirmPasswordError = ''.obs;

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Invalid email address';
    } else {
      emailError.value = '';
    }
  }

  void validateUsername(String value) {
    if (value.isEmpty) {
      usernameError.value = 'Please enter your username';
    } else if (value.length < 6) {
      usernameError.value = 'Username must be at least 6 characters';
    } else {
      usernameError.value = '';
    }
  }

  void validatePhone(String value) {
    if (value.isEmpty) {
      phoneError.value = 'Please enter your phone';
    } else if (value.length != 12) {
      phoneError.value = 'Invalid phone number';
    } else {
      phoneError.value = '';
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
    validateConfirmPassword(confirmPasswordController.text);
  }

  void validateConfirmPassword(String value) {
    if (passwordError.value.isEmpty && value != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = '';
    }
  }

  bool validateForm() {
    validateEmail(emailController.text);
    validateUsername(usernameController.text);
    validatePhone(phoneController.text);
    validatePassword(passwordController.text);
    validateConfirmPassword(confirmPasswordController.text);
    return emailController.text.isEmpty &&
        usernameController.text.isEmpty &&
        phoneController.text.isEmpty &&
        passwordController.text.isEmpty &&
        confirmPasswordController.text.isEmpty;
  }

  @override
  void onClose() {
    emailController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
