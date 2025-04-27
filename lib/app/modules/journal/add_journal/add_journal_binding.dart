import 'package:get/get.dart';

import 'controller/add_journal_controller.dart';
import '../controller/journal_validate_controller.dart';
import '../../../../core/controller/journal_controller.dart';

class AddJournalBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalValidateController>(() => JournalValidateController());
    Get.lazyPut<AddJournalController>(
      () => AddJournalController(
        journalValidateController: Get.find<JournalValidateController>(),
        journalController: Get.find<JournalController>(),
      ),
    );
  }
}
