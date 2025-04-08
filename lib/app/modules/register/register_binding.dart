import 'package:get/get.dart';

import 'controller/register_controller.dart';
import 'controller/register_page_controller.dart';
import '../../data/providers/image_provider.dart';
import '../../data/providers/register_provider.dart';
import '../../data/repositories/image_repository.dart';
import '../../data/repositories/register_repository.dart';
import '../../../core/controller/image_controller.dart';
import '../../../core/controller/loading_controller.dart';

class RegisterBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterPageController>(() => RegisterPageController());
    Get.lazyPut<ImageProvider>(() => ImageProvider());
    Get.lazyPut<ImageRepository>(
      () => ImageRepository(imageProvider: Get.find<ImageProvider>()),
    );
    Get.lazyPut<ImageController>(
      () => ImageController(imageRepository: Get.find<ImageRepository>()),
    );
    Get.lazyPut<RegisterProvider>(() => RegisterProvider());
    Get.lazyPut<RegisterRepository>(
      () => RegisterRepository(registerProvider: Get.find<RegisterProvider>()),
    );
    Get.lazyPut<RegisterController>(
      () => RegisterController(
        registerRepository: Get.find<RegisterRepository>(),
        registerPageController: Get.find<RegisterPageController>(),
        imageController: Get.find<ImageController>(),
        loadingController: Get.find<LoadingController>(),
      ),
    );
  }
}
