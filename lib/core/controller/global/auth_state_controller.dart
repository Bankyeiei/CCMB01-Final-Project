import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'loading_controller.dart';

import '../../../services/snackbar_service.dart';

class AuthStateController extends GetxController {
  final LoadingController _loadingController = Get.find<LoadingController>();

  final _box = GetStorage();
  final _auth = FirebaseAuth.instance;

  RxBool isRememberMe = false.obs;
  RxBool hasJustLoggedIn = false.obs;
  RxString uid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    uid.value = _box.read('uid');
  }

  Widget get loadingScreen => _loadingController.loadingScreen();

  void clickCheckBox(bool value) {
    isRememberMe.value = value;
  }

  void _saveAuthState(String userId) {
    if (isRememberMe.value) {
      _box.write('isLoggedIn', true);
    }
    hasJustLoggedIn.value = true;
    uid.value = userId;

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
      Get.offNamed('/home');
    } catch (error) {
      SnackbarService.showLoginError(error);
      _loadingController.isLoading.value = false;
    }
  }

  void clearAuthState() {
    isRememberMe.value = false;
    uid.value = '';

    _box.remove('isLoggedIn');
    _box.remove('uid');
  }
}
