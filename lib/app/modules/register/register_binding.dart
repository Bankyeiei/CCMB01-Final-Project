import 'package:get/get.dart';

import 'controller/register_controller.dart';
import 'controller/register_validate_controller.dart';
import '../../data/providers/image_provider.dart';
import '../../data/providers/user_provider.dart';
import '../../data/repositories/image_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../../core/controller/image_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterValidateController>(() => RegisterValidateController());
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepositories>(
      () => UserRepositories(userProvider: Get.find<UserProvider>()),
    );
    Get.lazyPut<ImageProvider>(() => ImageProvider());
    Get.lazyPut<ImageRepository>(
      () => ImageRepository(imageProvider: Get.find<ImageProvider>()),
    );
    Get.lazyPut<ImageController>(
      () => ImageController(imageRepository: Get.find<ImageRepository>()),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        registerValidateController: Get.find<RegisterValidateController>(),
        userRepositories: Get.find<UserRepositories>(),
        imageController: Get.find<ImageController>(),
      ),
    );
  }
}
