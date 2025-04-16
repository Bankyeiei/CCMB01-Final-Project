import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'add_pet_validate_controller.dart';
import '../../../data/models/pet_model.dart';
import '../../../../core/controller/pet_controller.dart';
import '../../../../core/controller/image_controller.dart';
import '../../../../core/controller/global/auth_state_controller.dart';
import '../../../../core/controller/global/loading_controller.dart';
import '../../../../services/snackbar_service.dart';

class AddPetController extends GetxController {
  final AddPetValidateController addPetValidateController;
  final PetController petController;
  final ImageController imageController;
  AddPetController({
    required this.addPetValidateController,
    required this.petController,
    required this.imageController,
  });

  final AuthStateController _authStateController =
      Get.find<AuthStateController>();
  final LoadingController _loadingController = Get.find<LoadingController>();

  final scrollController = ScrollController();

  Widget get loadingScreen => _loadingController.loadingScreen();

  String petType = 'Dog';
  Gender gender = Gender.none;

  final RxBool showFAB = false.obs;
  final RxString age = ''.obs;
  final Rx<DateTime?> birthday = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    ever(birthday, (_) => _updateAge());
    scrollController.addListener(_scrollListener);
  }

  Future<void> addPet() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final imageUrlAndId = await imageController.uploadAndGetImageUrlAndId();
      final weight =
          addPetValidateController.weightController.text.isNotEmpty
              ? double.parse(addPetValidateController.weightController.text)
              : null;
      final newPet = Pet(
        ownerId: _authStateController.uid,
        petId: null,
        petType: petType,
        petName: addPetValidateController.petNameController.text,
        breedName: addPetValidateController.breedNameController.text,
        gender: gender,
        weight: weight,
        color: addPetValidateController.colorController.text,
        birthday: birthday.value,
        story: addPetValidateController.storyController.text,
        imageUrl: imageUrlAndId?[0] ?? '',
        imageId: imageUrlAndId?[1] ?? '',
      );
      await petController.petRepository.uploadPetMap(newPet);
      petController.petList.add(newPet);
      Get.back(closeOverlays: true);
      SnackbarService.showAddPetSuccess();
    } catch (error) {
      SnackbarService.showAddPetError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }

  void _updateAge() {
    age.value = Pet.calculateAge(birthday.value);
  }

  void _scrollListener() {
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.position.pixels;

    if (currentScroll >= maxScroll - 80) {
      showFAB.value = true;
    } else {
      showFAB.value = false;
    }
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
