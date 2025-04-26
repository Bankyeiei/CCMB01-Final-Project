class Vaccination {
  final String vaccinationId;
  String details;
  final String petId;
  DateTime vaccinatedAt;
  Vaccination({
    required this.vaccinationId,
    required this.details,
    required this.petId,
    required this.vaccinatedAt,
  });

  factory Vaccination.fromJson(
    String vaccinationId,
    Map<String, dynamic> jsonMap,
  ) {
    return Vaccination(
      vaccinationId: vaccinationId,
      details: jsonMap['details'] ?? '',
      petId: jsonMap['pet_id'],
      vaccinatedAt: jsonMap['vaccinated_at'].toDate(),
    );
  }

  static Map<String, dynamic> toJson(Vaccination vaccination) {
    final Map<String, dynamic> vaccinationMap = {
      'details': vaccination.details,
      'pet_id': vaccination.petId,
      'vaccinated_at': vaccination.vaccinatedAt,
    };
    return vaccinationMap;
  }
}
