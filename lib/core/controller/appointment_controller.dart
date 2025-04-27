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

  Future<void> editAppointment(
    String appointmentId,
    Service service,
    String details,
    List<String> petIds,
    DateTime appointedAt,
  ) async {
    final editedAppointment = Appointment(
      appointmentId: appointmentId,
      service: service,
      details: details,
      petIds: petIds,
      appointedAt: appointedAt,
    );
    await appointmentRepository.uploadAppointmentMap(editedAppointment);
    appointmentMap.update(appointmentId, (value) => editedAppointment);
    final sortedEntries =
        appointmentMap.entries.toList()
          ..sort((a, b) => a.value.appointedAt.compareTo(b.value.appointedAt));
    appointmentMap.assignAll(Map.fromEntries(sortedEntries));
  }

  Future<void> deletePetFromAppointments(String petId) async {
    final entries = appointmentMap.entries.toList();

    for (var entry in entries) {
      final appointment = entry.value;
      final id = entry.key;

      if (appointment.petIds.remove(petId)) {
        if (appointment.petIds.isEmpty) {
          await deleteAppointment(id);
        } else {
          await appointmentRepository.uploadAppointmentMap(appointment);
        }
      }
    }
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await appointmentRepository.deleteAppointment(appointmentId);
    appointmentMap.remove(appointmentId);
  }
}
