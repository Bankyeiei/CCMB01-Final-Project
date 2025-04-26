import 'package:get/get.dart';

import 'controller/grooming_records_controller.dart';
import '../controller/service_validate_controller.dart';
import '../../../../core/controller/grooming_controller.dart';

class GroomingRecordsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ServiceValidateController>(() => ServiceValidateController());
    Get.lazyPut<GroomingRecordsController>(
      () => GroomingRecordsController(
        groomingController: Get.find<GroomingController>(),
        serviceValidateController: Get.find<ServiceValidateController>(),
      ),
    );
  }
}
