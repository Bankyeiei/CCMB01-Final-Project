import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/add_pet_controller.dart';
import '../../../data/models/pet_model.dart';

class GenderDropdown extends StatelessWidget {
  const GenderDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final AddPetController addPetController = Get.find<AddPetController>();

    final List<Gender> genderOptions = [
      Gender.none,
      Gender.male,
      Gender.female,
    ];

    return FocusScope(
      canRequestFocus: false,
      child: DropdownSearch<Gender>(
        items: (f, cs) => genderOptions,
        selectedItem: addPetController.gender,
        compareFn: (item1, item2) => item1.text == item2.text,
        popupProps: PopupProps.menu(
          itemBuilder:
              (context, item, isDisabled, isSelected) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 12,
                  horizontal: 24,
                ),
                child: Text(
                  item.text,
                  style: Get.textTheme.bodyLarge!.copyWith(color: item.color),
                ),
              ),
          fit: FlexFit.loose,
        ),
        dropdownBuilder:
            (context, selectedItem) => Row(
              children: [
                const SizedBox(width: 4),
                Icon(selectedItem!.icon, size: 24, color: selectedItem.color),
                const SizedBox(width: 6),
                Text(
                  ' ${selectedItem.text}',
                  style: Get.textTheme.bodyLarge!.copyWith(
                    color: selectedItem.color,
                  ),
                ),
              ],
            ),
        decoratorProps: DropDownDecoratorProps(
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
            labelText: 'Gender',
          ),
        ),
        onChanged: (value) {
          Get.focusScope!.unfocus();
          addPetController.gender = value!;
        },
      ),
    );
  }
}
