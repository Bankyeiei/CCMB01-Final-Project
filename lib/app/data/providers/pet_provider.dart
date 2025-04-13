import 'package:cloud_firestore/cloud_firestore.dart';

class PetProvider {
  final _pets = FirebaseFirestore.instance.collection('pets');

  Future<QuerySnapshot<Map<String, dynamic>>> getPet(String uid) {
    return _pets.where('owner_id', isEqualTo: uid).get();
  }

  Future<void> uploadPet(String? petId, Map<String, dynamic> jsonMap) async {
    await _pets.doc(petId).set(jsonMap, SetOptions(merge: true));
  }
}
