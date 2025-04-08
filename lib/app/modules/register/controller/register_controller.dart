import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'register_page_controller.dart';
import '../../../data/repositories/register_repository.dart';
import '../../../../core/controller/image_controller.dart';
import '../../../../core/controller/loading_controller.dart';

class RegisterController extends GetxController {
  final RegisterRepository registerRepository;
  final RegisterPageController registerPageController;
  final ImageController imageController;
  final LoadingController loadingController;
  RegisterController({
    required this.registerRepository,
    required this.registerPageController,
    required this.imageController,
    required this.loadingController,
  });

  final _auth = FirebaseAuth.instance;

  bool get isLoading => loadingController.isLoading.value;

  Future<void> register() async {
    await Get.closeCurrentSnackbar();
    loadingController.isLoading.value = true;
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: registerPageController.emailController.text,
        password: registerPageController.passwordController.text,
      );
      final imageUrl = await imageController.uploadAndGetImageUrl();
      final uid = userCredential.user!.uid;
      await registerRepository.uploadUser(
        uid,
        registerPageController.emailController.text,
        registerPageController.usernameController.text,
        registerPageController.phoneController.text,
        imageUrl,
      );
      Get.back(result: true);
      Get.snackbar('Register success', '');
    } catch (error) {
      Get.snackbar('Register fail', error.toString());
    } finally {
      loadingController.isLoading.value = false;
    }
  }
}
