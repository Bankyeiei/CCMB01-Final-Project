import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../widgets/button.dart';

class PetJournal extends StatelessWidget {
  const PetJournal({super.key});

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
                const Icon(Icons.book_outlined, size: 32),
                const SizedBox(width: 8),
                Text('Pet Journal', style: Get.textTheme.headlineMedium),
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
              'Start your first pet journal to record special moments, health notes, or fun adventures!',
              style: Get.textTheme.bodyMedium!.copyWith(letterSpacing: 0.6),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: AppButton(
                onPressed: () {},
                child: const Text('Add Journal'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
