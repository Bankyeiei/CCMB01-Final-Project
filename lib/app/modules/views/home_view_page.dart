import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/home/home_page.dart';
import 'pages/pet_list/pet_list_page.dart';
import 'pages/profile/profile_page.dart';

import 'controller/home_view_controller.dart';

class HomeViewPage extends StatelessWidget {
  const HomeViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final HomeViewController homeViewController =
        Get.find<HomeViewController>();

    final pages = const [HomePage(), PetListPage(), ProfilePage()];

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
            actionsPadding: const EdgeInsets.only(right: 10),
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
          bottomNavigationBar: Obx(
            () => BottomNavigationBar(
              backgroundColor: Get.theme.primaryColor,
              selectedItemColor: Get.theme.colorScheme.onSecondary,
              unselectedItemColor: Get.theme.colorScheme.onPrimary,
              currentIndex: homeViewController.pageIndex.value,
              onTap: (value) => homeViewController.onTap(value),
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(
                  icon: Icon(Icons.pets),
                  label: 'My Pets',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
            ),
          ),
        ),
        Obx(() => homeViewController.loadingScreen),
      ],
    );
  }
}
