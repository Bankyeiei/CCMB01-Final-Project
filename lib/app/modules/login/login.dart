import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/login_controller.dart';
import 'controller/remember_me_controller.dart';

import '../widgets/button.dart';
import '../widgets/circle.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginController loginController = Get.find<LoginController>();
  final RememberMeController rememberMeController =
      Get.find<RememberMeController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Stack(
        children: [
          Scaffold(
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.all(32.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 64),
                    Image.asset('assets/logo/logo.png', height: 200),
                    Obx(
                      () => LoginTextField(
                        labelText: 'Email Address',
                        errorText: loginController.emailError.value,
                        icon: Icons.email_outlined,
                        controller: loginController.emailController,
                        validate: loginController.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Obx(
                      () => LoginTextField(
                        labelText: 'Password',
                        errorText: loginController.passwordError.value,
                        icon: Icons.lock_outline,
                        controller: loginController.passwordController,
                        validate: loginController.validatePassword,
                        obscureText: true,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          child: Obx(
                            () => Checkbox(
                              value: rememberMeController.isRememberMe.value,
                              onChanged:
                                  (value) => rememberMeController.check(value!),
                            ),
                          ),
                        ),
                        const Text('Remember me'),
                      ],
                    ),
                    const SizedBox(height: 32),
                    LoginButton(
                      onPressed: () {
                        if (loginController.validateForm()) {
                          // Continue to login
                          print('Validation passed');
                        } else {
                          print('Invalid input');
                        }
                      },
                      child: Text('LOGIN', style: Get.textTheme.titleLarge),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'or connect with',
                      style: Get.theme.textTheme.titleLarge!.copyWith(
                        letterSpacing: 1.2,
                        color: Get.theme.primaryColor,
                      ),
                    ),
                    const SizedBox(height: 24),
                    LoginButton(
                      onPressed: () {},
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
                  ],
                ),
              ),
            ),
            bottomNavigationBar: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                InkWell(
                  onTap: () {},
                  child: Text(
                    'No account? Register now',
                    style: Get.theme.textTheme.headlineSmall!.copyWith(
                      letterSpacing: 1.5,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  height: 0.08 * Get.mediaQuery.size.height,
                  color: Get.theme.primaryColor,
                ),
              ],
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
