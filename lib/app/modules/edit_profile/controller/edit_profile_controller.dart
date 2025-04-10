import 'package:get/get.dart';

import 'edit_profile_validate_controller.dart';
import '../../../../core/controller/image_controller.dart';
import '../../../../core/controller/user_controller.dart';
import '../../../../core/controller/global/auth_state_controller.dart';
import '../../../../core/controller/global/loading_controller.dart';
import '../../../../services/snackbar_service.dart';

class EditProfileController extends GetxController {
  final EditProfileValidateController editProfileValidateController;
  final UserController userController;
  final ImageController imageController;
  EditProfileController({
    required this.editProfileValidateController,
    required this.userController,
    required this.imageController,
  });

  final AuthStateController _authStateController =
      Get.find<AuthStateController>();
  final LoadingController _loadingController = Get.find<LoadingController>();

  bool get isLoading => _loadingController.isLoading.value;

  @override
  void onInit() {
    super.onInit();
    imageController.imageUrl.value = userController.user.imageUrl;
    imageController.imageId = userController.user.imageId;
    editProfileValidateController.nameController.text =
        userController.user.name;
    editProfileValidateController.phoneController.text =
        userController.user.phone;
  }

  Future<void> editUser() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final imageUrlAndId = await imageController.uploadAndGetImageUrlAndId();
      await userController.editUser(
        _authStateController.uid.value,
        editProfileValidateController.nameController.text,
        editProfileValidateController.phoneController.text,
        imageUrlAndId?[0],
        imageUrlAndId?[1],
      );
      Get.back();
      SnackbarService.showEditSuccess();
    } catch (error) {
      SnackbarService.showEditError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }
}
