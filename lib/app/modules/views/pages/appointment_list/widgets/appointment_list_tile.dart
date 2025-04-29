import 'package:apptomate_custom_list_tile/apptomate_custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../../routes/app_routes.dart';

import '../../../../../data/models/appointment_model.dart';

class AppointmentListTile extends StatelessWidget {
  final Appointment appointment;
  const AppointmentListTile({super.key, required this.appointment});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 16),
          height: 96,
          width: 72,
          decoration: BoxDecoration(
            color: appointment.service.color,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Get.theme.colorScheme.onSecondary.withAlpha(140),
                offset: const Offset(0, 2),
                blurRadius: 2,
                spreadRadius: 0.5,
              ),
            ],
          ),
          child: Icon(appointment.service.icon, size: 60),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: CustomListTile(
            dense: true,
            height: 96,
            elevation: 2,
            backgroundColor:
                DateTime.now().isAfter(appointment.appointedAt)
                    ? Get.theme.colorScheme.secondary
                    : Get.theme.colorScheme.onPrimary,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            title: appointment.service.text,
            titleStyle: Get.textTheme.titleLarge,
            subtitleWidget: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          flex: 9,
                          child: Text(
                            appointment.details.isNotEmpty
                                ? appointment.details
                                : 'No details',
                            style: Get.textTheme.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                    Text(
                      '${DateFormat.yMMMEd().format(appointment.appointedAt)}, ${DateFormat.jm().format(appointment.appointedAt)}',
                      style: Get.textTheme.bodySmall!.copyWith(
                        color: Get.theme.colorScheme.onSecondary,
                      ),
                    ),
                  ],
                ),
                const Positioned(
                  top: 0,
                  right: 0,
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
            onTap: () {
              Get.focusScope!.unfocus();
              Get.toNamed(
                Routes.appointmentDetail,
                arguments: appointment.appointmentId,
              );
            },
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
