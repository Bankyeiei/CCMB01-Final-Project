import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GetStartPage extends StatelessWidget {
  const GetStartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor.withAlpha(80),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/logo/logo.png', height: 200),
              const SizedBox(height: 40),
              Text(
                'Hey! Welcome',
                style: Theme.of(
                  context,
                ).textTheme.titleLarge!.copyWith(letterSpacing: 2),
              ),
              const SizedBox(height: 20),
              Text(
                "While You Sit And Stay - We'll\nGo Out And Play",
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium!.copyWith(letterSpacing: 2.5),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: Text(
                    'GET STARTED >',
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
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
                    style: Theme.of(
                      context,
                    ).textTheme.titleMedium!.copyWith(letterSpacing: 1.5),
                  ),
                  TextButton(
                    onPressed: () {
                      Get.offNamed('/login');
                    },
                    style: TextButton.styleFrom(
                      textStyle: Theme.of(
                        context,
                      ).textTheme.titleMedium!.copyWith(letterSpacing: 1.5),
                    ),
                    child: const Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
