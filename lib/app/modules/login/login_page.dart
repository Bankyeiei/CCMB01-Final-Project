import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/login_page_controller.dart';
import '../../../core/controller/auth_state_controller.dart';

import '../widgets/button.dart';
import '../widgets/circle.dart';
import '../widgets/loading.dart';
import '../widgets/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginPageController _loginPageController =
      Get.find<LoginPageController>();
  final AuthStateController _authStateController =
      Get.find<AuthStateController>();

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
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    SizedBox(height: 0.1 * Get.mediaQuery.size.height),
                    Image.asset('assets/logo/logo.png', height: 180),
                    const SizedBox(height: 32),
                    Obx(
                      () => AppTextField(
                        icon: Icons.email_outlined,
                        hintText: 'Email Address',
                        errorText: _loginPageController.emailError.value,
                        controller: _loginPageController.emailController,
                        validate: _loginPageController.validateEmail,
                        keyboardType: TextInputType.emailAddress,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.lock_outline,
                        hintText: 'Password',
                        errorText: _loginPageController.passwordError.value,
                        controller: _loginPageController.passwordController,
                        validate: _loginPageController.validatePassword,
                        obscureText: true,
                        keyboardType: TextInputType.visiblePassword,
                      ),
                    ),
                    Row(
                      children: [
                        SizedBox(
                          height: 20,
                          child: Obx(
                            () => Checkbox(
                              value: _authStateController.isRememberMe.value,
                              onChanged:
                                  (value) => _authStateController.clickCheckBox(
                                    value!,
                                  ),
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
                        if (_loginPageController.validateForm()) {
                          _authStateController.signInWithEmailAndPassword(
                            _loginPageController.emailController.text,
                            _loginPageController.passwordController.text,
                          );
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
                    AppButton(
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
            bottomNavigationBar: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () => Get.toNamed('/register'),
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
          Obx(
            () =>
                _authStateController.isLoading
                    ? const LoadingScreen()
                    : const UnLoadingScreen(),
          ),
        ],
      ),
    );
  }
}
