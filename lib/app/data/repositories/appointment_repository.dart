import '../models/appointment_model.dart';
import '../providers/appointment_provider.dart';

class AppointmentRepository {
  final AppointmentProvider appointmentProvider;
  AppointmentRepository({required this.appointmentProvider});

  Future<Map<String, Appointment>> getAppointmentModelMap(
    List<String> petIds,
  ) async {
    final appointmentData = await appointmentProvider.getAppointments(petIds);
    final appointmentQuery = appointmentData.docs;
    return {
      for (var appointment in appointmentQuery)
        appointment.id: Appointment.fromJson(
          appointment.id,
          appointment.data(),
        ),
    };
  }

  Future<void> uploadAppointmentMap(Appointment appointment) async {
    final appointmentMap = Appointment.toJson(appointment);
    await appointmentProvider.uploadAppointment(
      appointment.appointmentId,
      appointmentMap,
    );
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await appointmentProvider.deleteAppointment(appointmentId);
  }
}
