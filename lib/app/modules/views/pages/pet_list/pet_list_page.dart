import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/controller/pet_controller.dart';
import 'widgets/pet_container.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PetController petController = Get.find<PetController>();

    return Obx(() {
      if (petController.petList.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.pets,
                size: 80,
                color: Get.theme.colorScheme.secondary,
              ),
              const SizedBox(height: 16),
              Text(
                "You don't have any pets yet.",
                style: Get.textTheme.headlineMedium!.copyWith(
                  color: Get.theme.colorScheme.onSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Tap + to add your first pet!",
                style: Get.textTheme.titleSmall,
              ),
            ],
          ),
        );
      }
      return Stack(
        children: [
          Opacity(
            opacity: 0.1,
            child: Image.asset(
              'assets/background/good_boy.png',
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: petController.petList.length,
            itemBuilder:
                (context, index) =>
                    PetContainer(pet: petController.petList[index]),
          ),
        ],
      );
    });
  }
}
