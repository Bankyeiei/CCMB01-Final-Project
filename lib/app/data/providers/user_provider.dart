import 'package:cloud_firestore/cloud_firestore.dart';

class UserProvider {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uid) {
    return _users.doc(uid).get();
  }

  Future<void> uploadUser(String uid, Map<String, dynamic> jsonMap) async {
    await _users.doc(uid).set(jsonMap, SetOptions(merge: true));
  }
}
