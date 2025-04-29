import 'package:get/get.dart';

import 'controller/home_view_controller.dart';
import 'pages/home/controller/home_controller.dart';
import 'pages/pet_list/controller/pet_list_controller.dart';
import 'pages/appointment_list/controller/appointment_list_controller.dart';
import '../../data/providers/appointment_provider.dart';
import '../../data/providers/journal_provider.dart';
import '../../data/providers/user_provider.dart';
import '../../data/providers/pet_provider.dart';
import '../../data/repositories/appointment_repository.dart';
import '../../data/repositories/journal_repository.dart';
import '../../data/repositories/user_repository.dart';
import '../../data/repositories/pet_repository.dart';
import '../../../core/controller/appointment_controller.dart';
import '../../../core/controller/journal_controller.dart';
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
    Get.lazyPut<AppointmentProvider>(() => AppointmentProvider());
    Get.lazyPut<AppointmentRepository>(
      () => AppointmentRepository(
        appointmentProvider: Get.find<AppointmentProvider>(),
      ),
    );
    Get.lazyPut<AppointmentController>(
      () => AppointmentController(
        appointmentRepository: Get.find<AppointmentRepository>(),
      ),
    );
    Get.lazyPut<JournalProvider>(() => JournalProvider());
    Get.lazyPut<JournalRepository>(
      () => JournalRepository(journalProvider: Get.find<JournalProvider>()),
    );
    Get.lazyPut<JournalController>(
      () => JournalController(journalRepository: Get.find<JournalRepository>()),
    );
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PetListController>(
      () => PetListController(petController: Get.find<PetController>()),
    );
    Get.lazyPut<AppointmentListController>(
      () => AppointmentListController(
        appointmentController: Get.find<AppointmentController>(),
        petController: Get.find<PetController>(),
      ),
    );
    Get.lazyPut<HomeViewController>(
      () => HomeViewController(
        userController: Get.find<UserController>(),
        petController: Get.find<PetController>(),
        appointmentController: Get.find<AppointmentController>(),
      ),
    );
  }
}
