import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/edit_pet_controller.dart';
import '../controller/pet_validate_controller.dart';
import '../../../data/models/pet_model.dart';
import '../../../../core/controller/image_controller.dart';

import '../widgets/gender_drop_down.dart';
import '../widgets/pet_color_drop_down.dart';
import '../widgets/pet_type_drop_down.dart';
import '../../widgets/button.dart';
import '../../widgets/hold_button.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/text_field.dart';

class EditPetPage extends StatelessWidget {
  final Pet pet;
  const EditPetPage({super.key, required this.pet});

  @override
  Widget build(BuildContext context) {
    final EditPetController editPetController = Get.find<EditPetController>();
    final PetValidateController petValidateController =
        Get.find<PetValidateController>();
    final ImageController imageController = Get.find<ImageController>();

    editPetController.init(pet);

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text('Edit Pet')),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    Obx(() => imageAvatar(imageController)),
                    const SizedBox(height: 36),
                    PetTypeDropDown(typeValue: editPetController.petType),
                    const SizedBox(height: 32),
                    Obx(
                      () => AppTextField(
                        icon: Icons.pets,
                        hintText: 'Pet Name',
                        errorText: petValidateController.petNameError.value,
                        controller: petValidateController.petNameController,
                        validate: petValidateController.validatePetName,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z0-9. ]'),
                          ),
                        ],
                        isHintText: false,
                        lengthLimiting: 16,
                      ),
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.pets,
                        hintText: 'Breed Name',
                        errorText: petValidateController.breedNameError.value,
                        controller: petValidateController.breedNameController,
                        validate: petValidateController.validateBreedName,
                        keyboardType: TextInputType.name,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z ]'),
                          ),
                        ],
                        isHintText: false,
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          flex: 9,
                          child: GenderDropdown(
                            genderValue: editPetController.gender,
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 8,
                          child: Obx(
                            () => AppTextField(
                              hintText: 'Weight (kg.)',
                              errorText:
                                  petValidateController.weightError.value,
                              controller:
                                  petValidateController.weightController,
                              validate: petValidateController.validateWeight,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,3}'),
                                ),
                              ],
                              lengthLimiting: 5,
                              isHintText: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    PetColorDropDown(petColorValue: editPetController.petColor),
                    const SizedBox(height: 32),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: AppDatePicker(
                            dateValue: editPetController.birthday,
                            label: 'Birthday',
                            lastDate: DateTime.now(),
                          ),
                        ),
                        const Spacer(),
                        Expanded(
                          flex: 7,
                          child: Obx(
                            () => Text(
                              editPetController.age.value.isNotEmpty
                                  ? 'Age : ${editPetController.age.value}'
                                  : '',
                              style: Get.textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),
                    Obx(
                      () => AppTextField(
                        icon: Icons.description_outlined,
                        hintText: 'Write a story about your pet',
                        errorText: petValidateController.storyError.value,
                        controller: petValidateController.storyController,
                        validate: petValidateController.validateStory,
                        isHintText: false,
                        lengthLimiting: 500,
                        isShowLength: true,
                        maxLines: 5,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    const SizedBox(height: 24),
                    AppButton(
                      onPressed: () {
                        Get.focusScope!.unfocus();
                        if (petValidateController.validateForm()) {
                          editPetController.editPet();
                        }
                      },
                      child: const Text('Edit Pet'),
                    ),
                    const SizedBox(height: 48),
                    HoldButton(
                      onPressed: () => editPetController.deletePet(),
                      label: 'Delete Pet',
                      fillDuration: const Duration(seconds: 5),
                      startColor: Get.theme.primaryColor,
                      endColor: Get.theme.colorScheme.error,
                    ),
                    SizedBox(height: 0.1 * Get.size.height),
                  ],
                ),
              ),
            ),
          ),
          Obx(() => editPetController.loadingScreen),
        ],
      ),
    );
  }

  Stack imageAvatar(ImageController imageController) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () => imageController.pickImageBottomSheet(),
          child: CircleAvatar(
            radius: 48,
            foregroundImage:
                imageController.imageFile.value != null
                    ? FileImage(imageController.imageFile.value!)
                    : imageController.imageUrl.value.isNotEmpty
                    ? CachedNetworkImageProvider(imageController.imageUrl.value)
                    : null,
            child:
                imageController.imageFile.value == null &&
                        imageController.imageUrl.value == ''
                    ? const Icon(Icons.add_photo_alternate_outlined, size: 48)
                    : null,
          ),
        ),
        if (imageController.imageFile.value != null ||
            imageController.imageUrl.value != '')
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () {
                imageController.imageFile.value = null;
                imageController.imageUrl.value = '';
              },
              child: Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.close,
                  size: 16,
                  color: Get.theme.colorScheme.onPrimary,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
