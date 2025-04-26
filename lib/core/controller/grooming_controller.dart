import 'package:get/get.dart';

import '../../app/data/models/grooming_model.dart';
import '../../app/data/repositories/grooming_repository.dart';

class GroomingController extends GetxController {
  final GroomingRepository groomingRepository;
  GroomingController({required this.groomingRepository});

  Future<List<Grooming>> getGroomingByPet(String petId) {
    return groomingRepository.getGroomingModelList(petId);
  }

  Future<void> deleteAllGroomingByPet(String petId) async {
    final groomingByPet = await getGroomingByPet(petId);
    for (var grooming in groomingByPet) {
      groomingRepository.deleteGrooming(grooming.groomingId);
    }
  }
}
