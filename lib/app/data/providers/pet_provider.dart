import 'package:cloud_firestore/cloud_firestore.dart';

class PetProvider {
  final _pets = FirebaseFirestore.instance.collection('pets');

  Future<QuerySnapshot<Map<String, dynamic>>> getPets(String uid) {
    return _pets.where('owner_id', isEqualTo: uid).orderBy('pet_name').get();
  }

  Future<void> uploadPet(String? petId, Map<String, dynamic> jsonMap) async {
    await _pets.doc(petId).set(jsonMap, SetOptions(merge: true));
  }

  Future<void> deletePet(String petId) async {
    await _pets.doc(petId).delete();
  }
}
