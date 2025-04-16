import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  void jumpToRegister() async {
    final isRegister = await Get.toNamed('/register') ?? false;
    if (isRegister) {
      Get.offNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Get.theme.primaryColor.withAlpha(80),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: 0.16 * Get.size.height),
              Image.asset('assets/logo/logo.png', height: 180),
              const SizedBox(height: 48),
              Text(
                'Hey! Welcome',
                style: Get.textTheme.displaySmall!.copyWith(letterSpacing: 2),
              ),
              const SizedBox(height: 20),
              Text(
                "While You Sit And Stay - We'll\nGo Out And Play",
                style: Get.textTheme.bodySmall!.copyWith(letterSpacing: 2.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () => jumpToRegister(),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'GET STARTED >',
                    style: Get.textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      letterSpacing: 4,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 80),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: Get.textTheme.headlineSmall!.copyWith(
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => Get.offNamed('/login'),
                    child: Text(
                      'Login',
                      style: Get.textTheme.headlineSmall!.copyWith(
                        color: Get.theme.primaryColor,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
