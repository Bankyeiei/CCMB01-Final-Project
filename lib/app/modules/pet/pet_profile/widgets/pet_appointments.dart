import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/app_routes.dart';

import '../../../../data/models/appointment_model.dart';
import '../../../../../core/controller/appointment_controller.dart';

import '../../../widgets/button.dart';

class PetAppointments extends StatelessWidget {
  final String petId;
  const PetAppointments({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();

    return Obx(() {
      final thisPetAppointments =
          appointmentController.appointmentMap.values
              .where((appointment) => appointment.petIds.contains(petId))
              .toList();

      return Card.outlined(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Get.theme.colorScheme.onSecondary.withAlpha(127),
            width: 1.5,
          ),
        ),
        child: Container(
          width: double.infinity,
          height: 220,
          padding: const EdgeInsets.only(
            left: 16,
            right: 16,
            top: 8,
            bottom: 16,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.event, size: 32),
                  const SizedBox(width: 8),
                  Text('Appointments', style: Get.textTheme.headlineMedium),
                  const Spacer(),
                  TextButton(
                    onPressed: thisPetAppointments.isEmpty ? null : () {},
                    child: const Text(
                      'See all >',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
              Expanded(
                child:
                    thisPetAppointments.isEmpty
                        ? _emptyAppointment(petId)
                        : _notEmptyAppointment(thisPetAppointments),
              ),
            ],
          ),
        ),
      );
    });
  }

  Column _emptyAppointment(String petId) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          "When you schedule an appointment. You'll see it here. Let's set your appointment",
          style: Get.textTheme.bodyMedium!.copyWith(letterSpacing: 0.6),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 64),
          child: AppButton(
            onPressed:
                () => Get.toNamed(Routes.addAppointment, arguments: petId),
            child: const Text('Start'),
          ),
        ),
      ],
    );
  }

  Row _notEmptyAppointment(List<Appointment> thisPetAppointments) {
    return Row(
      children: [
        Expanded(child: _appointmentCard(thisPetAppointments[0])),
        const SizedBox(width: 16),
        thisPetAppointments.length >= 2
            ? Expanded(child: _appointmentCard(thisPetAppointments[1]))
            : Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.secondary.withAlpha(127),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed:
                        () => Get.toNamed(
                          Routes.addAppointment,
                          arguments: petId,
                        ),
                    tooltip: 'Add Appointment',
                    color: Get.theme.primaryColor,
                    icon: const Icon(Icons.add, size: 40),
                  ),
                ),
              ),
            ),
      ],
    );
  }

  GestureDetector _appointmentCard(Appointment appointment) {
    return GestureDetector(
      onTap:
          () => Get.toNamed(
            Routes.appointmentDetail,
            arguments: appointment.appointmentId,
          ),
      child: Card.filled(
        elevation: 4,
        color:
            DateTime.now().difference(appointment.appointedAt).inMinutes > 0
                ? Get.theme.colorScheme.secondary
                : Get.theme.colorScheme.onPrimary,
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: Get.theme.colorScheme.onSecondary.withAlpha(127),
            width: 1.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(appointment.service.text, style: Get.textTheme.titleMedium),
              Text(
                DateFormat.MMMEd().format(appointment.appointedAt),
                style: Get.textTheme.titleSmall,
              ),
              const SizedBox(height: 4),
              Text(
                appointment.details.isNotEmpty
                    ? appointment.details
                    : 'No details',
                style: Get.textTheme.bodySmall,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
