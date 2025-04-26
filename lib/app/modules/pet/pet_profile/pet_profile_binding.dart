import 'package:get/get.dart';

import '../../../data/providers/grooming_provider.dart';
import '../../../data/providers/vaccination_provider.dart';
import '../../../data/repositories/grooming_repository.dart';
import '../../../data/repositories/vaccination_repository.dart';
import '../../../../core/controller/grooming_controller.dart';
import '../../../../core/controller/vaccination_controller.dart';

class PetProfileBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GroomingProvider>(() => GroomingProvider());
    Get.lazyPut<GroomingRepository>(
      () => GroomingRepository(groomingProvider: Get.find<GroomingProvider>()),
    );
    Get.lazyPut<GroomingController>(
      () => GroomingController(
        groomingRepository: Get.find<GroomingRepository>(),
      ),
    );
    Get.lazyPut<VaccinationProvider>(() => VaccinationProvider());
    Get.lazyPut<VaccinationRepository>(
      () => VaccinationRepository(
        vaccinationProvider: Get.find<VaccinationProvider>(),
      ),
    );
    Get.lazyPut<VaccinationController>(
      () => VaccinationController(
        vaccinationRepository: Get.find<VaccinationRepository>(),
      ),
    );
  }
}
