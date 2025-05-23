import 'dart:async';

import 'package:day_night_time_picker/day_night_time_picker.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../data/models/pet_model.dart';

class AppointmentValidateController extends GetxController {
  final detailsController = TextEditingController();

  final RxString detailsError = ''.obs;
  final RxString petError = ''.obs;
  final RxString dateError = ''.obs;
  final RxString timeError = ''.obs;

  late final RxList<Pet> pets;
  late final Rx<DateTime?> serviceDate;
  late final Rx<Time?> serviceTime;

  Timer? _detailsDebounce;

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

  void validateDate(Rx<DateTime?> date) {
    if (date.value == null) {
      dateError.value = 'Please choose service date';
    } else {
      dateError.value = '';
    }
  }

  void validateTime(Rx<Time?> time) {
    if (time.value == null) {
      timeError.value = 'Please pick service time';
    } else {
      timeError.value = '';
    }
  }

  bool validateForm() {
    validateDetails(detailsController.text);
    validatePets(pets);
    validateDate(serviceDate);
    validateTime(serviceTime);
    return detailsError.isEmpty &&
        petError.isEmpty &&
        dateError.isEmpty &&
        timeError.isEmpty;
  }

  @override
  void onClose() {
    detailsController.dispose();
    super.onClose();
  }
}
