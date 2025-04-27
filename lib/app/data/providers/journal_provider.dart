import 'package:cloud_firestore/cloud_firestore.dart';

class JournalProvider {
  final _journals = FirebaseFirestore.instance.collection('journals');

  Future<DocumentSnapshot<Map<String, dynamic>>> getJournalById(
    String journalId,
  ) {
    return _journals.doc(journalId).get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getJournalsByPet(String petId) {
    return _journals
        .where('pet_ids', arrayContains: petId)
        .orderBy('first_date', descending: true)
        .get();
  }

  Future<QuerySnapshot<Map<String, dynamic>>> getJournalsByPets(
    List<String> petIds,
  ) {
    return _journals
        .where('pet_ids', arrayContainsAny: petIds)
        .orderBy('first_date', descending: true)
        .get();
  }

  Future<void> uploadJournal(
    String journalId,
    Map<String, dynamic> jsonMap,
  ) async {
    await _journals
        .doc(journalId.isEmpty ? null : journalId)
        .set(jsonMap, SetOptions(merge: true));
  }

  Future<void> deleteJournal(String journalId) async {
    await _journals.doc(journalId).delete();
  }
}
