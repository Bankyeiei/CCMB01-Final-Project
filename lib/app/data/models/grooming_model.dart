class Grooming {
  final String groomingId;
  String details;
  final String petId;
  DateTime groomedAt;
  Grooming({
    required this.groomingId,
    required this.details,
    required this.petId,
    required this.groomedAt,
  });

  factory Grooming.fromJson(String groomingId, Map<String, dynamic> jsonMap) {
    return Grooming(
      groomingId: groomingId,
      details: jsonMap['details'] ?? '',
      petId: jsonMap['pet_id'],
      groomedAt: jsonMap['groomed_at'].toDate(),
    );
  }

  static Map<String, dynamic> toJson(Grooming grooming) {
    final Map<String, dynamic> groomingMap = {
      'details': grooming.details,
      'pet_id': grooming.petId,
      'groomed_at': grooming.groomedAt,
    };
    return groomingMap;
  }
}
