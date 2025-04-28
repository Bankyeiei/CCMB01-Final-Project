import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller/add_appointment_controller.dart';
import '../controller/appointment_validate_controller.dart';
import '../../../../core/controller/pet_controller.dart';

import '../widgets/service_check_button.dart';
import '../widgets/service_time_picker.dart';
import '../../widgets/select_pet_drop_down.dart';
import '../../widgets/button.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/text_field.dart';

class AddAppointmentPage extends StatelessWidget {
  final String? petId;
  const AddAppointmentPage({super.key, this.petId});

  @override
  Widget build(BuildContext context) {
    final AddAppointmentController addAppointmentController =
        Get.find<AddAppointmentController>();
    final AppointmentValidateController appointmentValidateController =
        Get.find<AppointmentValidateController>();
    final PetController petController = Get.find<PetController>();

    if (petId != null) {
      final pet = petController.petMap[petId]!;
      addAppointmentController.pets.add(pet);
    }

    addAppointmentController.init();

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text('Add Appointment')),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Select Pet Service',
                        style: Get.textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      ServiceCheckButton(
                        label: 'Vaccination',
                        serviceValue: addAppointmentController.service,
                      ),
                      const SizedBox(height: 12),
                      ServiceCheckButton(
                        label: 'Grooming',
                        serviceValue: addAppointmentController.service,
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => AppTextField(
                          icon: Icons.info_outline,
                          hintText:
                              '${addAppointmentController.service.value.text} details',
                          errorText:
                              appointmentValidateController.detailsError.value,
                          controller:
                              appointmentValidateController.detailsController,
                          validate:
                              appointmentValidateController
                                  .timerValidateDetails,
                          isHintText: false,
                          lengthLimiting: 40,
                          isShowLength: true,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text('Select your pets', style: Get.textTheme.titleLarge),
                      const SizedBox(height: 16),
                      SelectPetDropDown(
                        petListValue: addAppointmentController.pets,
                        errorText: appointmentValidateController.petError,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Obx(
                          () => Text(
                            appointmentValidateController.petError.value,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Get.theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text('Choose a Date', style: Get.textTheme.titleLarge),
                      const SizedBox(height: 16),
                      AppDatePicker(
                        dateValue: addAppointmentController.serviceDate,
                        label: 'Service Date',
                        startDate: DateTime.now(),
                        dateFormat: DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                        errorText: appointmentValidateController.dateError,
                      ),
                      const SizedBox(height: 16),
                      Text('Pick a Time', style: Get.textTheme.titleLarge),
                      const SizedBox(height: 16),
                      ServiceTimePicker(
                        timeValue: addAppointmentController.serviceTime,
                        label: 'Service Time',
                        errorText: appointmentValidateController.timeError,
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        onPressed: () {
                          if (appointmentValidateController.validateForm()) {
                            addAppointmentController.addAppointment();
                          }
                        },
                        child: const Text('Add Appointment'),
                      ),
                      SizedBox(height: 0.1 * Get.size.height),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => addAppointmentController.loadingScreen),
        ],
      ),
    );
  }
}
