import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';

import '../../data/models/pet_model.dart';

import 'widgets/pet_info_header.dart';
import 'widgets/pet_info_chip.dart';
import 'widgets/pet_appointments.dart';
import 'widgets/pet_vaccinations.dart';
import 'widgets/pet_grooming.dart';
import 'widgets/pet_journal.dart';
import '../widgets/curved_bottom.dart';

class PetProfilePage extends StatelessWidget {
  final Pet pet;
  const PetProfilePage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBarBuilder(
            barHeight: 56,
            pinned: true,
            floating: true,
            contentBelowBar: false,
            initialContentHeight: 0.75 * Get.size.width,
            backgroundColorAll: Get.theme.colorScheme.onPrimary,
            contentBuilder:
                (
                  context,
                  expandRatio,
                  contentHeight,
                  centerPadding,
                  overlapsContent,
                ) => ClipPath(
                  clipper: CurvedBottomClipper(height: 40 * expandRatio),
                  child: ImageFiltered(
                    imageFilter: ImageFilter.blur(
                      sigmaX: 5 * (1 - expandRatio),
                      sigmaY: 5 * (1 - expandRatio),
                      tileMode: TileMode.clamp,
                    ),
                    child: CachedNetworkImage(
                      imageUrl: pet.imageUrl,
                      color: Get.theme.primaryColor.withAlpha(
                        (255 * (1 - expandRatio)).round(),
                      ),
                      colorBlendMode: BlendMode.srcOver,
                      width: Get.size.width,
                      height: contentHeight,
                      fit: BoxFit.cover,
                      errorWidget:
                          (context, url, error) => Container(
                            color: Color.lerp(
                              Get.theme.primaryColor,
                              Get.theme.colorScheme.secondary,
                              expandRatio,
                            ),

                            child: Icon(
                              Icons.pets,
                              color: Get.theme.colorScheme.onSecondary
                                  .withAlpha(127),
                              size: 128 * expandRatio,
                            ),
                          ),
                    ),
                  ),
                ),
            leadingActionsPadding: const EdgeInsets.only(left: 4, top: 2),
            leadingActions: [
              (context, expandRatio, barHeight, overlapsContent) => IconButton(
                onPressed: () => Get.back(),
                icon: Icon(
                  Icons.arrow_back_sharp,
                  size: 32,
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
            ],
            trailingActionsPadding: const EdgeInsets.only(right: 10, top: 2),
            trailingActions: [
              (context, expandRatio, barHeight, overlapsContent) =>
                  Transform.translate(
                    offset: Offset(100 * (1 - expandRatio), 0),
                    child: IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.edit,
                        size: 32,
                        color: Get.theme.colorScheme.onPrimary.withAlpha(
                          (255 *
                                  (expandRatio < 0.6
                                      ? 0
                                      : 2.5 * (expandRatio - 0.6)))
                              .round(),
                        ),
                      ),
                    ),
                  ),
            ],
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: PetInfoHeader(pet: pet),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.pets, size: 28),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'About ${pet.petName}',
                          maxLines: 1,
                          style: Get.textTheme.displaySmall,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      PetInfoChip(
                        label: 'Birthday',
                        value:
                            pet.birthday != null
                                ? DateFormat('dd MMM yy').format(pet.birthday!)
                                : 'Unknown',
                        width: 96,
                      ),
                      PetInfoChip(
                        label: 'Age',
                        value: pet.age.isNotEmpty ? pet.age : 'Unknown',
                        width: 96,
                      ),
                      PetInfoChip(
                        label: 'Weight',
                        value:
                            pet.weight != null ? '${pet.weight} kg' : 'Unknown',
                        width: 96,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  PetInfoChip(
                    label: 'Color',
                    value: pet.color.isNotEmpty ? pet.color : 'Unknown',
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      pet.story.isNotEmpty
                          ? pet.story
                          : "This pet doesn't have a story yet.\n(You can add one to tell others more about them!)",
                      softWrap: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const PetAppointments(),
                  const SizedBox(height: 32),
                  const PetVaccinations(),
                  const SizedBox(height: 32),
                  const PetGrooming(),
                  const SizedBox(height: 32),
                  const PetJournal(),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
