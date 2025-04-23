import 'package:apptomate_custom_list_tile/apptomate_custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/app_routes.dart';

import '../../../../../core/controller/appointment_controller.dart';

class AppointmentListPage extends StatelessWidget {
  const AppointmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();

    return Stack(
      children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: Opacity(
            opacity: 0.5,
            child: Image.asset(
              'assets/background/walking.png',
              fit: BoxFit.contain,
            ),
          ),
        ),
        Obx(() {
          if (appointmentController.appointmentMap.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.pets,
                    size: 80,
                    color: Get.theme.colorScheme.secondary,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Let's set your appointment",
                    style: Get.textTheme.headlineMedium!.copyWith(
                      color: Get.theme.colorScheme.onSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Tap + to add your appointment!",
                    style: Get.textTheme.titleSmall,
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 16),
            physics: const BouncingScrollPhysics(),
            itemCount: appointmentController.appointmentMap.length,
            separatorBuilder:
                (context, index) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Divider(
                    indent: 24,
                    endIndent: 24,
                    color: Get.theme.colorScheme.onSecondary,
                  ),
                ),
            itemBuilder: (context, index) {
              final appointment =
                  appointmentController.appointmentMap.values.toList()[index];
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
                          color: Get.theme.colorScheme.onSecondary.withAlpha(
                            140,
                          ),
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
                          DateTime.now()
                                      .difference(appointment.appointedAt)
                                      .inMinutes >
                                  0
                              ? Get.theme.colorScheme.secondary
                              : Get.theme.colorScheme.onPrimary,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                      ),
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
                      onTap:
                          () => Get.toNamed(
                            Routes.appointmentDetail,
                            arguments: appointment.appointmentId,
                          ),
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              );
            },
          );
        }),
      ],
    );
  }
}
