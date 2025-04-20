import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/pet_model.dart';

class GenderDropdown extends StatelessWidget {
  final Rx<Gender> genderValue;
  const GenderDropdown({super.key, required this.genderValue});

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      canRequestFocus: false,
      child: DropdownSearch<Gender>(
        items: (f, cs) => Gender.values,
        selectedItem: genderValue.value,
        compareFn: (item1, item2) => item1 == item2,
        popupProps: PopupProps.menu(
          fit: FlexFit.loose,
          showSelectedItems: true,
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
        ),
        dropdownBuilder:
            (context, selectedItem) => Row(
              children: [
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
            labelText: 'Gender',
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16.5,
              vertical: 12,
            ),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(width: 1.5),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        onBeforePopupOpening: (selectedItem) async {
          Get.focusScope!.unfocus();
          return true;
        },
        onChanged: (value) => genderValue.value = value!,
      ),
    );
  }
}
