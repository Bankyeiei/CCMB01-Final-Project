import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/login_controller.dart';

import 'widget/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final LoginController controller = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40),
                Obx(
                  () => LoginTextField(
                    labelText: 'Email Address',
                    errorText: controller.emailError.value,
                    icon: Icons.email_outlined,
                    controller: controller.emailController,
                    validate: controller.validateEmail,
                  ),
                ),
                SizedBox(height: 16),
                Obx(
                  () => LoginTextField(
                    labelText: 'Password',
                    errorText: controller.passwordError.value,
                    icon: Icons.lock_outline,
                    controller: controller.passwordController,
                    validate: controller.validatePassword,
                  ),
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: () {
                    if (controller.validateForm()) {
                      // Continue to login
                      print('Validation passed');
                    } else {
                      print('Invalid input');
                    }
                  },
                  child: const Text('Login'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
