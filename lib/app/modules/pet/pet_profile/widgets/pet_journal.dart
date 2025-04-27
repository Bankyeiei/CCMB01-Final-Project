import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/app_routes.dart';

import '../../../../data/models/journal_model.dart';
import '../../../../../core/controller/journal_controller.dart';

import '../../../widgets/button.dart';

class PetJournal extends StatelessWidget {
  final String petId;
  const PetJournal({super.key, required this.petId});

  @override
  Widget build(BuildContext context) {
    final JournalController journalController = Get.find<JournalController>();

    final RxBool disableSeeAll = true.obs;

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
                const Icon(Icons.book_outlined, size: 32),
                const SizedBox(width: 8),
                Text('Pet Journal', style: Get.textTheme.headlineMedium),
                const Spacer(),
                Obx(
                  () => TextButton(
                    onPressed:
                        disableSeeAll.value
                            ? null
                            : () => Get.toNamed(
                              Routes.journalRecords,
                              arguments: petId,
                            ),
                    child: const Text(
                      'See all >',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ),
              ],
            ),
            GetBuilder(
              init: journalController,
              builder:
                  (controller) => FutureBuilder(
                    future: controller.getJournalsByPet(petId),
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
                              'Unable to load journal data.',
                              style: Get.textTheme.bodyMedium!.copyWith(
                                letterSpacing: 0.6,
                              ),
                            ),
                          ),
                        );
                      }

                      final journalList = snapshot.data!;
                      return Expanded(
                        child:
                            journalList.isEmpty
                                ? _emptyJournal(petId, disableSeeAll)
                                : _notEmptyJournal(journalList, disableSeeAll),
                      );
                    },
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Column _emptyJournal(String petId, RxBool disableSeeAll) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => disableSeeAll.value = true,
    );
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 16),
        Text(
          'Start your first pet journal to record special moments, health notes, or fun adventures!',
          style: Get.textTheme.bodyMedium!.copyWith(letterSpacing: 0.6),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: AppButton(
            onPressed: () => Get.toNamed(Routes.addJournal, arguments: petId),
            child: const Text('Add Journal'),
          ),
        ),
      ],
    );
  }

  Row _notEmptyJournal(List<Journal> journalList, RxBool disableSeeAll) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => disableSeeAll.value = false,
    );

    return Row(
      children: [
        Expanded(child: _journalCard(journalList[0])),
        const SizedBox(width: 16),
        journalList.length >= 2
            ? Expanded(child: _journalCard(journalList[1]))
            : Expanded(
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.secondary.withAlpha(127),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    onPressed:
                        () => Get.toNamed(Routes.addJournal, arguments: petId),
                    tooltip: 'Add Journal',
                    color: Get.theme.primaryColor,
                    icon: const Icon(Icons.add, size: 40),
                  ),
                ),
              ),
            ),
      ],
    );
  }

  GestureDetector _journalCard(Journal journal) {
    return GestureDetector(
      onTap:
          () => Get.toNamed(Routes.journalDetail, arguments: journal.journalId),
      child: Card.outlined(
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
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                journal.title,
                style: Get.textTheme.titleMedium!.copyWith(fontSize: 18),
                maxLines: 3,
              ),
              const Spacer(),
              const Divider(thickness: 1.6),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  DateFormat.yMMMd().format(journal.firstDate),
                  style: Get.textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
