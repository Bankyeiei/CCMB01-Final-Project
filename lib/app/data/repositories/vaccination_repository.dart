import '../models/vaccination_model.dart';
import '../providers/vaccination_provider.dart';

class VaccinationRepository {
  final VaccinationProvider vaccinationProvider;
  VaccinationRepository({required this.vaccinationProvider});

  Future<List<Vaccination>> getVaccinationModelList(String petId) async {
    final vaccinationData = await vaccinationProvider.getVaccinations(petId);
    final vaccinationQuery = vaccinationData.docs;
    return vaccinationQuery
        .map(
          (vaccination) =>
              Vaccination.fromJson(vaccination.id, vaccination.data()),
        )
        .toList();
  }

  Future<void> uploadVaccinationMap(Vaccination vaccination) async {
    final vaccinationMap = Vaccination.toJson(vaccination);
    await vaccinationProvider.uploadVaccination(
      vaccination.vaccinationId,
      vaccinationMap,
    );
  }

  Future<void> deleteVaccination(String vaccinationId) async {
    await vaccinationProvider.deleteVaccination(vaccinationId);
  }
}
