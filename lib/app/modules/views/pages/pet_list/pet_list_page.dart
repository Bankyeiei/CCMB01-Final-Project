import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/pet_list_controller.dart';
import '../../../../../core/controller/pet_controller.dart';

import '../../../widgets/pet_container.dart';

class PetListPage extends StatelessWidget {
  const PetListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PetListController petListController = Get.find<PetListController>();
    final PetController petController = Get.find<PetController>();

    return GetBuilder(
      init: petController,
      builder: (controller) {
        if (controller.petMap.isEmpty) {
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
                  "Let's set your",
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

        petListController.updateSearchedPetList();
        petListController.searchController.text = '';

        return Stack(
          children: [
            Opacity(
              opacity: 0.16,
              child: Image.asset(
                'assets/background/good_boy.png',
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: TextField(
                    controller: petListController.searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Search Pet...',
                      suffixIcon: IconButton(
                        onPressed: () => petListController.resetSearch(),
                        icon: const Icon(Icons.close),
                      ),
                    ),
                    onChanged: (value) => petListController.onChanged(value),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => Get.focusScope!.unfocus(),
                    onTapCancel: () => Get.focusScope!.unfocus(),
                    child: Obx(() {
                      if (petListController.searchedPetList.isEmpty) {
                        return Center(
                          child: Text(
                            'We couldn’t find any pets 🐾',
                            style: Get.textTheme.headlineMedium!.copyWith(
                              color: Get.theme.colorScheme.onSecondary,
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        separatorBuilder:
                            (context, index) => const SizedBox(height: 16),
                        physics: const BouncingScrollPhysics(),
                        keyboardDismissBehavior:
                            ScrollViewKeyboardDismissBehavior.onDrag,
                        itemCount: petListController.searchedPetList.length,
                        itemBuilder:
                            (context, index) => Column(
                              children: [
                                SizedBox(height: index == 0 ? 16 : 0),
                                PetContainer(
                                  pet: petListController.searchedPetList[index],
                                ),
                                SizedBox(
                                  height:
                                      index == controller.petMap.length - 1
                                          ? 16
                                          : 0,
                                ),
                              ],
                            ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
