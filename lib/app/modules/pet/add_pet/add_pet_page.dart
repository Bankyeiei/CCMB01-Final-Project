import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/add_pet_controller.dart';
import '../controller/pet_validate_controller.dart';
import '../../../../core/controller/image_controller.dart';

import '../widgets/gender_drop_down.dart';
import '../widgets/pet_color_drop_down.dart';
import '../widgets/pet_type_drop_down.dart';
import '../../widgets/button.dart';
import '../../widgets/date_picker.dart';
import '../../widgets/text_field.dart';

class AddPetPage extends StatelessWidget {
  const AddPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPetController addPetController = Get.find<AddPetController>();
    final PetValidateController petValidateController =
        Get.find<PetValidateController>();
    final ImageController imageController = Get.find<ImageController>();

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text('Add Pet')),
            body: SafeArea(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      const SizedBox(height: 36),
                      Obx(() => imageAvatar(imageController)),
                      const SizedBox(height: 36),
                      PetTypeDropDown(typeValue: addPetController.petType),
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
                              RegExp(r'[A-Za-z0-9ก-๛. ]'),
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
                              RegExp(r'[A-Za-zก-๛ ]'),
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
                              genderValue: addPetController.gender,
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
                      PetColorDropDown(
                        petColorValue: addPetController.petColor,
                      ),
                      const SizedBox(height: 32),
                      Row(
                        children: [
                          Expanded(
                            flex: 10,
                            child: AppDatePicker(
                              dateValue: addPetController.birthday,
                              label: 'Birthday',
                              lastDate: DateTime.now(),
                            ),
                          ),
                          const Spacer(),
                          Expanded(
                            flex: 7,
                            child: Obx(
                              () => Text(
                                addPetController.age.value.isNotEmpty
                                    ? 'Age : ${addPetController.age.value}'
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
                          validate: petValidateController.timerValidateStory,
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
                            addPetController.addPet();
                          }
                        },
                        child: const Text('Add Pet'),
                      ),
                      SizedBox(height: 0.1 * Get.size.height),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Obx(() => addPetController.loadingScreen),
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
                    : null,
            child:
                imageController.imageFile.value == null
                    ? const Icon(Icons.add_photo_alternate_outlined, size: 48)
                    : null,
          ),
        ),
        if (imageController.imageFile.value != null)
          Positioned(
            right: 0,
            bottom: 0,
            child: GestureDetector(
              onTap: () => imageController.imageFile.value = null,
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
