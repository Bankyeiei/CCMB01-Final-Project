import '../models/user_model.dart';
import '../providers/user_provider.dart';

class UserRepositories {
  final UserProvider userProvider;
  UserRepositories({required this.userProvider});

  Future<User> getUserModel(String uid) async {
    final userData = await userProvider.getUser(uid);
    final userMap = userData.data()!;
    return User.fromJson(userMap);
  }

  Future<void> uploadUserMap(String uid, User user) async {
    final userMap = User.toJson(user);
    await userProvider.uploadUser(uid, userMap);
  }

  Future<void> uploadEditedUserMap(
    String uid,
    String name,
    String phone,
    String imageUrl,
    String imageId,
  ) async {
    final userMap = {
      'name': name,
      'phone': phone,
      'image_url': imageUrl,
      'image_id': imageId,
    };
    await userProvider.uploadUser(uid, userMap);
  }
}
