import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller/edit_appointment_controller.dart';
import '../controller/appointment_validate_controller.dart';
import '../../../data/models/appointment_model.dart';

import '../widgets/service_time_picker.dart';
import '../../widgets/select_pet_drop_down.dart';
import '../../widgets/button.dart';
import '../../widgets/hold_button.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/text_field.dart';

class EditAppointmentPage extends StatelessWidget {
  final Appointment appointment;
  const EditAppointmentPage({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    final EditAppointmentController editAppointmentController =
        Get.find<EditAppointmentController>();
    final AppointmentValidateController appointmentValidateController =
        Get.find<AppointmentValidateController>();

    editAppointmentController.init(appointment);

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text('Edit Appointment')),
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
                      Text('Pet Service', style: Get.textTheme.titleLarge),
                      const SizedBox(height: 4),
                      Text(
                        editAppointmentController.service.text,
                        style: Get.textTheme.bodyLarge,
                      ),
                      Text(
                        "*You can't edit pet sevice",
                        style: Get.textTheme.labelLarge!.copyWith(
                          color: Get.theme.colorScheme.error,
                        ),
                      ),
                      const SizedBox(height: 16),
                      Obx(
                        () => AppTextField(
                          icon: Icons.info_outline,
                          hintText:
                              '${editAppointmentController.service.text} details',
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
                        petListValue: editAppointmentController.pets,
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
                        dateValue: editAppointmentController.serviceDate,
                        label: 'Service Date',
                        startDate: DateTime.now(),
                        dateFormat: DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                        errorText: appointmentValidateController.dateError,
                      ),
                      const SizedBox(height: 16),
                      Text('Pick a Time', style: Get.textTheme.titleLarge),
                      const SizedBox(height: 16),
                      ServiceTimePicker(
                        timeValue: editAppointmentController.serviceTime,
                        label: 'Service Time',
                        errorText: appointmentValidateController.timeError,
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        onPressed: () {
                          if (appointmentValidateController.validateForm()) {
                            editAppointmentController.editAppointment();
                          }
                        },
                        child: const Text('Edit Appointment'),
                      ),
                      const SizedBox(height: 48),
                      HoldButton(
                        onPressed:
                            () => editAppointmentController.deleteAppointment(),
                        label: 'Delete Appointment',
                        fillDuration: const Duration(seconds: 1),
                        startColor: Get.theme.primaryColor,
                        endColor: Get.theme.colorScheme.error,
                      ),
                      SizedBox(height: 0.1 * Get.size.height),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => editAppointmentController.loadingScreen),
        ],
      ),
    );
  }
}
