import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controller/add_journal_controller.dart';
import '../controller/journal_validate_controller.dart';
import '../../../../core/controller/pet_controller.dart';

import '../widgets/date_range_picker.dart';
import '../../widgets/button.dart';
import '../../widgets/select_pet_drop_down.dart';
import '../../widgets/text_field.dart';

class AddJournalPage extends StatelessWidget {
  final String? petId;
  const AddJournalPage({super.key, this.petId});

  @override
  Widget build(BuildContext context) {
    final AddJournalController addJournalController =
        Get.find<AddJournalController>();
    final JournalValidateController journalValidateController =
        Get.find<JournalValidateController>();
    final PetController petController = Get.find<PetController>();

    if (petId != null) {
      final pet = petController.petMap[petId]!;
      addJournalController.pets.add(pet);
    }

    addJournalController.init();

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text('Add Journal')),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        child: Text(
                          'Pet Journal',
                          style: Get.textTheme.titleLarge,
                        ),
                      ),
                      const SizedBox(height: 24),
                      Obx(
                        () => AppTextField(
                          icon: Icons.title,
                          hintText: 'Title',
                          errorText: journalValidateController.titleError.value,
                          controller: journalValidateController.titleController,
                          validate: journalValidateController.validateTitle,
                          isHintText: false,
                        ),
                      ),
                      AppDateRangePicker(
                        dateValue: addJournalController.journalDate,
                        lastDate: DateTime.now(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Obx(
                          () => Text(
                            journalValidateController.dateError.value,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Get.theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SelectPetDropDown(
                        petListValue: addJournalController.pets,
                        errorText: journalValidateController.petError,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12, top: 4),
                        child: Obx(
                          () => Text(
                            journalValidateController.petError.value,
                            style: Get.textTheme.bodySmall!.copyWith(
                              color: Get.theme.colorScheme.error,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Obx(
                        () => AppTextField(
                          icon: Icons.description_outlined,
                          hintText: 'Journal details',
                          errorText:
                              journalValidateController.detailsError.value,
                          controller:
                              journalValidateController.detailsController,
                          validate:
                              journalValidateController.timerValidateDetails,
                          isHintText: false,
                          lengthLimiting: 500,
                          isShowLength: true,
                          maxLines: 7,
                          textInputAction: TextInputAction.done,
                        ),
                      ),
                      const SizedBox(height: 20),
                      AppButton(
                        onPressed: () {
                          if (journalValidateController.validateForm()) {
                            addJournalController.addJournal();
                          }
                        },
                        child: const Text('Add Journal'),
                      ),
                      SizedBox(height: 0.1 * Get.size.height),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => addJournalController.loadingScreen),
        ],
      ),
    );
  }
}
