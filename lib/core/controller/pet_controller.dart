import 'package:get/get.dart';

import '../../app/data/models/pet_model.dart';
import '../../app/data/repositories/pet_repository.dart';

class PetController extends GetxController {
  final PetRepository petRepository;
  PetController({required this.petRepository});

  final RxMap<String, Pet> petMapRx = <String, Pet>{}.obs;

  Map<String, Pet> get petMap => petMapRx;

  Future<void> getPets(String uid) async {
    petMapRx.value = await petRepository.getPetModelMap(uid);
  }

  Future<void> editPet(
    String ownerId,
    String petId,
    String petType,
    String petName,
    String breedName,
    Gender gender,
    double? weight,
    String color,
    DateTime? birthday,
    String story,
    String imageUrl,
    String imageId,
  ) async {
    final newPet = Pet(
      ownerId: ownerId,
      petId: petId,
      petType: petType,
      petName: petName,
      breedName: breedName,
      gender: gender,
      weight: weight,
      color: color,
      birthday: birthday,
      age: Pet.calculateAge(birthday),
      story: story,
      imageUrl: imageUrl,
      imageId: imageId,
    );
    await petRepository.uploadPetMap(newPet);
    petMapRx.update(petId, (value) => newPet);
  }

  Future<void> deletePet(String petId) async {
    await petRepository.deletePet(petId);
    petMapRx.remove(petId);
  }
}
