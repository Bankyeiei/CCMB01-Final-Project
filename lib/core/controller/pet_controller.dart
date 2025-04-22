import 'package:get/get.dart';

import '../../app/data/models/pet_model.dart';
import '../../app/data/repositories/pet_repository.dart';

class PetController extends GetxController {
  final PetRepository petRepository;
  PetController({required this.petRepository});

  final RxMap<String, Pet> petMap = <String, Pet>{}.obs;

  List<String> get petIds => petMap.values.map((pet) => pet.petId!).toList();

  Future<void> getPets(String uid) async {
    petMap.value = await petRepository.getPetModelMap(uid);
  }

  Future<void> editPet(
    String petId,
    String petType,
    String petName,
    String breedName,
    Gender gender,
    double? weight,
    List<PetColor> color,
    DateTime? birthday,
    String story,
    String imageUrl,
    String imageId,
  ) async {
    final newPet = Pet(
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
    petMap.update(petId, (value) => newPet);
  }

  Future<void> deletePet(String petId) async {
    await petRepository.deletePet(petId);
    petMap.remove(petId);
  }
}
