import 'package:get/get.dart';

import '../../app/data/models/user_model.dart';
import '../../app/data/repositories/user_repository.dart';

class UserController extends GetxController {
  final UserRepositories userRepositories;
  UserController({required this.userRepositories});

  Rx<User> userRx = User().obs;

  User get user => userRx.value;

  Future<void> getUser(String uid) async {
    userRx = (await userRepositories.getUserModel(uid)).obs;
  }

  Future<void> editUser(
    String uid,
    String name,
    String phone,
    String? imageUrl,
    String? imageId,
  ) async {
    userRx.update((val) {
      if (val != null) {
        val.name = name;
        val.phone = phone;
        val.imageUrl = imageUrl ?? '';
        val.imageId = imageId ?? '';
      }
    });
    await userRepositories.uploadEditedUserMap(
      uid,
      name,
      phone,
      imageUrl ?? '',
      imageId ?? '',
    );
  }
}
