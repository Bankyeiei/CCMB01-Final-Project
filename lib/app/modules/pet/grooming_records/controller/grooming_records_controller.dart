import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../controller/service_validate_controller.dart';
import '../../../../data/models/grooming_model.dart';
import '../../../../../core/controller/grooming_controller.dart';
import '../../../../../services/snackbar_service.dart';

class GroomingRecordsController extends GetxController
    with GetTickerProviderStateMixin {
  final GroomingController groomingController;
  final ServiceValidateController serviceValidateController;
  GroomingRecordsController({
    required this.groomingController,
    required this.serviceValidateController,
  });

  final Map<String, SlidableController> slidableController = {};

  late Grooming grooming;
  final Rx<DateTime?> serviceDate = Rx<DateTime?>(null);

  SlidableController getSlidableController(String groomingId) {
    slidableController[groomingId] = SlidableController(this);
    return slidableController[groomingId]!;
  }

  void init(Grooming grooming) {
    this.grooming = grooming;
    serviceValidateController.detailsController.text = grooming.details;
    serviceDate.value = grooming.groomedAt;
    serviceValidateController.serviceDate = serviceDate;

    serviceValidateController.detailsError.value = '';
    serviceValidateController.dateError.value = '';
  }

  Future<void> editGrooming() async {
    try {
      await groomingController.groomingRepository.uploadGroomingMap(
        Grooming(
          groomingId: grooming.groomingId,
          details: serviceValidateController.detailsController.text,
          petId: grooming.petId,
          groomedAt: serviceDate.value!,
        ),
      );
      groomingController.update();
      Get.back();
    } catch (error) {
      SnackbarService.showEditError();
    }
  }

  Future<void> deleteGrooming(
    String groomingId,
    SlidableController controller,
  ) async {
    Get.closeCurrentSnackbar();
    Get.defaultDialog(
      title: 'Delete Grooming',
      middleText:
          "Are you sure you want to delete this grooming? This can't be undone.",
      textConfirm: 'Yes, delete',
      textCancel: 'Cancel',
      buttonColor: Get.theme.colorScheme.error,
      cancelTextColor: Get.theme.colorScheme.error,
      onConfirm: () async {
        Get.back();
        try {
          await groomingController.groomingRepository.deleteGrooming(
            groomingId,
          );
          groomingController.update();
        } catch (error) {
          SnackbarService.showDeleteError();
        }
      },
      onCancel: () => controller.close(),
    );
  }
}
