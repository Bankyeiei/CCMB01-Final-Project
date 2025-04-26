import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../../controller/service_validate_controller.dart';
import '../../../../data/models/vaccination_model.dart';
import '../../../../../core/controller/vaccination_controller.dart';
import '../../../../../services/snackbar_service.dart';

class VaccinationsRecordsController extends GetxController
    with GetTickerProviderStateMixin {
  final VaccinationController vaccinationController;
  final ServiceValidateController serviceValidateController;
  VaccinationsRecordsController({
    required this.vaccinationController,
    required this.serviceValidateController,
  });

  final Map<String, SlidableController> slidableController = {};

  late Vaccination vaccination;
  final Rx<DateTime?> serviceDate = Rx<DateTime?>(null);

  SlidableController getSlidableController(String vaccinationId) {
    slidableController[vaccinationId] = SlidableController(this);
    return slidableController[vaccinationId]!;
  }

  void initAdd() {
    serviceValidateController.detailsController.text = '';
    serviceDate.value = null;
    serviceValidateController.serviceDate = serviceDate;
    _resetError();
  }

  void initEdit(Vaccination vaccination) {
    this.vaccination = vaccination;
    serviceValidateController.detailsController.text = vaccination.details;
    serviceDate.value = vaccination.vaccinatedAt;
    serviceValidateController.serviceDate = serviceDate;
    _resetError();
  }

  void _resetError() {
    serviceValidateController.detailsError.value = '';
    serviceValidateController.detailsError.value = '';
  }

  Future<void> addVaccination(String petId) async {
    try {
      await vaccinationController.vaccinationRepository.uploadVaccinationMap(
        Vaccination(
          vaccinationId: '',
          details: serviceValidateController.detailsController.text,
          petId: petId,
          vaccinatedAt: serviceDate.value!,
        ),
      );
      vaccinationController.update();
      Get.back();
    } catch (error) {
      SnackbarService.showEditError();
    }
  }

  Future<void> editVaccination() async {
    try {
      await vaccinationController.vaccinationRepository.uploadVaccinationMap(
        Vaccination(
          vaccinationId: vaccination.vaccinationId,
          details: serviceValidateController.detailsController.text,
          petId: vaccination.petId,
          vaccinatedAt: serviceDate.value!,
        ),
      );
      vaccinationController.update();
      Get.back();
    } catch (error) {
      SnackbarService.showEditError();
    }
  }

  Future<void> deleteVaccination(
    String vaccinationId,
    SlidableController controller,
  ) async {
    Get.closeCurrentSnackbar();
    Get.defaultDialog(
      title: 'Delete Vaccination',
      middleText:
          "Are you sure you want to delete this vaccination? This can't be undone.",
      textConfirm: 'Yes, delete',
      textCancel: 'Cancel',
      buttonColor: Get.theme.colorScheme.error,
      cancelTextColor: Get.theme.colorScheme.error,
      onConfirm: () async {
        Get.back();
        try {
          await vaccinationController.vaccinationRepository.deleteVaccination(
            vaccinationId,
          );
          vaccinationController.update();
        } catch (error) {
          SnackbarService.showDeleteError();
        }
      },
      onCancel: () => controller.close(),
    );
  }
}
