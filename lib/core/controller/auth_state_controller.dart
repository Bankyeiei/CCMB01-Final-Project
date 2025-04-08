import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'loading_controller.dart';

class AuthStateController extends GetxController {
  final LoadingController loadingController;
  AuthStateController({required this.loadingController});

  final _box = GetStorage();
  final _auth = FirebaseAuth.instance;

  RxBool isLoggedIn = false.obs;
  RxBool isRememberMe = false.obs;
  RxString uid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    isLoggedIn.value = _box.read('isLoggedIn') ?? false;
    uid.value = _box.read('uid') ?? '';
  }

  bool get isLoading => loadingController.isLoading.value;

  void clickCheckBox(bool value) {
    isRememberMe.value = value;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    await Get.closeCurrentSnackbar();
    loadingController.isLoading.value = true;
    try {
      final userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      _saveAuthState(userCredential.user!.uid);
    } catch (error) {
      Get.snackbar('Login fail', error.toString());
    } finally {
      loadingController.isLoading.value = false;
    }
  }

  void clearAuthState() {
    isLoggedIn.value = false;
    isRememberMe.value = false;
    uid.value = '';

    _box.erase();
  }

  void _saveAuthState(String userId) {
    if (isRememberMe.value) {
      isLoggedIn.value = true;
    }
    uid.value = userId;

    _box.write('isLoggedIn', isLoggedIn);
    _box.write('uid', userId);
  }
}
