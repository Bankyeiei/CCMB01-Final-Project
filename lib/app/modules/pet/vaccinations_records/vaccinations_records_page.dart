import 'package:apptomate_custom_list_tile/apptomate_custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller/vaccinations_records_controller.dart';
import '../controller/service_validate_controller.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/models/vaccination_model.dart';
import '../../../../core/controller/pet_controller.dart';
import '../../../../core/controller/vaccination_controller.dart';

import '../widgets/pet_info_header.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/text_field.dart';

class VaccinationsRecordsPage extends StatelessWidget {
  final String petId;
  const VaccinationsRecordsPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final VaccinationsRecordsController vaccinationsRecordsController =
        Get.find<VaccinationsRecordsController>();
    final VaccinationController vaccinationController =
        Get.find<VaccinationController>();
    final ServiceValidateController serviceValidateController =
        Get.find<ServiceValidateController>();
    final PetController petController = Get.find<PetController>();

    final pet = petController.petMap[petId]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vaccinations Records'),
        actions: [
          IconButton(
            onPressed:
                () => _showAddBottomSheet(
                  vaccinationsRecordsController,
                  serviceValidateController,
                ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: PetInfoHeader(pet: pet),
          ),
          SliverFillRemaining(
            child: GetBuilder(
              init: vaccinationController,
              builder:
                  (controller) => FutureBuilder(
                    future: controller.getVaccinationsByPet(petId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Align(
                          alignment: Alignment(0, -0.2),
                          child: CircularProgressIndicator(
                            strokeWidth: 8,
                            strokeAlign: 4,
                          ),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Align(
                          alignment: const Alignment(0, -0.2),
                          child: Text(
                            'Unable to load vaccination data.',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              letterSpacing: 0.6,
                            ),
                          ),
                        );
                      }

                      final vaccinationList = snapshot.data!;
                      if (vaccinationList.isEmpty) {
                        return Align(
                          alignment: const Alignment(0, -0.2),
                          child: Text(
                            'No vaccination records yet.',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              letterSpacing: 0.6,
                            ),
                          ),
                        );
                      }

                      return SlidableAutoCloseBehavior(
                        child: ListView.builder(
                          itemCount: vaccinationList.length,
                          itemBuilder: (context, index) {
                            final vaccination = vaccinationList[index];
                            final controller = vaccinationsRecordsController
                                .getSlidableController(
                                  vaccination.vaccinationId,
                                );

                            return Slidable(
                              controller: controller,
                              startActionPane: ActionPane(
                                motion: const BehindMotion(),
                                extentRatio: 0.24,
                                children: [
                                  SlidableAction(
                                    icon: Icons.delete,
                                    label: 'Delete',
                                    autoClose: false,
                                    foregroundColor:
                                        Get.theme.colorScheme.onPrimary,
                                    backgroundColor:
                                        Get.theme.colorScheme.error,
                                    onPressed:
                                        (context) =>
                                            vaccinationsRecordsController
                                                .deleteVaccination(
                                                  vaccination.vaccinationId,
                                                  controller,
                                                ),
                                  ),
                                ],
                              ),
                              endActionPane: ActionPane(
                                motion: const BehindMotion(),
                                extentRatio: 0.24,
                                children: [
                                  SlidableAction(
                                    icon: Icons.edit,
                                    label: 'Edit',
                                    autoClose: false,
                                    foregroundColor:
                                        Get.theme.colorScheme.onPrimary,
                                    backgroundColor: Get.theme.primaryColor,
                                    onPressed:
                                        (context) => _showEditBottomSheet(
                                          vaccination,
                                          vaccinationsRecordsController,
                                          serviceValidateController,
                                          controller,
                                        ),
                                  ),
                                ],
                              ),
                              child: CustomListTile(
                                dense: true,
                                elevation: 0,
                                borderRadius: 0,
                                shadowColor: Colors.white,
                                backgroundColor:
                                    index.isEven
                                        ? Get.theme.colorScheme.secondary
                                            .withAlpha(127)
                                        : Get.theme.colorScheme.onPrimary,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                title: DateFormat.yMMMMEEEEd().format(
                                  vaccination.vaccinatedAt,
                                ),
                                titleStyle: Get.textTheme.titleMedium,
                                subtitle:
                                    vaccination.details.isNotEmpty
                                        ? vaccination.details
                                        : 'No vaccination details',
                                subtitleStyle: Get.textTheme.bodySmall,
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddBottomSheet(
    VaccinationsRecordsController vaccinationsRecordsController,
    ServiceValidateController serviceValidateController,
  ) {
    vaccinationsRecordsController.initAdd();
    Get.closeCurrentSnackbar();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              AppDatePicker(
                dateValue: vaccinationsRecordsController.serviceDate,
                label: 'Service Date',
                lastDate: DateTime.now(),
                dateFormat: DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                errorText: serviceValidateController.dateError,
              ),
              const SizedBox(height: 8),
              Obx(
                () => AppTextField(
                  icon: Service.vaccination.icon,
                  hintText: 'Vaccination details',
                  errorText: serviceValidateController.detailsError.value,
                  controller: serviceValidateController.detailsController,
                  validate: serviceValidateController.validateDetails,
                  isHintText: false,
                  lengthLimiting: 40,
                  isShowLength: true,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Get.back(),
                    child: Text(
                      'Cancel',
                      style: Get.textTheme.titleLarge!.copyWith(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (serviceValidateController.validateForm()) {
                        vaccinationsRecordsController.addVaccination(petId);
                      }
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEditBottomSheet(
    Vaccination vaccination,
    VaccinationsRecordsController vaccinationsRecordsController,
    ServiceValidateController serviceValidateController,
    SlidableController controller,
  ) {
    vaccinationsRecordsController.initEdit(vaccination);
    Get.closeCurrentSnackbar();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 16),
              AppDatePicker(
                dateValue: vaccinationsRecordsController.serviceDate,
                label: 'Service Date',
                lastDate: DateTime.now(),
                dateFormat: DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                errorText: serviceValidateController.dateError,
              ),
              const SizedBox(height: 8),
              Obx(
                () => AppTextField(
                  icon: Service.vaccination.icon,
                  hintText: 'Vaccination details',
                  errorText: serviceValidateController.detailsError.value,
                  controller: serviceValidateController.detailsController,
                  validate: serviceValidateController.validateDetails,
                  isHintText: false,
                  lengthLimiting: 40,
                  isShowLength: true,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      controller.close();
                      Get.back();
                    },
                    child: Text(
                      'Cancel',
                      style: Get.textTheme.titleLarge!.copyWith(
                        color: Get.theme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      if (serviceValidateController.validateForm()) {
                        vaccinationsRecordsController.editVaccination();
                      }
                    },
                    child: const Text('Edit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      enableDrag: false,
    );
  }
}
