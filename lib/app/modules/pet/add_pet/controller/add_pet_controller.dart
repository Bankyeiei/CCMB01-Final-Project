import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controller/pet_validate_controller.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../../core/controller/pet_controller.dart';
import '../../../../../core/controller/image_controller.dart';
import '../../../../../core/controller/global/auth_state_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class AddPetController extends GetxController {
  final PetValidateController petValidateController;
  final PetController petController;
  final ImageController imageController;
  AddPetController({
    required this.petValidateController,
    required this.petController,
    required this.imageController,
  });

  final AuthStateController _authStateController =
      Get.find<AuthStateController>();
  final LoadingController _loadingController = Get.find<LoadingController>();

  Widget get loadingScreen => _loadingController.loadingScreen();

  final scrollController = ScrollController();

  final RxBool showFAB = false.obs;
  final RxString age = ''.obs;
  final RxString petType = 'Dog'.obs;
  final Rx<Gender> gender = Gender.none.obs;
  final RxList<PetColor> petColor = <PetColor>[].obs;
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
      final petName =
          petValidateController.petNameController.text[0].toUpperCase() +
          petValidateController.petNameController.text.substring(1);
      final weight =
          petValidateController.weightController.text.isNotEmpty
              ? double.parse(petValidateController.weightController.text)
              : null;
      final newPet = Pet(
        petId: '',
        petType: petType.value,
        petName: petName,
        breedName: petValidateController.breedNameController.text,
        gender: gender.value,
        weight: weight,
        color: petColor,
        birthday: birthday.value,
        story: petValidateController.storyController.text,
        imageUrl: imageUrlAndId?[0] ?? '',
        imageId: imageUrlAndId?[1] ?? '',
      );
      await petController.petRepository.uploadPetMap(
        newPet,
        uid: _authStateController.uid,
      );
      await petController.getPets(_authStateController.uid);
      petController.update();
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
