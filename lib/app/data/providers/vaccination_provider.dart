import 'package:cloud_firestore/cloud_firestore.dart';

class VaccinationProvider {
  final _vaccination = FirebaseFirestore.instance.collection('vaccinations');

  Future<QuerySnapshot<Map<String, dynamic>>> getVaccinations(String petId) {
    return _vaccination
        .where('pet_id', isEqualTo: petId)
        .orderBy('vaccinated_at', descending: true)
        .get();
  }

  Future<void> uploadVaccination(
    String vaccinationId,
    Map<String, dynamic> jsonMap,
  ) async {
    await _vaccination
        .doc(vaccinationId.isEmpty ? null : vaccinationId)
        .set(jsonMap, SetOptions(merge: true));
  }

  Future<void> deleteVaccination(String vaccinationId) async {
    await _vaccination.doc(vaccinationId).delete();
  }
}
