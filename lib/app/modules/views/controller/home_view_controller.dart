import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

import '../../../../core/controller/appointment_controller.dart';
import '../../../../core/controller/user_controller.dart';
import '../../../../core/controller/pet_controller.dart';
import '../../../../core/controller/global/auth_state_controller.dart';
import '../../../../core/controller/global/loading_controller.dart';
import '../../../../services/snackbar_service.dart';

import '../widgets/actions.dart';

class HomeViewController extends GetxController {
  final UserController userController;
  final PetController petController;
  final AppointmentController appointmentController;
  HomeViewController({
    required this.userController,
    required this.petController,
    required this.appointmentController,
  });

  final AuthStateController _authStateController =
      Get.find<AuthStateController>();
  final LoadingController _loadingController = Get.find<LoadingController>();

  final RxInt pageIndex = 0.obs;
  final RxList<String> titles = List.filled(4, '').obs;

  List<List<Widget>?> actions = [null, null, null, null];

  @override
  void onInit() async {
    super.onInit();
    _loadingController.isLoading.value = true;
    try {
      await userController.getUser(_authStateController.uid);
      await petController.getPets(_authStateController.uid);
      await appointmentController.getAppointments(petController.petIds);
      actions = [
        null,
        ViewAppBarActions.petListAction(),
        ViewAppBarActions.appointmentListAction(),
        ViewAppBarActions.profileAction(_logOut),
      ];
      _updateTitles();
      ever(userController.userRx, (_) => _updateTitles());
      _loadingController.isLoading.value = false;
      if (_authStateController.hasJustLoggedIn) {
        SnackbarService.showLoginSuccess();
      } else {
        SnackbarService.showWelcomeBack(
          userController.user.name,
          petController.petMap.length,
        );
      }
    } catch (error) {
      SnackbarService.showError();
    }
  }

  Widget get loadingScreen => _loadingController.loadingScreen();

  void onTap(int value) {
    pageIndex.value = value;
  }

  void _logOut() {
    Get.defaultDialog(
      title: 'Time for a break?',
      middleText: 'See you again soon! 🐾',
      textConfirm: 'Yes, logout',
      textCancel: 'Not yet',
      buttonColor: Get.theme.primaryColor,
      cancelTextColor: Get.theme.primaryColor,
      onConfirm: () {
        _authStateController.clearAuthState();
        Get.offAllNamed(Routes.login);
      },
    );
  }

  void _updateTitles() {
    titles.value = [
      'Hey ${userController.user.name},',
      'My Pets',
      'Appointments',
      userController.user.name,
    ];
  }
}
