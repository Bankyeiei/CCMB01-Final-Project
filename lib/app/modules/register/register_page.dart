import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'controller/register_controller.dart';

import '../widgets/button.dart';
import '../widgets/circle.dart';
import '../widgets/text_field.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({super.key});
  final RegisterController _registerController = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  children: [
                    Text('Register', style: Get.theme.textTheme.displayMedium),
                    const SizedBox(height: 32),
                    Obx(
                      () => AppTextField(
                        icon: Icons.email_outlined,
                        hintText: 'Email Address',
                        errorText: _registerController.emailError.value,
                        controller: _registerController.emailController,
                        validate: _registerController.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.person_outline,
                        hintText: 'Username',
                        errorText: _registerController.usernameError.value,
                        controller: _registerController.usernameController,
                        validate: _registerController.validateUsername,
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
                        icon: Icons.phone,
                        hintText: 'Phone',
                        errorText: _registerController.phoneError.value,
                        controller: _registerController.phoneController,
                        validate: _registerController.validatePhone,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          MaskTextInputFormatter(
                            mask: '###-###-####',
                            filter: {'#': RegExp(r'[0-9]')},
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.lock_outline,
                        hintText: 'Password',
                        errorText: _registerController.passwordError.value,
                        controller: _registerController.passwordController,
                        validate: _registerController.validatePassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.lock_outline,
                        hintText: 'Confirm Password',
                        errorText:
                            _registerController.confirmPasswordError.value,
                        controller:
                            _registerController.confirmPasswordController,
                        validate: _registerController.validateConfirmPassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    const SizedBox(height: 32),
                    AppButton(
                      onPressed: () {
                        _registerController.validateForm();
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
        ],
      ),
    );
  }
}
