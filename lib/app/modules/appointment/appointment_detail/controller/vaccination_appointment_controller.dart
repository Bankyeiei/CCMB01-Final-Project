import 'package:get/get.dart';

import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/vaccination_model.dart';
import '../../../../../core/controller/appointment_controller.dart';
import '../../../../../core/controller/vaccination_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class VaccinationAppointmentController extends GetxController {
  final VaccinationController vaccinationController;
  final AppointmentController appointmentController;
  VaccinationAppointmentController({
    required this.vaccinationController,
    required this.appointmentController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  Future<void> markAsCompleted(Appointment appointment) async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      for (var petId in appointment.petIds) {
        final newVaccination = Vaccination(
          vaccinationId: '',
          details: appointment.details,
          petId: petId,
          vaccinatedAt: appointment.appointedAt.copyWith(hour: 0, minute: 0),
        );
        await vaccinationController.vaccinationRepository.uploadVaccinationMap(
          newVaccination,
        );
      }
      await appointmentController.deleteAppointment(appointment.appointmentId);
      appointmentController.update();
      vaccinationController.update();
      Get.back(closeOverlays: true);
      SnackbarService.showMarkAppointmentSuccess();
    } catch (error) {
      SnackbarService.showMarkAppointmentError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }
}
