import 'package:coco/app/data/models/journal_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../controller/journal_validate_controller.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../../core/controller/journal_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class AddJournalController extends GetxController {
  final JournalValidateController journalValidateController;
  final JournalController journalController;
  AddJournalController({
    required this.journalValidateController,
    required this.journalController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  Widget get loadingScreen => _loadingController.loadingScreen();

  final RxList<Pet> pets = <Pet>[].obs;
  final RxList<DateTime> journalDate = <DateTime>[].obs;

  void init() {
    journalValidateController.pets = pets;
    journalValidateController.journalDate = journalDate;
  }

  Future<void> addJournal() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final petIds = pets.map((pet) => pet.petId).toList();

      final newJournal = Journal(
        journalId: '',
        title: journalValidateController.titleController.text,
        details: journalValidateController.detailsController.text,
        petIds: petIds,
        firstDate: journalDate[0],
        lastDate: journalDate.length == 2 ? journalDate[1] : journalDate[0],
      );
      await journalController.journalRepository.uploadJournalMap(newJournal);
      journalController.update();
      Get.back(closeOverlays: true);
      SnackbarService.showAddJournalSuccess();
    } catch (error) {
      SnackbarService.showAddJournalError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }
}
