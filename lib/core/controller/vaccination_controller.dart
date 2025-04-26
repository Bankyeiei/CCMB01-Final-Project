import 'package:get/get.dart';

import '../../app/data/models/vaccination_model.dart';
import '../../app/data/repositories/vaccination_repository.dart';

class VaccinationController extends GetxController {
  final VaccinationRepository vaccinationRepository;
  VaccinationController({required this.vaccinationRepository});

  Future<List<Vaccination>> getVaccinationsByPet(String petId) {
    return vaccinationRepository.getVaccinationModelList(petId);
  }

  Future<void> deleteAllVaccinationByPet(String petId) async {
    final vaccinationByPet = await getVaccinationsByPet(petId);
    for (var vaccination in vaccinationByPet) {
      vaccinationRepository.deleteVaccination(vaccination.vaccinationId);
    }
  }
}
