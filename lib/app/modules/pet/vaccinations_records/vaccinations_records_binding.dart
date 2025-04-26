import 'package:get/get.dart';

import 'controller/vaccinations_records_controller.dart';
import '../controller/service_validate_controller.dart';
import '../../../../core/controller/vaccination_controller.dart';

class VaccinationsRecordsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceValidateController>(() => ServiceValidateController());
    Get.lazyPut<VaccinationsRecordsController>(
      () => VaccinationsRecordsController(
        vaccinationController: Get.find<VaccinationController>(),
        serviceValidateController: Get.find<ServiceValidateController>(),
      ),
    );
  }
}
