import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import 'register_validate_controller.dart';
import '../../../data/models/user_model.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../../core/controller/image_controller.dart';
import '../../../../core/controller/global/loading_controller.dart';
import '../../../../services/snackbar_service.dart';

class RegisterController extends GetxController {
  final RegisterValidateController registerValidateController;
  final UserRepositories userRepositories;
  final ImageController imageController;
  RegisterController({
    required this.registerValidateController,
    required this.userRepositories,
    required this.imageController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  final _auth = FirebaseAuth.instance;

  Widget get loadingScreen => _loadingController.loadingScreen();

  Future<void> register() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: registerValidateController.emailController.text,
        password: registerValidateController.passwordController.text,
      );
      final imageUrlAndId = await imageController.uploadAndGetImageUrlAndId();
      final uid = userCredential.user!.uid;
      await userRepositories.uploadUserMap(
        uid,
        User(
          email: registerValidateController.emailController.text,
          name: registerValidateController.nameController.text,
          phone: registerValidateController.phoneController.text,
          imageUrl: imageUrlAndId?[0] ?? '',
          imageId: imageUrlAndId?[1] ?? '',
          createdAt: DateTime.now(),
        ),
      );
      Get.back(result: true, closeOverlays: true);
      SnackbarService.showRegisterSuccess();
    } catch (error) {
      SnackbarService.showRegisterError(error);
    } finally {
      _loadingController.isLoading.value = false;
    }
  }
}
