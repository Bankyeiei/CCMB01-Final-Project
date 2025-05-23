import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controller/appointment_validate_controller.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../../core/controller/appointment_controller.dart';
import '../../../../../core/controller/pet_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class AddAppointmentController extends GetxController {
  final AppointmentValidateController appointmentValidateController;
  final AppointmentController appointmentController;
  final PetController petController;
  AddAppointmentController({
    required this.appointmentValidateController,
    required this.appointmentController,
    required this.petController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  Widget get loadingScreen => _loadingController.loadingScreen();

  final Rx<Service> service = Service.vaccination.obs;
  final RxList<Pet> pets = <Pet>[].obs;
  final Rx<DateTime?> serviceDate = Rx<DateTime?>(null);
  final Rx<Time?> serviceTime = Rx<Time?>(null);

  void init() {
    appointmentValidateController.pets = pets;
    appointmentValidateController.serviceDate = serviceDate;
    appointmentValidateController.serviceTime = serviceTime;
  }

  Future<void> addAppointment() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final petIds = pets.map((pet) => pet.petId).toList();

      final dateTime = serviceDate.value!.copyWith(
        hour: serviceTime.value!.hour,
        minute: serviceTime.value!.minute,
      );
      final newAppointment = Appointment(
        appointmentId: '',
        service: service.value,
        details: appointmentValidateController.detailsController.text,
        petIds: petIds,
        appointedAt: dateTime,
      );
      await appointmentController.appointmentRepository.uploadAppointmentMap(
        newAppointment,
      );
      await appointmentController.getAppointments(petController.petIds);
      appointmentController.update();
      Get.back(closeOverlays: true);
      SnackbarService.showAddAppointmentSuccess();
    } catch (error) {
      SnackbarService.showAddAppointmentError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }
}
