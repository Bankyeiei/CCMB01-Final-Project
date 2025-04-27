import 'package:get/get.dart';

import 'controller/edit_journal_controller.dart';
import '../controller/journal_validate_controller.dart';
import '../../../../core/controller/journal_controller.dart';
import '../../../../core/controller/pet_controller.dart';

class EditJoutnalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalValidateController>(() => JournalValidateController());
    Get.lazyPut<EditJournalController>(
      () => EditJournalController(
        journalValidateController: Get.find<JournalValidateController>(),
        journalController: Get.find<JournalController>(),
        petController: Get.find<PetController>(),
      ),
    );
  }
}
