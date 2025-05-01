import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class EditProfileValidateController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  final RxString nameError = ''.obs;
  final RxString phoneError = ''.obs;

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

  bool validateForm() {
    validateName(nameController.text);
    validatePhone(phoneController.text);
    return nameError.isEmpty && phoneError.isEmpty;
  }

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    super.onClose();
  }
}
