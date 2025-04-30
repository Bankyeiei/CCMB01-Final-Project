import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../routes/app_routes.dart';

import 'controller/login_validate_controller.dart';
import '../../../core/controller/global/auth_state_controller.dart';
import '../../../services/snackbar_service.dart';

import '../widgets/button.dart';
import '../widgets/circle.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginValidateController loginValidateController =
        Get.find<LoginValidateController>();
    final AuthStateController authStateController =
        Get.find<AuthStateController>();

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            resizeToAvoidBottomInset: false,
            body: Stack(
              children: [
                Opacity(
                  opacity: 0.16,
                  child: Image.asset(
                    'assets/background/good_boy.png',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Column(
                    children: [
                      SizedBox(height: 0.1 * Get.size.height),
                      Image.asset('assets/logo/logo.png', height: 180),
                      const SizedBox(height: 32),
                      Obx(
                        () => AppTextField(
                          icon: Icons.email_outlined,
                          hintText: 'Email Address',
                          errorText: loginValidateController.emailError.value,
                          controller: loginValidateController.emailController,
                          validate: loginValidateController.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          lengthLimiting: 50,
                        ),
                      ),
                      Obx(
                        () => AppTextField(
                          icon: Icons.lock_outline,
                          hintText: 'Password',
                          errorText:
                              loginValidateController.passwordError.value,
                          controller:
                              loginValidateController.passwordController,
                          validate: loginValidateController.validatePassword,
                          onSubmitted: (value) {
                            if (loginValidateController.validateForm()) {
                              authStateController.signInWithEmailAndPassword(
                                loginValidateController.emailController.text,
                                loginValidateController.passwordController.text,
                              );
                            }
                          },
                          obscureText: true,
                          keyboardType: TextInputType.visiblePassword,
                          lengthLimiting: 50,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      Row(
                        children: [
                          SizedBox(
                            height: 20,
                            child: Obx(
                              () => Checkbox(
                                value: authStateController.isRememberMe.value,
                                onChanged:
                                    (value) => authStateController
                                        .clickCheckBox(value!),
                              ),
                            ),
                          ),
                          const Text('Remember me'),
                        ],
                      ),
                      const SizedBox(height: 32),
                      AppButton(
                        onPressed: () {
                          Get.focusScope!.unfocus();
                          if (loginValidateController.validateForm()) {
                            authStateController.signInWithEmailAndPassword(
                              loginValidateController.emailController.text,
                              loginValidateController.passwordController.text,
                            );
                          }
                        },
                        child: Text('LOGIN', style: Get.textTheme.titleLarge),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        'or connect with',
                        style: Get.textTheme.titleLarge!.copyWith(
                          letterSpacing: 1.2,
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 24),
                      AppButton(
                        onPressed: () => SnackbarService.showComingSoon(),
                        child: Row(
                          children: [
                            Image.asset('assets/logo/google.png', height: 24),
                            const SizedBox(width: 16),
                            Text(
                              'Login With Google',
                              style: Get.textTheme.titleMedium,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => Get.toNamed(Routes.register),
                        child: Text(
                          'No account? Register now',
                          style: Get.textTheme.headlineSmall!.copyWith(
                            letterSpacing: 1.5,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ),
                      SizedBox(height: 0.02 * Get.size.height),
                    ],
                  ),
                ),
              ],
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
          Obx(() => authStateController.loadingScreen),
        ],
      ),
    );
  }
}
