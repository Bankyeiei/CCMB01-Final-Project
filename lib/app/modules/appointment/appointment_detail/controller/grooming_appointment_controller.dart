import 'package:get/get.dart';

import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/grooming_model.dart';
import '../../../../../core/controller/appointment_controller.dart';
import '../../../../../core/controller/grooming_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class GroomingAppointmentController extends GetxController {
  final GroomingController groomingController;
  final AppointmentController appointmentController;
  GroomingAppointmentController({
    required this.groomingController,
    required this.appointmentController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  Future<void> markAsCompleted(Appointment appointment) async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      for (var petId in appointment.petIds) {
        final newGrooming = Grooming(
          groomingId: '',
          details: appointment.details,
          petId: petId,
          groomedAt: appointment.appointedAt.copyWith(hour: 0, minute: 0),
        );
        await groomingController.groomingRepository.uploadGroomingMap(
          newGrooming,
        );
      }
      await appointmentController.deleteAppointment(appointment.appointmentId);
      groomingController.update();
      Get.back(closeOverlays: true);
      SnackbarService.showMarkAppointmentSuccess();
    } catch (error) {
      SnackbarService.showMarkAppointmentError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }
}
