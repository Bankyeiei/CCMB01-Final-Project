import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetInfoChip extends StatelessWidget {
  final String label;
  final Widget value;
  const PetInfoChip({super.key, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Container(
        height: 60,
        width: 86,
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
          children: [Text(label), value],
        ),
      ),
    );
  }
}
