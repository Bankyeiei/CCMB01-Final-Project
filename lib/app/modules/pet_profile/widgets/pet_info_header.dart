import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/pet_model.dart';

class PetInfoHeader extends SliverPersistentHeaderDelegate {
  final Pet pet;
  const PetInfoHeader({required this.pet});

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(
      child: Material(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24),
            boxShadow: [
              BoxShadow(color: Get.theme.colorScheme.secondary, blurRadius: 12),
            ],
            color: Get.theme.colorScheme.onPrimary,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      pet.petName,
                      maxLines: 1,
                      style: Get.textTheme.headlineMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      pet.breedName.isNotEmpty
                          ? pet.breedName
                          : 'Unknown breed',
                      maxLines: 1,
                      style: Get.textTheme.titleSmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: pet.gender.color,
                ),
                child: Icon(pet.gender.icon, size: 32, color: Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  double get maxExtent => 140;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
