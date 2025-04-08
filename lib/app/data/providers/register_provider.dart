import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterProvider {
  final _users = FirebaseFirestore.instance.collection('users');

  Future<void> uploadUser(String uid, Map<String, dynamic> jsonMap) async {
    await _users.doc(uid).set(jsonMap);
  }
}
