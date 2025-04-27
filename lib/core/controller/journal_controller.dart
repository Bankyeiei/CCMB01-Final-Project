import 'package:get/get.dart';

import '../../app/data/models/journal_model.dart';
import '../../app/data/repositories/journal_repository.dart';

class JournalController extends GetxController {
  final JournalRepository journalRepository;
  JournalController({required this.journalRepository});

  Future<Journal> getJournalById(String journalId) {
    return journalRepository.getJournalModelById(journalId);
  }

  Future<List<Journal>> getJournalsByPet(String petId) {
    return journalRepository.getJournalModelMapByPet(petId);
  }

  Future<List<Journal>> getJournalsByPets(List<String> petIds) {
    return journalRepository.getJournalModelMapByPets(petIds);
  }

  Future<void> editJournal(
    String journalId,
    String title,
    String details,
    List<String> petIds,
    List<DateTime> journalDate,
  ) async {
    final editedJournal = Journal(
      journalId: journalId,
      title: title,
      details: details,
      petIds: petIds,
      firstDate: journalDate[0],
      lastDate: journalDate.length == 2 ? journalDate[1] : journalDate[0],
    );
    await journalRepository.uploadJournalMap(editedJournal);
  }

  Future<void> deletePetFromJournals(String petId) async {
    final journalsByPet = await getJournalsByPet(petId);

    for (var journal in journalsByPet) {
      journal.petIds.remove(petId);
      if (journal.petIds.isEmpty) {
        await deleteJournal(journal.journalId);
      } else {
        await journalRepository.uploadJournalMap(journal);
      }
    }
  }

  Future<void> deleteJournal(String journalId) async {
    await journalRepository.deleteJournal(journalId);
  }
}
