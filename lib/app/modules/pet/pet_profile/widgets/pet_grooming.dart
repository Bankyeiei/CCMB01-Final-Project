import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/app_routes.dart';

import '../../../../data/models/grooming_model.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../../core/controller/grooming_controller.dart';

class PetGrooming extends StatelessWidget {
  final String petId;
  const PetGrooming({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final GroomingController groomingController =
        Get.find<GroomingController>();

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
                Icon(Service.grooming.icon, size: 32),
                const SizedBox(width: 8),
                Text('Grooming', style: Get.textTheme.headlineMedium),
                const Spacer(),
                TextButton(
                  onPressed:
                      () =>
                          Get.toNamed(Routes.groomingRecords, arguments: petId),
                  child: const Text(
                    'See all >',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            GetBuilder(
              init: groomingController,
              builder:
                  (controller) => FutureBuilder(
                    future: controller.getGroomingByPet(petId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Expanded(
                          child: Center(
                            child: CircularProgressIndicator(strokeWidth: 6),
                          ),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Expanded(
                          child: Align(
                            alignment: const Alignment(0, -0.16),
                            child: Text(
                              'Unable to load grooming data.',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        );
                      }

                      final groomingList = snapshot.data!;
                      if (groomingList.isEmpty) {
                        return Expanded(
                          child: Align(
                            alignment: const Alignment(0, -0.16),
                            child: Text(
                              'No grooming records yet.',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        );
                      }

                      return Expanded(
                        child: Row(
                          children: [
                            Expanded(child: _groomingCard(groomingList[0])),
                            const SizedBox(width: 16),
                            groomingList.length >= 2
                                ? Expanded(
                                  child: _groomingCard(groomingList[1]),
                                )
                                : const Spacer(),
                          ],
                        ),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Card _groomingCard(Grooming grooming) {
    return Card.outlined(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: Get.theme.colorScheme.onSecondary.withAlpha(127),
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat.yMMMd().format(grooming.groomedAt),
              style: Get.textTheme.titleMedium,
              maxLines: 1,
            ),
            const Divider(thickness: 1.6),
            Text(
              grooming.details.isNotEmpty
                  ? grooming.details
                  : 'No grooming details',
              style: Get.textTheme.labelLarge,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
