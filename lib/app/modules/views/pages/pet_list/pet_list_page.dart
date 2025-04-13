import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/controller/pet_controller.dart';
import 'widgets/pet_container.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PetController petController = Get.find<PetController>();

    return Obx(
      () => ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: petController.petList.length,
        itemBuilder:
            (context, index) => PetContainer(pet: petController.petList[index]),
      ),
    );
  }
}
