import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../data/models/appointment_model.dart';
import '../../../../../../core/controller/appointment_controller.dart';
import '../../../../../../core/controller/pet_controller.dart';

class AppointmentListController extends GetxController {
  final AppointmentController appointmentController;
  final PetController petController;
  AppointmentListController({
    required this.appointmentController,
    required this.petController,
  });

  final searchController = TextEditingController();

  final RxList<Appointment> searchedAppointmentList = <Appointment>[].obs;

  Timer? _appointmentsDebounce;

  void updateSearchedAppointmentList() {
    searchedAppointmentList.value =
        appointmentController.appointmentMap.values.toList();
  }

  void resetSearch() {
    searchController.text = '';
    updateSearchedAppointmentList();
  }

  void onChanged(String value) {
    if (_appointmentsDebounce?.isActive ?? false) {
      _appointmentsDebounce!.cancel();
    }

    _appointmentsDebounce = Timer(const Duration(milliseconds: 500), () {
      searchedAppointmentList.value =
          appointmentController.appointmentMap.values
              .where(
                (appointment) =>
                    ('${appointment.service.text}${appointment.details}${_appendPetNameString(appointment.petIds)}')
                        .toLowerCase()
                        .contains(value.toLowerCase().trim()),
              )
              .toList();
    });
  }

  String _appendPetNameString(List<String> petIds) {
    final petList = petIds.map((petId) => petController.petMap[petId]!);
    String text = '';

    for (var pet in petList) {
      text += pet.petName;
    }
    return text;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
