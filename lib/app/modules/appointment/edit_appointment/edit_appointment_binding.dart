import 'package:get/get.dart';

import 'controller/edit_appointment_controller.dart';
import '../controller/appointment_validate_controller.dart';
import '../../../../core/controller/appointment_controller.dart';
import '../../../../core/controller/pet_controller.dart';

class EditAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentValidateController>(
      () => AppointmentValidateController(),
    );
    Get.lazyPut(
      () => EditAppointmentController(
        appointmentValidateController:
            Get.find<AppointmentValidateController>(),
        appointmentController: Get.find<AppointmentController>(),
        petController: Get.find<PetController>(),
      ),
    );
  }
}
