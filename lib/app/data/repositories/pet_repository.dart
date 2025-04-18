import '../models/pet_model.dart';
import '../providers/pet_provider.dart';

class PetRepository {
  final PetProvider petProvider;
  PetRepository({required this.petProvider});

  Future<Map<String, Pet>> getPetModelMap(String uid) async {
    final petData = await petProvider.getPets(uid);
    final petQuery = petData.docs;
    return {for (var pet in petQuery) pet.id: Pet.fromJson(pet.id, pet.data())};
  }

  Future<void> uploadPetMap(Pet pet) async {
    final petMap = Pet.toJson(pet);
    await petProvider.uploadPet(pet.petId, petMap);
  }

  Future<void> deletePet(String petId) async {
    await petProvider.deletePet(petId);
  }
}
