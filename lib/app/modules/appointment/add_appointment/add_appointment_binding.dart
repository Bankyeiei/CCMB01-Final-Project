import 'package:get/get.dart';

import 'controller/add_appointment_controller.dart';
import '../controller/appointment_validate_controller.dart';
import '../../../../core/controller/appointment_controller.dart';
import '../../../../core/controller/pet_controller.dart';

class AddAppointmentBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppointmentValidateController>(
      () => AppointmentValidateController(),
    );
    Get.lazyPut<AddAppointmentController>(
      () => AddAppointmentController(
        appointmentValidateController:
            Get.find<AppointmentValidateController>(),
        appointmentController: Get.find<AppointmentController>(),
        petController: Get.find<PetController>()
      ),
    );
  }
}
