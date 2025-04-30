import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../../routes/app_routes.dart';

import 'controller/home_controller.dart';
import '../../controller/home_view_controller.dart';
import '../../../../data/models/appointment_model.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../data/models/journal_model.dart';
import '../../../../../core/controller/pet_controller.dart';
import '../../../../../core/controller/appointment_controller.dart';
import '../../../../../core/controller/journal_controller.dart';

import 'widgets/title_line.dart';
import '../../../widgets/button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  DateTime _getMinDate(AppointmentController appointmentController) {
    return appointmentController.appointmentMap.entries
        .reduce(
          (a, b) => a.value.appointedAt.isBefore(b.value.appointedAt) ? a : b,
        )
        .value
        .appointedAt
        .copyWith(hour: 0, minute: 0);
  }

  List<Appointment>? _getMinDateAppointment(
    AppointmentController appointmentController,
  ) {
    if (appointmentController.appointmentMap.isEmpty) {
      return null;
    }
    final minDate = _getMinDate(appointmentController);
    return appointmentController.appointmentMap.values
        .where(
          (appointment) =>
              appointment.appointedAt.copyWith(hour: 0, minute: 0) == minDate,
        )
        .toList();
  }

  Future<List<Journal>> _getJornalList(
    JournalController journalController,
    List<String> petIds,
  ) async {
    return journalController.getJournalsByPets(petIds);
  }

  @override
  Widget build(BuildContext context) {
    final HomeController homeController = Get.find<HomeController>();
    final HomeViewController homeViewController =
        Get.find<HomeViewController>();
    final PetController petController = Get.find<PetController>();
    final AppointmentController appointmentController =
        Get.find<AppointmentController>();
    final JournalController journalController = Get.find<JournalController>();

    return Obx(
      () =>
          !homeViewController.isLoadingComplete.value
              ? const SizedBox.shrink()
              : SmartRefresher(
                controller: homeController.refreshController,
                header: const ClassicHeader(),
                onRefresh: () => homeController.refreshPage(),
                child: GetBuilder(
                  init: homeController,
                  builder: (controller) {
                    final minDateAppointment = _getMinDateAppointment(
                      appointmentController,
                    );

                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Pet Overview',
                              style: Get.textTheme.headlineLarge,
                            ),
                          ),
                          minDateAppointment == null
                              ? Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                ),
                                padding: const EdgeInsets.all(16),
                                height: 122,
                                decoration: BoxDecoration(
                                  color: Get.theme.colorScheme.onPrimary,
                                  borderRadius: BorderRadius.circular(16),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Get.theme.colorScheme.onSecondary
                                          .withAlpha(140),
                                      offset: const Offset(0, 2),
                                      blurRadius: 2,
                                      spreadRadius: 0.5,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "You don't have any pets with appointments yet 🐾",
                                  style: Get.textTheme.bodyLarge,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                ),
                              )
                              : _petOverviewSection(
                                minDateAppointment,
                                petController,
                              ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Upcoming & Recent',
                              style: Get.textTheme.headlineLarge,
                            ),
                          ),
                          _upComingAndRecentSection(
                            minDateAppointment,
                            petController,
                            journalController,
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Text(
                              'Quick Actions',
                              style: Get.textTheme.headlineLarge,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            child: Column(
                              children: [
                                AppButton(
                                  onPressed: () => Get.toNamed(Routes.addPet),
                                  child: const Text('Add Pet'),
                                ),
                                const SizedBox(height: 20),
                                AppButton(
                                  onPressed:
                                      () => Get.toNamed(Routes.addAppointment),
                                  child: const Text('Add Appointment'),
                                ),
                                const SizedBox(height: 20),
                                AppButton(
                                  onPressed:
                                      () => Get.toNamed(Routes.addJournal),
                                  child: const Text('Add Journal'),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
    );
  }

  GestureDetector _petOverviewSection(
    List<Appointment> appointment,
    PetController petController,
  ) {
    Random random = Random();
    final randomAppointment = appointment[random.nextInt(appointment.length)];
    final randomPet =
        petController.petMap[randomAppointment.petIds[random.nextInt(
          randomAppointment.petIds.length,
        )]]!;

    return GestureDetector(
      onTap:
          () => Get.toNamed(
            Routes.appointmentDetail,
            arguments: randomAppointment.appointmentId,
          ),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(16),
        height: 122,
        decoration: BoxDecoration(
          color: Get.theme.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Get.theme.colorScheme.onSecondary.withAlpha(140),
              offset: const Offset(0, 2),
              blurRadius: 2,
              spreadRadius: 0.5,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: CachedNetworkImage(
                imageUrl: randomPet.imageUrl,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  randomPet.petName,
                  maxLines: 1,
                  style: Get.textTheme.titleLarge,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Text(
                  DateTime.now().isBefore(randomAppointment.appointedAt)
                      ? 'Next Appointment'
                      : 'Due appointment',
                  style: Get.textTheme.titleMedium,
                ),
                Text(
                  '${DateFormat.yMMMEd().format(randomAppointment.appointedAt)}, ${DateFormat.jm().format(randomAppointment.appointedAt)}',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  FutureBuilder _upComingAndRecentSection(
    List<Appointment>? appointmentList,
    PetController petController,
    JournalController journalController,
  ) {
    Random random = Random();
    Appointment? randomAppointment;
    List<Appointment> dueAppointment = <Appointment>[];

    if (appointmentList != null) {
      randomAppointment =
          appointmentList[random.nextInt(appointmentList.length)];

      dueAppointment =
          appointmentList
              .where(
                (appointment) =>
                    DateTime.now().isAfter(appointment.appointedAt),
              )
              .toList();
    }

    Appointment? randomDueAppointment;
    Pet? randomDueAppointmentPet;

    if (dueAppointment.isNotEmpty) {
      randomDueAppointment =
          dueAppointment[random.nextInt(dueAppointment.length)];
      randomDueAppointmentPet =
          petController.petMap[randomDueAppointment.petIds[random.nextInt(
            randomDueAppointment.petIds.length,
          )]]!;
    }

    return FutureBuilder(
      future: _getJornalList(journalController, petController.petIds),
      builder:
          (context, snapshot) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: Get.theme.colorScheme.onSecondary.withAlpha(140),
                  offset: const Offset(0, 2),
                  blurRadius: 2,
                  spreadRadius: 0.5,
                ),
              ],
            ),
            child: Builder(
              builder: (context) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (randomAppointment == null &&
                    randomDueAppointment == null &&
                    (snapshot.hasError ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty)) {
                  return Center(
                    child: Text(
                      'No upcoming appointments or recent updates yet. Plan something fun for your pet! 🐾',
                      style: Get.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                      maxLines: 3,
                    ),
                  );
                }

                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (randomAppointment != null)
                      TitleLine(
                        icon: Icons.event,
                        text:
                            '${randomAppointment.service.text} Appointment - ${DateFormat.MMMd().format(randomAppointment.appointedAt)}',
                      ),
                    if (randomDueAppointment != null &&
                        randomDueAppointmentPet != null)
                      TitleLine(
                        icon: randomDueAppointment.service.icon,
                        text:
                            "${randomDueAppointmentPet.petName} ${randomDueAppointment.service.text.toLowerCase()} due!",
                      ),
                    if (!(snapshot.connectionState == ConnectionState.waiting ||
                        snapshot.hasError ||
                        snapshot.data == null ||
                        snapshot.data!.isEmpty))
                      Builder(
                        builder: (context) {
                          final journal = snapshot.data![0];

                          return TitleLine(
                            icon: Icons.auto_stories_outlined,
                            text: 'Latest journal : ${journal.title}',
                          );
                        },
                      ),
                  ],
                );
              },
            ),
          ),
    );
  }
}
