import 'package:apptomate_custom_list_tile/apptomate_custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller/grooming_records_controller.dart';
import '../controller/service_validate_controller.dart';
import '../../../data/models/appointment_model.dart';
import '../../../data/models/grooming_model.dart';
import '../../../../core/controller/pet_controller.dart';
import '../../../../core/controller/grooming_controller.dart';

import '../widgets/pet_info_header.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/text_field.dart';

class GroomingRecordsPage extends StatelessWidget {
  final String petId;
  const GroomingRecordsPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final GroomingRecordsController groomingRecordsController =
        Get.find<GroomingRecordsController>();
    final GroomingController groomingController =
        Get.find<GroomingController>();
    final ServiceValidateController serviceValidateController =
        Get.find<ServiceValidateController>();
    final PetController petController = Get.find<PetController>();

    final pet = petController.petMap[petId]!;

    return Scaffold(
      appBar: AppBar(title: const Text('Grooming Records')),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: PetInfoHeader(pet: pet),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            child: GetBuilder(
              init: groomingController,
              builder:
                  (controller) => FutureBuilder(
                    future: controller.getGroomingByPet(petId),
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
                            'Unable to load grooming data.',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              letterSpacing: 0.6,
                            ),
                          ),
                        );
                      }

                      final groomingList = snapshot.data!;
                      if (groomingList.isEmpty) {
                        return Align(
                          alignment: const Alignment(0, -0.2),
                          child: Text(
                            'No grooming records yet.',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              letterSpacing: 0.6,
                            ),
                          ),
                        );
                      }

                      return SlidableAutoCloseBehavior(
                        child: ListView.builder(
                          itemCount: groomingList.length,
                          itemBuilder: (context, index) {
                            final grooming = groomingList[index];
                            final controller = groomingRecordsController
                                .getSlidableController(grooming.groomingId);

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
                                        (context) => groomingRecordsController
                                            .deleteGrooming(
                                              grooming.groomingId,
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
                                          grooming,
                                          groomingRecordsController,
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
                                  grooming.groomedAt,
                                ),
                                titleStyle: Get.textTheme.titleMedium,
                                subtitle:
                                    grooming.details.isNotEmpty
                                        ? grooming.details
                                        : 'No grooming details',
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

  void _showEditBottomSheet(
    Grooming grooming,
    GroomingRecordsController groomingRecordsController,
    ServiceValidateController serviceValidateController,
    SlidableController controller,
  ) {
    groomingRecordsController.init(grooming);
    Get.closeCurrentSnackbar();
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 16),
                AppDatePicker(
                  dateValue: groomingRecordsController.serviceDate,
                  label: 'Service Date',
                  lastDate: DateTime.now(),
                  dateFormat: DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                  errorText: serviceValidateController.dateError,
                ),
                const SizedBox(height: 8),
                Obx(
                  () => AppTextField(
                    icon: Service.grooming.icon,
                    hintText: 'Grooming details',
                    errorText: serviceValidateController.detailsError.value,
                    controller: serviceValidateController.detailsController,
                    validate: serviceValidateController.timerValidateDetails,
                    keyboardType: TextInputType.name,
                    inputFormatters: [
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[A-Za-zก-๛ ]'),
                      ),
                    ],
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
                          groomingRecordsController.editGrooming();
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
      ),
      enableDrag: false,
    );
  }
}
