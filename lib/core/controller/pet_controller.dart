import 'package:get/get.dart';

import '../../app/data/models/pet_model.dart';
import '../../app/data/repositories/pet_repository.dart';

class PetController extends GetxController {
  final PetRepository petRepository;
  PetController({required this.petRepository});

  final RxList<Pet> petListRx = <Pet>[].obs;

  List<Pet> get petList => petListRx;

  Future<void> getPets(String uid) async {
    petListRx.value = await petRepository.getListPetModel(uid);
  }

  String calculateAge(DateTime? birthday) {
    if (birthday == null) {
      return '';
    }
    final now = DateTime.now();

    int yearDiff = now.year - birthday.year;
    int monthDiff = now.month - birthday.month;
    if (monthDiff < 0) {
      yearDiff -= 1;
      monthDiff += 12;
    }
    return '${yearDiff != 0 ? '${yearDiff}y ' : ''}${monthDiff}m';
  }
}
