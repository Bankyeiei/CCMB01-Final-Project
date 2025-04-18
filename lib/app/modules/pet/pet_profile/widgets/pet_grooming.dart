import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetGrooming extends StatelessWidget {
  const PetGrooming({super.key});

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Get.theme.colorScheme.onSecondary.withAlpha(127),
          width: 1.5,
        ),
      ),
      child: Container(
        width: double.infinity,
        height: 220,
        padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.shower_outlined, size: 32),
                const SizedBox(width: 8),
                Text('Grooming', style: Get.textTheme.headlineMedium),
                const Spacer(),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See all >',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'No grooming records yet.',
              style: Get.textTheme.bodyMedium!.copyWith(letterSpacing: 0.6),
            ),
          ],
        ),
      ),
    );
  }
}
