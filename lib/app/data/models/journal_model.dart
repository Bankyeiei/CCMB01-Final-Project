class Journal {
  final String journalId;
  String title;
  String details;
  List<String> petIds;
  DateTime firstDate;
  DateTime lastDate;
  Journal({
    required this.journalId,
    required this.title,
    this.details = '',
    required this.petIds,
    required this.firstDate,
    required this.lastDate,
  });

  factory Journal.fromJson(String journalId, Map<String, dynamic> jsonMap) {
    return Journal(
      journalId: journalId,
      title: jsonMap['title'] ?? '',
      details: jsonMap['details'] ?? '',
      petIds: (jsonMap['pet_ids'] as List).cast<String>(),
      firstDate: jsonMap['first_date'].toDate(),
      lastDate: jsonMap['last_date'].toDate(),
    );
  }

  static Map<String, dynamic> toJson(Journal journal) {
    final Map<String, dynamic> journalMap = {
      'title': journal.title,
      'details': journal.details,
      'pet_ids': journal.petIds,
      'first_date': journal.firstDate,
      'last_date': journal.lastDate,
    };
    return journalMap;
  }
}
