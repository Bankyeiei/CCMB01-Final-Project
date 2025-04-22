import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/register_controller.dart';
import 'controller/register_validate_controller.dart';
import '../../../core/controller/image_controller.dart';

import '../widgets/button.dart';
import '../widgets/circle.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final RegisterController registerController =
        Get.find<RegisterController>();
    final RegisterValidateController registerValidateController =
        Get.find<RegisterValidateController>();
    final ImageController imageController = Get.find<ImageController>();

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            height: double.infinity,
            color: Get.theme.colorScheme.onPrimary,
            child: Opacity(
              opacity: 0.32,
              child: Image.asset(
                'assets/background/walking.png',
                width: double.infinity,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Get.theme.colorScheme.onPrimary,
              iconTheme: IconThemeData(
                color: Get.theme.colorScheme.onSecondary,
              ),
              title: Text('Register', style: Get.textTheme.displayMedium),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Obx(() => imageAvatar(imageController)),
                    const SizedBox(height: 24),
                    Obx(
                      () => AppTextField(
                        icon: Icons.email_outlined,
                        hintText: 'Email Address',
                        errorText: registerValidateController.emailError.value,
                        controller: registerValidateController.emailController,
                        validate: registerValidateController.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.person_outline,
                        hintText: 'Name',
                        errorText: registerValidateController.nameError.value,
                        controller: registerValidateController.nameController,
                        validate: registerValidateController.validateName,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z ]'),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.phone_outlined,
                        hintText: 'Phone',
                        errorText: registerValidateController.phoneError.value,
                        controller: registerValidateController.phoneController,
                        validate: registerValidateController.validatePhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        ],
                        lengthLimiting: 10,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.lock_outline,
                        hintText: 'Password',
                        errorText:
                            registerValidateController.passwordError.value,
                        controller:
                            registerValidateController.passwordController,
                        validate: registerValidateController.validatePassword,
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: true,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.lock_outline,
                        hintText: 'Confirm Password',
                        errorText:
                            registerValidateController
                                .confirmPasswordError
                                .value,
                        controller:
                            registerValidateController
                                .confirmPasswordController,
                        validate:
                            registerValidateController.validateConfirmPassword,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      onPressed: () {
                        Get.focusScope!.unfocus();
                        if (registerValidateController.validateForm()) {
                          registerController.register();
                        }
                      },
                      child: Text('REGISTER', style: Get.textTheme.titleLarge),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 0.08 * Get.size.height,
              color: Get.theme.primaryColor,
            ),
          ),
          Circle(
            radius: 370,
            color: Get.theme.colorScheme.onSecondary,
            top: -300,
            right: -150,
          ),
          Circle(
            radius: 370,
            color: Get.theme.primaryColor,
            top: -175,
            right: -300,
          ),
          Obx(() => registerController.loadingScreen),
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
                    : null,
            child:
                imageController.imageFile.value == null
                    ? const Icon(Icons.add_photo_alternate_outlined, size: 48)
                    : null,
          ),
        ),
        if (imageController.imageFile.value != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => imageController.imageFile.value = null,
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
