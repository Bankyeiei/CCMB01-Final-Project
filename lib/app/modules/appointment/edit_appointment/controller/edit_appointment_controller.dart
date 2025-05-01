import 'package:day_night_time_picker/lib/state/time.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

import '../../controller/appointment_validate_controller.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../../core/controller/appointment_controller.dart';
import '../../../../../core/controller/pet_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class EditAppointmentController extends GetxController {
  final AppointmentValidateController appointmentValidateController;
  final AppointmentController appointmentController;
  final PetController petController;
  EditAppointmentController({
    required this.appointmentValidateController,
    required this.appointmentController,
    required this.petController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  Widget get loadingScreen => _loadingController.loadingScreen();

  late final Appointment appointment;
  late final Service service;
  final RxList<Pet> pets = <Pet>[].obs;
  final Rx<DateTime?> serviceDate = Rx<DateTime?>(null);
  final Rx<Time?> serviceTime = Rx<Time?>(null);

  void init(Appointment appointment) {
    this.appointment = appointment;
    service = appointment.service;
    appointmentValidateController.detailsController.text = appointment.details;
    pets.value =
        appointment.petIds
            .map((petId) => petController.petMap[petId]!)
            .toList();
    appointmentValidateController.pets = pets;

    final dateTime = appointment.appointedAt;
    serviceDate.value = DateTime(dateTime.year, dateTime.month, dateTime.day);
    appointmentValidateController.serviceDate = serviceDate;
    serviceTime.value = Time(hour: dateTime.hour, minute: dateTime.minute);
    appointmentValidateController.serviceTime = serviceTime;
  }

  Future<void> editAppointment() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final petIds = pets.map((pet) => pet.petId).toList();
      final appointedAt = DateTime(
        serviceDate.value!.year,
        serviceDate.value!.month,
        serviceDate.value!.day,
        serviceTime.value!.hour,
        serviceTime.value!.minute,
      );
      await appointmentController.editAppointment(
        appointment.appointmentId,
        service,
        appointmentValidateController.detailsController.text,
        petIds,
        appointedAt,
      );
      appointmentController.update();
      Get.back(closeOverlays: true);
      SnackbarService.showEditSuccess();
    } catch (error) {
      SnackbarService.showEditError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }

  Future<void> deleteAppointment() async {
    Get.closeCurrentSnackbar();
    Get.defaultDialog(
      title: 'Delete Appointment',
      middleText:
          "Are you sure you want to delete this appointment? This can't be undone.",
      textConfirm: 'Yes, delete',
      textCancel: 'Cancel',
      buttonColor: Get.theme.colorScheme.error,
      cancelTextColor: Get.theme.colorScheme.error,
      onConfirm: () async {
        Get.back();
        _loadingController.isLoading.value = true;
        try {
          await appointmentController.deleteAppointment(
            appointment.appointmentId,
          );
          appointmentController.update();
          Get.until(
            (route) =>
                Get.currentRoute == Routes.petProfile ||
                Get.currentRoute == Routes.home,
          );
          SnackbarService.showDeleteSuccess('Appointment');
        } catch (error) {
          SnackbarService.showDeleteError();
        } finally {
          _loadingController.isLoading.value = false;
        }
      },
    );
  }
}
