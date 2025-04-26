import 'package:cloud_firestore/cloud_firestore.dart';

class GroomingProvider {
  final _grooming = FirebaseFirestore.instance.collection('grooming');

  Future<QuerySnapshot<Map<String, dynamic>>> getGrooming(String petId) {
    return _grooming
        .where('pet_id', isEqualTo: petId)
        .orderBy('groomed_at', descending: true)
        .get();
  }

  Future<void> uploadGrooming(
    String groomingId,
    Map<String, dynamic> jsonMap,
  ) async {
    await _grooming
        .doc(groomingId.isEmpty ? null : groomingId)
        .set(jsonMap, SetOptions(merge: true));
  }

  Future<void> deleteGrooming(String groomingId) async {
    await _grooming.doc(groomingId).delete();
  }
}
