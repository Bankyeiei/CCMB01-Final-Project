import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../routes/app_routes.dart';

import '../../controller/journal_validate_controller.dart';
import '../../../../data/models/journal_model.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../../core/controller/journal_controller.dart';
import '../../../../../core/controller/pet_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class EditJournalController extends GetxController {
  final JournalValidateController journalValidateController;
  final JournalController journalController;
  final PetController petController;
  EditJournalController({
    required this.journalValidateController,
    required this.journalController,
    required this.petController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  Widget get loadingScreen => _loadingController.loadingScreen();

  late final Journal journal;
  final RxList<DateTime> journalDate = <DateTime>[].obs;
  final RxList<Pet> pets = <Pet>[].obs;

  void init(Journal journal) {
    this.journal = journal;
    journalValidateController.titleController.text = journal.title;
    journalValidateController.detailsController.text = journal.details;
    pets.value =
        journal.petIds.map((petId) => petController.petMap[petId]!).toList();
    journalValidateController.pets = pets;

    journalDate.value = [journal.firstDate];
    if (journal.firstDate != journal.lastDate) {
      journalDate.add(journal.lastDate);
    }
    journalValidateController.journalDate = journalDate;
  }

  Future<void> editJournal() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final petIds = pets.map((pet) => pet.petId).toList();
      await journalController.editJournal(
        journal.journalId,
        journalValidateController.titleController.text,
        journalValidateController.detailsController.text,
        petIds,
        journalDate,
      );
      journalController.update();
      Get.back(closeOverlays: true);
      SnackbarService.showEditSuccess();
    } catch (error) {
      SnackbarService.showEditError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }

  Future<void> deleteJournal() async {
    Get.closeCurrentSnackbar();
    Get.defaultDialog(
      title: 'Delete Journal',
      middleText:
          "Are you sure you want to delete this journal? This can't be undone.",
      textConfirm: 'Yes, delete',
      textCancel: 'Cancel',
      buttonColor: Get.theme.colorScheme.error,
      cancelTextColor: Get.theme.colorScheme.error,
      onConfirm: () async {
        Get.back();
        _loadingController.isLoading.value = true;
        try {
          await journalController.deleteJournal(journal.journalId);
          journalController.update();
          Get.until(
            (route) =>
                Get.currentRoute == Routes.petProfile ||
                Get.currentRoute == Routes.home,
          );
          SnackbarService.showDeleteSuccess('Journal');
        } catch (error) {
          SnackbarService.showDeleteError();
        } finally {
          _loadingController.isLoading.value = false;
        }
      },
    );
  }
}
