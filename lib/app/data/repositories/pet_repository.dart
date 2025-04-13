import '../models/pet_model.dart';
import '../providers/pet_provider.dart';

class PetRepository {
  final PetProvider petProvider;
  PetRepository({required this.petProvider});

  Future<List<Pet>> getListPetModel(String uid) async {
    final petData = await petProvider.getPet(uid);
    final petQuery = petData.docs;
    return petQuery.map((pet) => Pet.fromJson(pet.id, pet.data())).toList();
  }

  Future<void> uploadPetMap(Pet pet) async {
    final petMap = Pet.toJson(pet);
    print('55555555555555555555555555555555555555');
    print(petMap);
    await petProvider.uploadPet(pet.petId, petMap);
  }
}
