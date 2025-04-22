import 'package:get/get.dart';

import '../../app/data/models/appointment_model.dart';
import '../../app/data/repositories/appointment_repository.dart';

class AppointmentController extends GetxController {
  final AppointmentRepository appointmentRepository;
  AppointmentController({required this.appointmentRepository});

  final RxMap<String, Appointment> appointmentMap = <String, Appointment>{}.obs;

  Future<void> getAppointments(List<String> petIds) async {
    appointmentMap.value = await appointmentRepository.getAppointmentModelMap(
      petIds,
    );
  }

  //TODO Edit Appointment

  Future<void> deleteAppointment(String appointmentId) async {
    await appointmentRepository.deleteAppointment(appointmentId);
    appointmentMap.remove(appointmentId);
  }
}
