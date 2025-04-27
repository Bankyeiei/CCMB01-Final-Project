import '../models/journal_model.dart';
import '../providers/journal_provider.dart';

class JournalRepository {
  final JournalProvider journalProvider;
  JournalRepository({required this.journalProvider});

  Future<Journal> getJournalModelById(String journalId) async {
    final journalData = await journalProvider.getJournalById(journalId);
    final journalModel = Journal.fromJson(journalId, journalData.data()!);
    return journalModel;
  }

  Future<List<Journal>> getJournalModelMapByPet(String petId) async {
    final journalData = await journalProvider.getJournalsByPet(petId);
    final journalQuery = journalData.docs;
    return journalQuery
        .map((journal) => Journal.fromJson(journal.id, journal.data()))
        .toList();
  }

  Future<List<Journal>> getJournalModelMapByPets(List<String> petIds) async {
    final journalData = await journalProvider.getJournalsByPets(petIds);
    final journalQuery = journalData.docs;
    return journalQuery
        .map((journal) => Journal.fromJson(journal.id, journal.data()))
        .toList();
  }

  Future<void> uploadJournalMap(Journal journal) async {
    final journalMap = Journal.toJson(journal);
    await journalProvider.uploadJournal(journal.journalId, journalMap);
  }

  Future<void> deleteJournal(String journalId) async {
    await journalProvider.deleteJournal(journalId);
  }
}
