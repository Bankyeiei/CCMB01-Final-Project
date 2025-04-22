import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../routes/app_routes.dart';

import 'loading_controller.dart';

import '../../../services/snackbar_service.dart';

class AuthStateController extends GetxController {
  final LoadingController _loadingController = Get.find<LoadingController>();

  final _box = GetStorage();
  final _auth = FirebaseAuth.instance;

  final RxBool isRememberMe = false.obs;

  String uid = '';
  bool hasJustLoggedIn = false;

  @override
  void onInit() {
    super.onInit();
    uid = _box.read('uid');
  }

  Widget get loadingScreen => _loadingController.loadingScreen();

  void clickCheckBox(bool value) {
    isRememberMe.value = value;
  }

  void _saveAuthState(String userId) {
    if (isRememberMe.value) {
      _box.write('isLoggedIn', true);
    }
    hasJustLoggedIn = true;
    uid = userId;

    _box.write('hasLoggedIn', true);
    _box.write('uid', userId);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _saveAuthState(userCredential.user!.uid);
      Get.offNamed(Routes.home);
    } catch (error) {
      SnackbarService.showLoginError(error);
      _loadingController.isLoading.value = false;
    }
  }

  void clearAuthState() {
    isRememberMe.value = false;
    uid = '';

    _box.remove('isLoggedIn');
    _box.remove('uid');
  }
}
