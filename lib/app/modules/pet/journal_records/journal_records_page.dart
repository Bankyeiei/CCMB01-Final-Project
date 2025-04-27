import 'package:apptomate_custom_list_tile/apptomate_custom_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../routes/app_routes.dart';

import '../../../../core/controller/pet_controller.dart';
import '../../../../core/controller/journal_controller.dart';

import '../widgets/pet_info_header.dart';

class JournalRecordsPage extends StatelessWidget {
  final String petId;
  const JournalRecordsPage({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final JournalController journalController = Get.find<JournalController>();
    final PetController petController = Get.find<PetController>();

    final pet = petController.petMap[petId]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Records'),
        actions: [
          IconButton(
            onPressed: () => Get.toNamed(Routes.addJournal, arguments: petId),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const NeverScrollableScrollPhysics(),
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: PetInfoHeader(pet: pet),
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            child: GetBuilder(
              init: journalController,
              builder:
                  (controller) => FutureBuilder(
                    future: controller.getJournalsByPet(petId),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Align(
                          alignment: Alignment(0, -0.2),
                          child: CircularProgressIndicator(
                            strokeWidth: 8,
                            strokeAlign: 4,
                          ),
                        );
                      } else if (snapshot.hasError || snapshot.data == null) {
                        return Align(
                          alignment: const Alignment(0, -0.2),
                          child: Text(
                            'Unable to load journal data.',
                            style: Get.textTheme.bodyLarge!.copyWith(
                              letterSpacing: 0.6,
                            ),
                          ),
                        );
                      }

                      final journalList = snapshot.data!;
                      return ListView.builder(
                        itemCount: journalList.length,
                        itemBuilder: (context, index) {
                          final journal = journalList[index];

                          return CustomListTile(
                            dense: true,
                            elevation: 0,
                            borderRadius: 0,
                            shadowColor: Colors.white,
                            backgroundColor:
                                index.isEven
                                    ? Get.theme.colorScheme.secondary.withAlpha(
                                      127,
                                    )
                                    : Get.theme.colorScheme.onPrimary,
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 16,
                            ),
                            title: journal.title,
                            titleStyle: Get.textTheme.titleMedium,
                            subtitle:
                                '${DateFormat.yMMMd().format(journal.firstDate)}${journal.firstDate == journal.lastDate ? '' : ' - ${DateFormat.yMMMd().format(journal.lastDate)}'}',
                            subtitleStyle: Get.textTheme.bodySmall,
                            trailing: const Icon(Icons.arrow_forward_ios),
                            onTap:
                                () => Get.toNamed(
                                  Routes.journalDetail,
                                  arguments: journal.journalId,
                                ),
                          );
                        },
                      );
                    },
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
