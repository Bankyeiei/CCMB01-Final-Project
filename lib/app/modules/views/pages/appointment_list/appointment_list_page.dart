import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/appointment_list_controller.dart';
import '../../../../../core/controller/appointment_controller.dart';

import 'widgets/appointment_list_tile.dart';

class AppointmentListPage extends StatelessWidget {
  const AppointmentListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AppointmentListController appointmentListController =
        Get.find<AppointmentListController>();
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();

    return GetBuilder(
      init: appointmentController,
      builder: (controller) {
        if (controller.appointmentMap.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.event,
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

        appointmentListController.updateSearchedAppointmentList();
        appointmentListController.searchController.text = '';

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
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: TextField(
                    controller: appointmentListController.searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Appointment...',
                      suffixIcon: IconButton(
                        onPressed:
                            () => appointmentListController.resetSearch(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    onChanged:
                        (value) => appointmentListController.onChanged(value),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.focusScope!.unfocus(),
                    onTapCancel: () => Get.focusScope!.unfocus(),
                    child: Obx(() {
                      if (appointmentListController
                          .searchedAppointmentList
                          .isEmpty) {
                        return Center(
                          child: Text(
                            'No upcoming walks\nor checkups 🐾',
                            style: Get.textTheme.headlineMedium!.copyWith(
                              color: Get.theme.colorScheme.onSecondary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        );
                      }
                      return ListView.separated(
                        separatorBuilder:
                            (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Divider(
                                indent: 24,
                                endIndent: 24,
                                color: Get.theme.colorScheme.onSecondary,
                              ),
                            ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount:
                            appointmentListController
                                .searchedAppointmentList
                                .length,
                        itemBuilder:
                            (context, index) => AppointmentListTile(
                              appointment:
                                  appointmentListController
                                      .searchedAppointmentList[index],
                            ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
