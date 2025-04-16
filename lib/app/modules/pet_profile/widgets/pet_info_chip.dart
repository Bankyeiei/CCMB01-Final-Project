import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetInfoChip extends StatelessWidget {
  final String label;
  final String value;
  final double? width;
  const PetInfoChip({
    super.key,
    required this.label,
    required this.value,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        padding:
            width != null ? null : const EdgeInsets.symmetric(horizontal: 24),
        height: 60,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Get.theme.colorScheme.onSecondary.withAlpha(160),
              offset: const Offset(0, 2),
            ),
          ],
          color: const Color(0xFFD1E9D1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(label),
            Text(
              value,
              maxLines: 1,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Get.theme.colorScheme.onSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
