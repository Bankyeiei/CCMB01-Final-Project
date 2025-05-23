import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PetTypeDropDown extends StatelessWidget {
  final RxString typeValue;
  const PetTypeDropDown({super.key, required this.typeValue});

  @override
  Widget build(BuildContext context) {
    final List<String> petTypes = [
      'Dog',
      'Cat',
      'Bird',
      'Rabbit',
      'Horse',
      'Pig',
      'Mouse',
    ];

    List<String> mockPetType = List.from(petTypes);

    return DropdownSearch<String>(
      items: (f, cs) => mockPetType,
      selectedItem: typeValue.value,
      compareFn: (item1, item2) => item1 == item2,
      popupProps: PopupProps.menu(
        fit: FlexFit.loose,
        showSearchBox: true,
        showSelectedItems: true,
        searchDelay: const Duration(milliseconds: 500),
        onItemsLoaded: (value) => mockPetType = List.from(petTypes),
        itemBuilder:
            (context, item, isDisabled, isSelected) => Padding(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
              child: Text(item, style: Get.textTheme.bodyLarge),
            ),
        scrollbarProps: ScrollbarProps(
          thickness: 8,
          thumbVisibility: true,
          thumbColor: Get.theme.primaryColor,
        ),
        searchFieldProps: TextFieldProps(
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z]')),
            LengthLimitingTextInputFormatter(20),
          ],
          decoration: const InputDecoration(
            prefixIcon: Icon(Icons.search, size: 24),
            hintText: 'Type or select...',
          ),
          onChanged: (value) {
            mockPetType = List.from(petTypes);
            if (value.isNotEmpty && !(petTypes.contains(value.capitalize))) {
              mockPetType.add(value.capitalize!);
            }
          },
        ),
      ),
      dropdownBuilder:
          (context, selectedItem) =>
              Text(' ${selectedItem!}', style: Get.textTheme.bodyLarge),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          isDense: true,
          labelText: 'Pet Type',
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
      onChanged: (value) => typeValue.value = value!,
    );
  }
}
