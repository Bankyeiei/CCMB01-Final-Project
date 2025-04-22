import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../../../routes/app_routes.dart';

import '../../controller/pet_validate_controller.dart';
import '../../../../data/models/pet_model.dart';
import '../../../../../core/controller/pet_controller.dart';
import '../../../../../core/controller/image_controller.dart';
import '../../../../../core/controller/global/loading_controller.dart';
import '../../../../../services/snackbar_service.dart';

class EditPetController extends GetxController {
  final PetValidateController petValidateController;
  final PetController petController;
  final ImageController imageController;
  EditPetController({
    required this.petValidateController,
    required this.petController,
    required this.imageController,
  });

  final LoadingController _loadingController = Get.find<LoadingController>();

  Widget get loadingScreen => _loadingController.loadingScreen();

  late Pet pet;
  final RxString petType = 'Dog'.obs;
  final RxString age = ''.obs;
  final Rx<Gender> gender = Gender.none.obs;
  final RxList<PetColor> petColor = <PetColor>[].obs;
  final Rx<DateTime?> birthday = Rx<DateTime?>(null);

  @override
  void onInit() {
    super.onInit();
    ever(birthday, (_) => _updateAge());
  }

  void init(Pet pet) {
    this.pet = pet;
    imageController.imageUrl.value = pet.imageUrl;
    imageController.imageId = pet.imageId;
    petValidateController.petNameController.text = pet.petName;
    petValidateController.breedNameController.text = pet.breedName;
    petValidateController.weightController.text =
        pet.weight != null ? NumberFormat('0.##').format(pet.weight) : '';
    petValidateController.storyController.text = pet.story;
    petType.value = pet.petType;
    gender.value = pet.gender;
    petColor.value = List.from(pet.color ?? []);
    birthday.value = pet.birthday;
  }

  Future<void> editPet() async {
    Get.closeCurrentSnackbar();
    _loadingController.isLoading.value = true;
    try {
      final imageUrlAndId = await imageController.uploadAndGetImageUrlAndId();
      final weight =
          petValidateController.weightController.text.isNotEmpty
              ? double.parse(petValidateController.weightController.text)
              : null;
      await petController.editPet(
        pet.petId!,
        petType.value,
        petValidateController.petNameController.text,
        petValidateController.breedNameController.text,
        gender.value,
        weight,
        petColor,
        birthday.value,
        petValidateController.storyController.text,
        imageUrlAndId?[0] ?? '',
        imageUrlAndId?[1] ?? '',
      );
      petColor.sort((a, b) => a.text.compareTo(b.text));
      Get.back(closeOverlays: true);
      SnackbarService.showEditSuccess(snackPosition: SnackPosition.BOTTOM);
    } catch (error) {
      SnackbarService.showEditError();
    } finally {
      _loadingController.isLoading.value = false;
    }
  }

  Future<void> deletePet() async {
    Get.defaultDialog(
      title: 'Delete ${pet.petName}?',
      middleText:
          "Are you sure you want to delete ${pet.petName}? This can't be undone.",
      textConfirm: 'Yes, delete',
      textCancel: 'Cancel',
      buttonColor: Get.theme.colorScheme.error,
      cancelTextColor: Get.theme.colorScheme.error,
      onConfirm: () async {
        Get.closeCurrentSnackbar();
        Get.back();
        _loadingController.isLoading.value = true;
        try {
          await imageController.deleteImage();
          await petController.deletePet(pet.petId!);
          Get.until((route) => Get.currentRoute == Routes.home);
          SnackbarService.showDeleteSuccess('Pet');
        } catch (error) {
          SnackbarService.showDeleteError();
        } finally {
          _loadingController.isLoading.value = false;
        }
      },
    );
  }

  void _updateAge() {
    age.value = Pet.calculateAge(birthday.value);
  }
}
