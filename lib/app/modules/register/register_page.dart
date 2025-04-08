import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/register_controller.dart';
import 'controller/register_page_controller.dart';
import '../../../core/controller/image_controller.dart';

import '../widgets/button.dart';
import '../widgets/circle.dart';
import '../widgets/loading.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final RegisterController _registerController = Get.find<RegisterController>();
  final RegisterPageController _registerPageController =
      Get.find<RegisterPageController>();
  final ImageController _imageController = Get.find<ImageController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Container(
            height: double.infinity,
            color: Get.theme.colorScheme.onPrimary,
            child: Opacity(
              opacity: 0.2,
              child: Image.asset('assets/background/background.png'),
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              surfaceTintColor: Get.theme.colorScheme.onPrimary,
              centerTitle: true,
              title: Text('Register', style: Get.theme.textTheme.displayMedium),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Obx(
                      () => Stack(
                        children: [
                          GestureDetector(
                            onTap: () => _imageController.pickImage(),
                            child: CircleAvatar(
                              radius: 48,
                              backgroundImage:
                                  _imageController.imageFile.value != null
                                      ? FileImage(
                                        _imageController.imageFile.value!,
                                      )
                                      : null,
                              child:
                                  _imageController.imageFile.value == null
                                      ? const Icon(
                                        Icons.add_photo_alternate_outlined,
                                        size: 48,
                                      )
                                      : null,
                            ),
                          ),
                          if (_imageController.imageFile.value != null)
                            Positioned(
                              right: 0,
                              bottom: 0,
                              child: GestureDetector(
                                onTap:
                                    () =>
                                        _imageController.imageFile.value = null,
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
                      ),
                    ),
                    const SizedBox(height: 24),
                    Obx(
                      () => AppTextField(
                        icon: Icons.email_outlined,
                        hintText: 'Email Address',
                        errorText: _registerPageController.emailError.value,
                        controller: _registerPageController.emailController,
                        validate: _registerPageController.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.person_outline,
                        hintText: 'Username',
                        errorText: _registerPageController.usernameError.value,
                        controller: _registerPageController.usernameController,
                        validate: _registerPageController.validateUsername,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9]'),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.phone_outlined,
                        hintText: 'Phone',
                        errorText: _registerPageController.phoneError.value,
                        controller: _registerPageController.phoneController,
                        validate: _registerPageController.validatePhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.lock_outline,
                        hintText: 'Password',
                        errorText: _registerPageController.passwordError.value,
                        controller: _registerPageController.passwordController,
                        validate: _registerPageController.validatePassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.lock_outline,
                        hintText: 'Confirm Password',
                        errorText:
                            _registerPageController.confirmPasswordError.value,
                        controller:
                            _registerPageController.confirmPasswordController,
                        validate:
                            _registerPageController.validateConfirmPassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      onPressed: () {
                        Get.focusScope!.unfocus();
                        if (_registerPageController.validateForm()) {
                          _registerController.register();
                        }
                      },
                      child: Text('REGISTER', style: Get.textTheme.titleLarge),
                    ),
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Container(
              height: 0.08 * Get.mediaQuery.size.height,
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
          Obx(
            () =>
                _registerController.isLoading
                    ? const LoadingScreen()
                    : const UnLoadingScreen(),
          ),
        ],
      ),
    );
  }
}
