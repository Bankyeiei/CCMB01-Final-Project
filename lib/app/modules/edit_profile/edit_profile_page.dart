import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'controller/edit_profile_controller.dart';
import 'controller/edit_profile_validate_controller.dart';
import '../../../core/controller/image_controller.dart';
import '../../../core/controller/user_controller.dart';

import '../widgets/button.dart';
import '../widgets/text_field.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final EditProfileController editProfileController =
        Get.find<EditProfileController>();
    final EditProfileValidateController editProfileValidateController =
        Get.find<EditProfileValidateController>();
    final ImageController imageController = Get.find<ImageController>();
    final UserController userController = Get.find<UserController>();

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(title: const Text('Edit Profile')),
            body: Stack(
              children: [
                Column(
                  children: [
                    const Spacer(flex: 10),
                    Opacity(
                      opacity: 0.32,
                      child: Image.asset(
                        'assets/background/walking.png',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const Spacer(),
                  ],
                ),
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 36),
                        Obx(() => imageAvatar(imageController)),
                        const SizedBox(height: 36),
                        Obx(
                          () => AppTextField(
                            icon: Icons.person_outline,
                            hintText: 'Name',
                            errorText:
                                editProfileValidateController.nameError.value,
                            controller:
                                editProfileValidateController.nameController,
                            validate:
                                editProfileValidateController.validateName,
                            keyboardType: TextInputType.name,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[A-Za-z. ]'),
                              ),
                            ],
                          ),
                        ),
                        Obx(
                          () => AppTextField(
                            icon: Icons.phone_outlined,
                            hintText: 'Phone',
                            errorText:
                                editProfileValidateController.phoneError.value,
                            controller:
                                editProfileValidateController.phoneController,
                            validate:
                                editProfileValidateController.validatePhone,
                            keyboardType: TextInputType.phone,
                            inputFormatters: [
                              FilteringTextInputFormatter.allow(
                                RegExp(r'[0-9]'),
                              ),
                            ],
                            onSubmitted: (value) {
                              if (editProfileValidateController
                                  .validateForm()) {
                                editProfileController.editUser();
                              }
                            },
                            lengthLimiting: 10,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                        const SizedBox(height: 24),
                        AppButton(
                          onPressed: () {
                            Get.focusScope!.unfocus();
                            if (editProfileValidateController.validateForm()) {
                              editProfileController.editUser();
                            }
                          },
                          child: const Text('Edit'),
                        ),
                        const SizedBox(height: 128),
                        Text(
                          'Part of our pet family since',
                          style: Get.textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '${DateFormat.yMMMMd().format(userController.user.createdAt!)} 🐾',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Obx(() => editProfileController.loadingScreen),
        ],
      ),
    );
  }

  Stack imageAvatar(ImageController imageController) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => imageController.pickImageBottomSheet(),
          child: CircleAvatar(
            radius: 48,
            foregroundImage:
                imageController.imageFile.value != null
                    ? FileImage(imageController.imageFile.value!)
                    : imageController.imageUrl.value.isNotEmpty
                    ? CachedNetworkImageProvider(imageController.imageUrl.value)
                    : null,
            child:
                imageController.imageFile.value == null &&
                        imageController.imageUrl.value == ''
                    ? const Icon(Icons.add_photo_alternate_outlined, size: 48)
                    : null,
          ),
        ),
        if (imageController.imageFile.value != null ||
            imageController.imageUrl.value != '')
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                imageController.imageFile.value = null;
                imageController.imageUrl.value = '';
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
