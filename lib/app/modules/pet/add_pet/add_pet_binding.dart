import 'package:get/get.dart';

import 'controller/add_pet_controller.dart';
import '../controller/pet_validate_controller.dart';
import '../../../data/providers/image_provider.dart';
import '../../../data/repositories/image_repository.dart';
import '../../../../core/controller/pet_controller.dart';
import '../../../../core/controller/image_controller.dart';

class AddPetBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PetValidateController>(() => PetValidateController());
    Get.lazyPut<ImageProvider>(() => ImageProvider());
    Get.lazyPut<ImageRepository>(
      () => ImageRepository(imageProvider: Get.find<ImageProvider>()),
    );
    Get.lazyPut<ImageController>(
      () => ImageController(imageRepository: Get.find<ImageRepository>()),
    );
    Get.lazyPut<AddPetController>(
      () => AddPetController(
        petValidateController: Get.find<PetValidateController>(),
        petController: Get.find<PetController>(),
        imageController: Get.find<ImageController>(),
      ),
    );
  }
}
