import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../data/models/pet_model.dart';

class PetContainer extends StatelessWidget {
  final Pet pet;
  const PetContainer({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed('/pet_profile', arguments: pet.petId),
      child: Container(
        height: 122,
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(color: Get.theme.colorScheme.secondary, blurRadius: 12),
          ],
          color: Get.theme.colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: pet.imageUrl,
                fit: BoxFit.cover,
                height: 90,
                width: 90,
                errorWidget:
                    (context, url, error) => Container(
                      color: Get.theme.colorScheme.secondary,
                      child: Icon(
                        Icons.pets,
                        color: Get.theme.colorScheme.onSecondary.withAlpha(127),
                        size: 36,
                      ),
                    ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pet.petName,
                    maxLines: 1,
                    style: Get.textTheme.titleMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    pet.breedName.isNotEmpty ? pet.breedName : 'Unknown Breed',
                    maxLines: 1,
                    style: Get.textTheme.titleSmall,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Spacer(),
                  Text(
                    'Age : ${pet.birthday != null ? pet.age : 'Unknown'}',
                    maxLines: 1,
                    style: Get.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: pet.gender.color,
                  ),
                  child: Icon(pet.gender.icon, color: Colors.white),
                ),
                const Spacer(),
                Text(pet.petType),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
