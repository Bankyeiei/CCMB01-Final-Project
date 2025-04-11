import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../core/controller/user_controller.dart';
import '../../../../core/controller/global/auth_state_controller.dart';
import '../../../../core/controller/global/loading_controller.dart';
import '../../../../services/snackbar_service.dart';

import '../widgets/actions.dart';

class HomeViewController extends GetxController {
  final UserController userController;
  HomeViewController({required this.userController});

  final AuthStateController _authStateController =
      Get.find<AuthStateController>();
  final LoadingController _loadingController = Get.find<LoadingController>();

  RxInt pageIndex = 0.obs;
  RxList<String> titles = List.filled(3, '').obs;
  List<List<Widget>?> actions = [null, null, null];

  @override
  void onInit() async {
    super.onInit();
    _loadingController.isLoading.value = true;
    await userController.getUser(_authStateController.uid.value);
    _updateTitles();
    ever(userController.userRx, (_) => _updateTitles());
    actions = [null, null, AppBarActions.profileAction(_logOut)];
    _loadingController.isLoading.value = false;
    if (_authStateController.hasJustLoggedIn.value) {
      SnackbarService.showLoginSuccess();
    } else {
      SnackbarService.showWelcomeBack(userController.user.name);
    }
  }

  Widget get loadingScreen => _loadingController.loadingScreen();

  void onTap(int value) {
    pageIndex.value = value;
  }

  void _updateTitles() {
    titles.value = [
      'Hey ${userController.user.name},',
      'My Pets',
      userController.user.name,
    ];
  }

  void _logOut() {
    Get.defaultDialog(
      title: 'Leaving already?',
      middleText: 'Your pet(s) will miss you 🐶',
      textConfirm: 'Logout',
      textCancel: 'Stay',
      buttonColor: Get.theme.primaryColor,
      cancelTextColor: Get.theme.primaryColor,
      onConfirm: () {
        _authStateController.clearAuthState();
        Get.offAllNamed('/login');
      },
    );
  }
}
