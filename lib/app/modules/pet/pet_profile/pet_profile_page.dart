import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:coco/app/data/models/pet_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:sliver_app_bar_builder/sliver_app_bar_builder.dart';

import '../../../../routes/app_routes.dart';

import '../../../../core/controller/pet_controller.dart';

import 'widgets/pet_info_chip.dart';
import 'widgets/pet_appointments.dart';
import 'widgets/pet_vaccinations.dart';
import 'widgets/pet_grooming.dart';
import 'widgets/pet_journal.dart';
import '../widgets/pet_info_header.dart';
import '../../widgets/curved_bottom.dart';

class PetProfilePage extends StatelessWidget {
  final String petId;
  const PetProfilePage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final PetController petController = Get.find<PetController>();

    return Obx(() {
      final pet = petController.petMap[petId];
      if (pet == null) {
        return Scaffold(appBar: AppBar(automaticallyImplyLeading: false));
      }

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
              leadingActionsPadding: const EdgeInsets.only(left: 4, top: 4),
              leadingActions: [
                (context, expandRatio, barHeight, overlapsContent) =>
                    IconButton(
                      onPressed: () => Get.back(closeOverlays: true),
                      icon: Icon(
                        Icons.arrow_back_sharp,
                        size: 32,
                        color: Get.theme.colorScheme.onPrimary,
                      ),
                    ),
              ],
              trailingActionsPadding: const EdgeInsets.only(right: 10, top: 4),
              trailingActions: [
                (context, expandRatio, barHeight, overlapsContent) =>
                    Transform.translate(
                      offset: Offset(100 * (1 - expandRatio), 0),
                      child: IconButton(
                        onPressed:
                            () => Get.toNamed(Routes.editPet, arguments: pet),
                        tooltip: 'Edit Pet',
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
                    _petInfo(pet),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        const Icon(Icons.auto_stories, size: 28),
                        const SizedBox(width: 8),
                        Text('Pet Story', style: Get.textTheme.displaySmall),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '    ${pet.story.isNotEmpty ? pet.story : "This pet doesn't have a story yet.\n(You can add one to tell others more about them!)"}',
                        style: Get.textTheme.bodyLarge,
                        softWrap: true,
                      ),
                    ),
                    const SizedBox(height: 20),
                    PetAppointments(petId: petId),
                    const SizedBox(height: 32),
                    PetVaccinations(petId: petId),
                    const SizedBox(height: 32),
                    PetGrooming(petId: petId),
                    const SizedBox(height: 32),
                    PetJournal(petId: petId),
                    const SizedBox(height: 32),
                    Opacity(
                      opacity: 0.5,
                      child: Image.asset(
                        'assets/background/walking.png',
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                    SizedBox(height: 0.1 * Get.size.height),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    });
  }

  Row _petInfo(Pet pet) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        PetInfoChip(
          label: 'Birthday',
          value: Text(
            pet.birthday != null
                ? DateFormat('dd MMM yy').format(pet.birthday!)
                : 'Unknown',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.onSecondary,
            ),
          ),
        ),
        PetInfoChip(
          label: 'Age',
          value: Text(
            pet.age.isNotEmpty ? pet.age : 'Unknown',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.onSecondary,
            ),
          ),
        ),
        PetInfoChip(
          label: 'Weight',
          value: Text(
            pet.weight != null
                ? '${NumberFormat('#,###.##').format(pet.weight)} kg'
                : 'Unknown',
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Get.theme.colorScheme.onSecondary,
            ),
          ),
        ),
        PetInfoChip(
          label: 'Color',
          value:
              pet.color!.isEmpty
                  ? Text(
                    'Unknown',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Get.theme.colorScheme.onSecondary,
                    ),
                  )
                  : Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children:
                          pet.color
                              ?.map(
                                (color) => Tooltip(
                                  message: color.text,
                                  preferBelow: false,
                                  verticalOffset: 42,
                                  child: Container(
                                    height: 20,
                                    width: 20,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Get.theme.colorScheme.onSecondary
                                            .withAlpha(60),
                                      ),
                                      color: color.color,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                ),
                              )
                              .toList() ??
                          [],
                    ),
                  ),
        ),
      ],
    );
  }
}
