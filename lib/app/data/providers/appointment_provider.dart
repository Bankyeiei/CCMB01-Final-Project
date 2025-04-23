import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentProvider {
  final _appointments = FirebaseFirestore.instance.collection('appointments');

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments(
    List<String> petIds,
  ) {
    return _appointments
        .where('pet_ids', arrayContainsAny: petIds)
        .orderBy('appointed_at')
        .get();
  }

  Future<void> uploadAppointment(
    String appointmentId,
    Map<String, dynamic> jsonMap,
  ) async {
    await _appointments
        .doc(appointmentId.isEmpty ? null : appointmentId)
        .set(jsonMap, SetOptions(merge: true));
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _appointments.doc(appointmentId).delete();
  }
}
