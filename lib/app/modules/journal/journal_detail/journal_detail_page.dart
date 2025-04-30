import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

import '../../../data/models/journal_model.dart';
import '../../../../core/controller/pet_controller.dart';
import '../../../../core/controller/journal_controller.dart';

import '../widgets/date_range_picker.dart';
import '../../widgets/pet_container.dart';

class JournalDetailPage extends StatelessWidget {
  final String journalId;
  const JournalDetailPage({super.key, required this.journalId});

  @override
  Widget build(BuildContext context) {
    final JournalController journalController = Get.find<JournalController>();
    final PetController petController = Get.find<PetController>();

    final Rx<IconButton> editButton =
        const IconButton(onPressed: null, icon: Icon(Icons.edit)).obs;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Journal Detail'),
        actions: [Obx(() => editButton.value)],
      ),
      body: GetBuilder(
        init: journalController,
        builder:
            (controller) => FutureBuilder(
              future: controller.getJournalById(journalId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 8,
                      strokeAlign: 4,
                    ),
                  );
                } else if (snapshot.hasError || snapshot.data == null) {
                  return Center(
                    child: Text(
                      'Unable to load journal data.',
                      style: Get.textTheme.bodyLarge!.copyWith(
                        letterSpacing: 0.6,
                      ),
                    ),
                  );
                }

                final journal = snapshot.data!;
                activateButton(editButton, journal);

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          top: 16,
                          right: 16,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Align(
                              child: Text(
                                journal.title,
                                style: Get.textTheme.headlineLarge,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Stack(
                              children: [
                                AppDateRangePicker(
                                  dateValue:
                                      [journal.firstDate, journal.lastDate].obs,
                                ),
                                const Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    SizedBox(height: 90),
                                    AbsorbPointer(
                                      child: SizedBox(
                                        height: 270,
                                        width: double.infinity,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                      LimitedBox(
                        maxHeight: 0.36 * Get.height,
                        child: ListView.separated(
                          separatorBuilder:
                              (context, index) => const SizedBox(height: 16),
                          itemCount: journal.petIds.length,
                          shrinkWrap: true,
                          itemBuilder:
                              (context, index) => Column(
                                children: [
                                  SizedBox(
                                    height:
                                        index == 0 && journal.petIds.length != 1
                                            ? 20
                                            : 8,
                                  ),
                                  PetContainer(
                                    pet:
                                        petController.petMap[journal
                                            .petIds[index]]!,
                                    canNavigate: false,
                                  ),
                                ],
                              ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      const Divider(thickness: 1.6, indent: 24, endIndent: 24),
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            '      ${journal.details.isNotEmpty ? journal.details : 'No journal details'}',
                            style: Get.textTheme.bodyLarge,
                            softWrap: true,
                          ),
                        ),
                      ),
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
                );
              },
            ),
      ),
    );
  }

  void activateButton(Rx<IconButton> editButton, Journal journal) async {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) =>
          editButton.value = IconButton(
            onPressed:
                () => Get.toNamed(Routes.editJournal, arguments: journal),
            icon: const Icon(Icons.edit),
          ),
    );
  }
}
