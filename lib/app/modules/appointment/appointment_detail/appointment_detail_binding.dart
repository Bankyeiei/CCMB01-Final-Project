import 'package:get/get.dart';

import 'controller/grooming_appointment_controller.dart';
import 'controller/vaccination_appointment_controller.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/providers/grooming_provider.dart';
import '../../../data/providers/vaccination_provider.dart';
import '../../../data/repositories/grooming_repository.dart';
import '../../../data/repositories/vaccination_repository.dart';
import '../../../../core/controller/appointment_controller.dart';
import '../../../../core/controller/grooming_controller.dart';
import '../../../../core/controller/vaccination_controller.dart';

class AppointmentDetailBinding implements Bindings {
  @override
  void dependencies() {
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();
    final appointmentId = Get.arguments as String;
    final appointment = appointmentController.appointmentMap[appointmentId];
    if (appointment == null) {
      return;
    }

    switch (appointment.service) {
      case Service.grooming:
        Get.lazyPut<GroomingProvider>(() => GroomingProvider());
        Get.lazyPut<GroomingRepository>(
          () => GroomingRepository(
            groomingProvider: Get.find<GroomingProvider>(),
          ),
        );
        Get.lazyPut<GroomingController>(
          () => GroomingController(
            groomingRepository: Get.find<GroomingRepository>(),
          ),
        );
        Get.lazyPut<GroomingAppointmentController>(
          () => GroomingAppointmentController(
            groomingController: Get.find<GroomingController>(),
            appointmentController: Get.find<AppointmentController>(),
          ),
        );
        break;
      case Service.vaccination:
        Get.lazyPut<VaccinationProvider>(() => VaccinationProvider());
        Get.lazyPut<VaccinationRepository>(
          () => VaccinationRepository(
            vaccinationProvider: Get.find<VaccinationProvider>(),
          ),
        );
        Get.lazyPut<VaccinationController>(
          () => VaccinationController(
            vaccinationRepository: Get.find<VaccinationRepository>(),
          ),
        );
        Get.lazyPut<VaccinationAppointmentController>(
          () => VaccinationAppointmentController(
            vaccinationController: Get.find<VaccinationController>(),
            appointmentController: Get.find<AppointmentController>(),
          ),
        );
        break;
    }
  }
}
