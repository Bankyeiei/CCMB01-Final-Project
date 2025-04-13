import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class AddPetValidateController extends GetxController {
  final petNameController = TextEditingController();
  final breedNameController = TextEditingController();
  final weightController = TextEditingController();
  final colorController = TextEditingController();
  final storyController = TextEditingController();

  final RxString petNameError = ''.obs;
  final RxString breedNameError = ''.obs;
  final RxString weightError = ''.obs;
  final RxString colorError = ''.obs;
  final RxString storyError = ''.obs;

  void validatePetName(String value) {
    if (value.isEmpty) {
      petNameError.value = 'Please enter your pet\'s name';
    } else if (value.startsWith(' ')) {
      petNameError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      petNameError.value = 'Please remove spaces at the end';
    } else if (value.length < 2) {
      petNameError.value = 'Pet name must be at least 2 characters';
    } else {
      petNameError.value = '';
    }
  }

  void validateBreedName(String value) {
    if (value.startsWith(' ')) {
      breedNameError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      breedNameError.value = 'Please remove spaces at the end';
    } else {
      breedNameError.value = '';
    }
  }

  void validateWeight(String value) {
    if (value.isEmpty) {
      weightError.value = '';
    } else if (double.tryParse(value) == null) {
      weightError.value = 'Weight must be a number';
    } else {
      weightError.value = '';
    }
  }

  void validateColor(String value) {
    if (value.startsWith(' ')) {
      colorError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      colorError.value = 'Please remove spaces at the end';
    } else {
      colorError.value = '';
    }
  }

  void validateStory(String value) {
    if (value.startsWith(' ')) {
      storyError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      storyError.value = 'Please remove spaces at the end';
    } else {
      storyError.value = '';
    }
  }

  bool validateForm() {
    validatePetName(petNameController.text);
    validateBreedName(breedNameController.text);
    validateWeight(weightController.text);
    validateColor(colorController.text);
    validateStory(storyController.text);

    return petNameError.value.isEmpty &&
        breedNameError.value.isEmpty &&
        weightError.value.isEmpty &&
        colorError.value.isEmpty &&
        storyError.value.isEmpty;
  }

  @override
  void onClose() {
    petNameController.dispose();
    breedNameController.dispose();
    weightController.dispose();
    colorController.dispose();
    storyController.dispose();
    super.onClose();
  }
}
