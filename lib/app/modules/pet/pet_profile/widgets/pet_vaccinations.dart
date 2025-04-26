import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/app_routes.dart';

import '../../../../data/models/vaccination_model.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../../core/controller/vaccination_controller.dart';

class PetVaccinations extends StatelessWidget {
  final String petId;
  const PetVaccinations({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final VaccinationController vaccinationController =
        Get.find<VaccinationController>();

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
                Icon(Service.vaccination.icon, size: 32),
                const SizedBox(width: 8),
                Text('Vaccinations', style: Get.textTheme.headlineMedium),
                const Spacer(),
                TextButton(
                  onPressed:
                      () => Get.toNamed(
                        Routes.vaccinationRecords,
                        arguments: petId,
                      ),
                  child: const Text(
                    'See all >',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            GetBuilder(
              init: vaccinationController,
              builder:
                  (controller) => FutureBuilder(
                    future: controller.getVaccinationsByPet(petId),
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
                              'Unable to load vaccination data.',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        );
                      }

                      final vaccinationList = snapshot.data!;
                      if (vaccinationList.isEmpty) {
                        return Expanded(
                          child: Align(
                            alignment: const Alignment(0, -0.16),
                            child: Text(
                              'No vaccination records yet.',
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
                            Expanded(
                              child: _vaccinationCard(vaccinationList[0]),
                            ),
                            const SizedBox(width: 16),
                            vaccinationList.length >= 2
                                ? Expanded(
                                  child: _vaccinationCard(vaccinationList[1]),
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

  Card _vaccinationCard(Vaccination vaccination) {
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
              DateFormat.yMMMd().format(vaccination.vaccinatedAt),
              style: Get.textTheme.titleMedium,
              maxLines: 1,
            ),
            const Divider(thickness: 1.6),
            Text(
              vaccination.details.isNotEmpty
                  ? vaccination.details
                  : 'No vaccination details',
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
