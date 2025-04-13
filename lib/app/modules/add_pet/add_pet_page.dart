import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'controller/add_pet_controller.dart';
import 'controller/add_pet_validate_controller.dart';
import '../../../core/controller/image_controller.dart';

import 'widgets/gender_drop_down.dart';
import 'widgets/pet_type_drop_down.dart';
import '../widgets/date_picker.dart';
import '../widgets/text_field.dart';

class AddPetPage extends StatelessWidget {
  const AddPetPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPetController addPetController = Get.find<AddPetController>();
    final AddPetValidateController addPetValidateController =
        Get.find<AddPetValidateController>();
    final ImageController imageController = Get.find<ImageController>();

    return GestureDetector(
      onTap: () => Get.focusScope!.unfocus(),
      child: Stack(
        children: [
          Scaffold(
            appBar: AppBar(title: const Text('Add Pet')),
            body: SingleChildScrollView(
              controller: addPetController.scrollController,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 36),
                    Obx(() => imageAvatar(imageController)),
                    const SizedBox(height: 36),
                    const PetTypeDropDown(),
                    const SizedBox(height: 32),
                    Obx(
                      () => AppTextField(
                        icon: Icons.pets,
                        hintText: 'Pet Name',
                        errorText: addPetValidateController.petNameError.value,
                        controller: addPetValidateController.petNameController,
                        validate: addPetValidateController.validatePetName,
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
                        errorText:
                            addPetValidateController.breedNameError.value,
                        controller:
                            addPetValidateController.breedNameController,
                        validate: addPetValidateController.validateBreedName,
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
                        const Expanded(flex: 10, child: GenderDropdown()),
                        const Spacer(),
                        Expanded(
                          flex: 8,
                          child: Obx(
                            () => AppTextField(
                              hintText: 'Weight (kg.)',
                              errorText:
                                  addPetValidateController.weightError.value,
                              controller:
                                  addPetValidateController.weightController,
                              validate: addPetValidateController.validateWeight,
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                  RegExp(r'^\d+\.?\d{0,2}'),
                                ),
                              ],
                              lengthLimiting: 7,
                              isHintText: false,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      () => AppTextField(
                        icon: Icons.color_lens_outlined,
                        hintText: 'Color',
                        errorText: addPetValidateController.colorError.value,
                        controller: addPetValidateController.colorController,
                        validate: addPetValidateController.validateColor,
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                            RegExp(r'[A-Za-z ]'),
                          ),
                        ],
                        isHintText: false,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 10,
                          child: AppDatePicker(
                            dateValue: addPetController.birthday,
                            label: 'Birthday',
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
                        errorText: addPetValidateController.storyError.value,
                        controller: addPetValidateController.storyController,
                        validate: addPetValidateController.validateStory,
                        onSubmitted: (value) {
                          addPetController.showFAB.value = true;
                        },
                        isHintText: false,
                        lengthLimiting: 250,
                        maxLines: 3,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                    SizedBox(height: 0.1 * Get.mediaQuery.size.height),
                  ],
                ),
              ),
            ),
            floatingActionButton: Obx(
              () => AnimatedSlide(
                offset:
                    addPetController.showFAB.value
                        ? Offset.zero
                        : const Offset(0, 1),
                duration: const Duration(milliseconds: 300),
                child: AnimatedOpacity(
                  opacity: addPetController.showFAB.value ? 1.0 : 0.0,
                  duration: const Duration(milliseconds: 300),
                  child: FocusScope(
                    canRequestFocus: false,
                    child: FloatingActionButton(
                      tooltip: 'Add Pet',
                      onPressed: () {
                        Get.focusScope!.unfocus();
                        if (addPetValidateController.validateForm()) {
                          addPetController.addPet();
                        }
                      },
                      child: const Icon(Icons.add),
                    ),
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
