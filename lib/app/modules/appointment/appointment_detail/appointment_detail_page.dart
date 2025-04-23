import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_routes.dart';

import '../../../data/models/appointment_model.dart';
import '../../../../core/controller/appointment_controller.dart';
import '../../../../core/controller/pet_controller.dart';

import '../../widgets/button.dart';
import '../../widgets/pet_container.dart';

class AppointmentDetailPage extends StatelessWidget {
  final String appointmentId;
  const AppointmentDetailPage({super.key, required this.appointmentId});

  @override
  Widget build(BuildContext context) {
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();
    final PetController petController = Get.find<PetController>();

    return Obx(() {
      final appointment = appointmentController.appointmentMap[appointmentId];
      if (appointment == null) {
        return Scaffold(appBar: AppBar(automaticallyImplyLeading: false));
      }
      return Scaffold(
        appBar: AppBar(
          title: const Text('Appointment Detail'),
          actions: [
            IconButton(
              onPressed:
                  () => Get.toNamed(
                    Routes.editAppointment,
                    arguments: appointment,
                  ),
              icon: const Icon(Icons.edit),
            ),
          ],
          shadowColor: Colors.transparent,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        appointment.service.text,
                        style: Get.textTheme.headlineLarge,
                      ),
                      const SizedBox(width: 8),
                      Icon(appointment.service.icon, size: 40),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text('Appointed ', style: Get.textTheme.headlineMedium),
                      const Icon(Icons.keyboard_arrow_down, size: 28),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('   - Date : ', style: Get.textTheme.headlineSmall),
                      Text(
                        DateFormat.yMMMMEEEEd().format(appointment.appointedAt),
                        style: Get.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('   - Time : ', style: Get.textTheme.headlineSmall),
                      Text(
                        DateFormat.jm().format(appointment.appointedAt),
                        style: Get.textTheme.titleSmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  _markButton(appointment),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Text('Details ', style: Get.textTheme.headlineMedium),
                      const Icon(Icons.keyboard_arrow_down, size: 28),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '      ${appointment.details.isNotEmpty ? appointment.details : 'No details'}',
                      maxLines: 2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        'Pets in this appointment ',
                        style: Get.textTheme.headlineMedium,
                      ),
                      const Icon(Icons.keyboard_arrow_down, size: 28),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.separated(
                separatorBuilder:
                    (context, index) => const SizedBox(height: 16),
                physics: const BouncingScrollPhysics(),
                itemCount: appointment.petIds.length,
                itemBuilder:
                    (context, index) => Column(
                      children: [
                        SizedBox(height: index == 0 ? 10 : 0),
                        Obx(
                          () => PetContainer(
                            pet:
                                petController.petMap[appointment
                                    .petIds[index]]!,
                            canNavigate: false,
                          ),
                        ),
                        SizedBox(
                          height:
                              index == appointment.petIds.length - 1 ? 20 : 0,
                        ),
                      ],
                    ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _markButton(Appointment appointment) {
    return AppButton(
      onPressed:
          DateTime.now().difference(appointment.appointedAt).inMinutes > 0
              ? () {}
              : null,
      child: const Text('Mark as Completed'),
    );
  }
}
