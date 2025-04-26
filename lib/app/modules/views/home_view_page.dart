import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home/home_page.dart';
import 'pages/pet_list/pet_list_page.dart';
import 'pages/appointment_list/appointment_list_page.dart';
import 'pages/profile/profile_page.dart';

import 'controller/home_view_controller.dart';
import '../../data/models/appointment_model.dart';
import '../../../core/controller/appointment_controller.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewController homeViewController =
        Get.find<HomeViewController>();
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();
    final pages = const [
      HomePage(),
      PetListPage(),
      AppointmentListPage(),
      ProfilePage(),
    ];

    return Stack(
      children: [
        Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Obx(
              () => Text(
                homeViewController.titles[homeViewController.pageIndex.value],
              ),
            ),
            actions: [
              Obx(
                () => Row(
                  mainAxisSize: MainAxisSize.min,
                  children:
                      homeViewController.actions[homeViewController
                          .pageIndex
                          .value] ??
                      [],
                ),
              ),
            ],
          ),
          body: Obx(() => pages[homeViewController.pageIndex.value]),
          bottomNavigationBar: Obx(() {
            final notifyAppointment = Map<String, Appointment>.from(
              appointmentController.appointmentMap,
            );
            notifyAppointment.removeWhere(
              (key, value) =>
                  !(DateTime.now().difference(value.appointedAt).inMinutes > 0),
            );

            final notifyAppointmentLength = notifyAppointment.length;

            return BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: Get.theme.primaryColor,
              selectedItemColor: Get.theme.colorScheme.onSecondary,
              unselectedItemColor: Get.theme.colorScheme.onPrimary,
              currentIndex: homeViewController.pageIndex.value,
              onTap: (value) => homeViewController.onTap(value),
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home, size: 32),
                  label: 'Home',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.pets, size: 32),
                  label: 'My Pets',
                ),
                BottomNavigationBarItem(
                  icon: Stack(
                    children: [
                      const Icon(Icons.event, size: 32),
                      if (notifyAppointmentLength > 0)
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            height: 18,
                            width: 18,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Get.theme.colorScheme.error,
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              notifyAppointmentLength <= 9
                                  ? '$notifyAppointmentLength'
                                  : '9+',
                              style: Get.textTheme.labelSmall!.copyWith(
                                color: Get.theme.colorScheme.onPrimary,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                  label: 'Appointments',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person, size: 32),
                  label: 'Profile',
                ),
              ],
            );
          }),
        ),
        Obx(() => homeViewController.loadingScreen),
      ],
    );
  }
}
