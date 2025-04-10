import 'package:coco/core/controller/user_controller.dart';
import 'package:get/get.dart';

import 'controller/edit_profile_controller.dart';
import 'controller/edit_profile_validate_controller.dart';
import '../../data/providers/image_provider.dart';
import '../../data/repositories/image_repository.dart';
import '../../../core/controller/image_controller.dart';

class EditProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EditProfileValidateController>(
      () => EditProfileValidateController(),
    );
    Get.lazyPut<ImageProvider>(() => ImageProvider());
    Get.lazyPut<ImageRepository>(
      () => ImageRepository(imageProvider: Get.find<ImageProvider>()),
    );
    Get.lazyPut<ImageController>(
      () => ImageController(imageRepository: Get.find<ImageRepository>()),
    );
    Get.lazyPut<EditProfileController>(
      () => EditProfileController(
        editProfileValidateController:
            Get.find<EditProfileValidateController>(),
        userController: Get.find<UserController>(),
        imageController: Get.find<ImageController>(),
      ),
    );
  }
}
