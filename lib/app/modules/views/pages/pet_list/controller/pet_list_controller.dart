import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../../../data/models/pet_model.dart';
import '../../../../../../core/controller/pet_controller.dart';

class PetListController extends GetxController {
  final PetController petController;
  PetListController({required this.petController});

  final searchController = TextEditingController();

  final RxList<Pet> searchedPetList = <Pet>[].obs;

  Timer? _petsDebounce;

  void updateSearchedPetList() {
    searchedPetList.value = petController.petMap.values.toList();
  }

  void onChanged(String value) {
    if (_petsDebounce?.isActive ?? false) _petsDebounce!.cancel();

    _petsDebounce = Timer(const Duration(milliseconds: 500), () {
      searchedPetList.value =
          petController.petMap.values
              .where(
                (pet) =>
                    ('${pet.petName}${pet.petType}${pet.breedName}')
                        .toLowerCase()
                        .contains(value.toLowerCase().trim()) ||
                    pet.gender.text.toLowerCase() == value.toLowerCase().trim(),
              )
              .toList();
    });
  }

  void resetSearch() {
    searchController.text = '';
    updateSearchedPetList();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
