import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/pet_model.dart';

class JournalValidateController extends GetxController {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();

  final RxString titleError = ''.obs;
  final RxString detailsError = ''.obs;
  final RxString petError = ''.obs;
  final RxString dateError = ''.obs;

  late final RxList<Pet> pets;
  late final RxList<DateTime?> journalDate;

  Timer? _detailsDebounce;

  void validateTitle(String value) {
    if (value.isEmpty) {
      titleError.value = 'Please enter journal title';
    } else if (value.startsWith(' ')) {
      titleError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      titleError.value = 'Please remove spaces at the end';
    } else {
      titleError.value = '';
    }
  }

  void timerValidateDetails(String value) {
    if (_detailsDebounce?.isActive ?? false) _detailsDebounce!.cancel();

    _detailsDebounce = Timer(
      const Duration(milliseconds: 500),
      () => validateDetails(value),
    );
  }

  void validateDetails(String value) {
    if (value.startsWith(' ')) {
      detailsError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      detailsError.value = 'Please remove spaces at the end';
    } else {
      detailsError.value = '';
    }
  }

  void validatePets(RxList<Pet> pets) {
    if (pets.isEmpty) {
      petError.value = 'Please select your pets';
    } else {
      petError.value = '';
    }
  }

  void validateDate(RxList<DateTime?> date) {
    if (date.isEmpty || date[0] == null) {
      dateError.value = 'Please choose journal date';
    } else {
      dateError.value = '';
    }
  }

  bool validateForm() {
    validateTitle(titleController.text);
    validateDetails(detailsController.text);
    validatePets(pets);
    validateDate(journalDate);
    return titleError.isEmpty &&
        detailsError.isEmpty &&
        petError.isEmpty &&
        dateError.isEmpty;
  }

  @override
  void onClose() {
    titleController.dispose();
    detailsController.dispose();
    super.onClose();
  }
}
