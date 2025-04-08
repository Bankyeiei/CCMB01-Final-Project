import '../providers/register_provider.dart';

class RegisterRepository {
  final RegisterProvider registerProvider;
  RegisterRepository({required this.registerProvider});

  Future<void> uploadUser(
    String uid,
    String email,
    String username,
    String phone,
    String? imageUrl,
  ) async {
    final jsonMap = {'email': email, 'username': username, 'phone': phone};
    if (imageUrl != null) {
      jsonMap['imageUrl'] = imageUrl;
    }
    registerProvider.uploadUser(uid, jsonMap);
  }
}
