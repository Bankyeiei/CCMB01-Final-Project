import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class RegisterValidateController extends GetxController {
  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final RxString emailError = ''.obs;
  final RxString nameError = ''.obs;
  final RxString phoneError = ''.obs;
  final RxString passwordError = ''.obs;
  final RxString confirmPasswordError = ''.obs;

  void validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Please enter your email';
    } else if (!GetUtils.isEmail(value)) {
      emailError.value = 'Invalid email address';
    } else {
      emailError.value = '';
    }
  }

  void validateName(String value) {
    if (value.isEmpty) {
      nameError.value = 'Please enter your name';
    } else if (value.startsWith(' ')) {
      nameError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      nameError.value = 'Please remove spaces at the end';
    } else if (value.length < 2) {
      nameError.value = 'Name must be at least 2 characters';
    } else {
      nameError.value = '';
    }
  }

  void validatePhone(String value) {
    if (value.isEmpty) {
      phoneError.value = 'Please enter your phone';
    } else if (value.length < 9) {
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
    if (passwordError.isEmpty && value != passwordController.text) {
      confirmPasswordError.value = 'Passwords do not match';
    } else {
      confirmPasswordError.value = '';
    }
  }

  bool validateForm() {
    validateEmail(emailController.text);
    validateName(nameController.text);
    validatePhone(phoneController.text);
    validatePassword(passwordController.text);
    validateConfirmPassword(confirmPasswordController.text);
    return emailError.isEmpty &&
        nameError.isEmpty &&
        phoneError.isEmpty &&
        passwordError.isEmpty &&
        confirmPasswordError.isEmpty;
  }

  @override
  void onClose() {
    emailController.dispose();
    nameController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
