import 'package:get/get.dart';

import 'controller/home_view_controller.dart';
import '../../data/providers/user_provider.dart';
import '../../data/providers/pet_provider.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/pet_repository.dart';
import '../../../core/controller/user_controller.dart';
import '../../../core/controller/pet_controller.dart';

class HomeViewBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserProvider>(() => UserProvider());
    Get.lazyPut<UserRepositories>(
      () => UserRepositories(userProvider: Get.find<UserProvider>()),
    );
    Get.lazyPut<UserController>(
      () => UserController(userRepositories: Get.find<UserRepositories>()),
    );
    Get.lazyPut<PetProvider>(() => PetProvider());
    Get.lazyPut<PetRepository>(
      () => PetRepository(petProvider: Get.find<PetProvider>()),
    );
    Get.lazyPut<PetController>(
      () => PetController(petRepository: Get.find<PetRepository>()),
    );
    Get.lazyPut<HomeViewController>(
      () => HomeViewController(
        userController: Get.find<UserController>(),
        petController: Get.find<PetController>(),
      ),
    );
  }
}
