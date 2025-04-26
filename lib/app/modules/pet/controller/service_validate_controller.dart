import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ServiceValidateController extends GetxController {
  final detailsController = TextEditingController();

  final RxString detailsError = ''.obs;
  final RxString dateError = ''.obs;

  late Rx<DateTime?> serviceDate;

  void validateDetails(String value) {
    if (value.startsWith(' ')) {
      detailsError.value = 'Please remove spaces at the beginning';
    } else if (value.endsWith(' ')) {
      detailsError.value = 'Please remove spaces at the end';
    } else {
      detailsError.value = '';
    }
  }

  void validateDate(Rx<DateTime?> date) {
    if (date.value == null) {
      dateError.value = 'Please choose service date';
    } else {
      dateError.value = '';
    }
  }

  bool validateForm() {
    validateDetails(detailsController.text);
    validateDate(serviceDate);
    return detailsError.isEmpty && dateError.isEmpty;
  }

  @override
  void onClose() {
    detailsController.dispose();
    super.onClose();
  }
}
