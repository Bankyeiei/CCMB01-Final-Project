import 'package:cloud_firestore/cloud_firestore.dart';

class AppointmentProvider {
  final _appointments = FirebaseFirestore.instance.collection('appointments');

  Future<QuerySnapshot<Map<String, dynamic>>> getAppointments(
    List<String> petIds,
  ) {
    return _appointments.where('pets', arrayContainsAny: petIds).get();
  }

  Future<void> uploadAppointment(
    String? appointmentId,
    Map<String, dynamic> jsonMap,
  ) async {
    await _appointments
        .doc(appointmentId)
        .set(jsonMap, SetOptions(merge: true));
  }

  Future<void> deleteAppointment(String appointmentId) async {
    await _appointments.doc(appointmentId).delete();
  }
}
