import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../../data/models/pet_model.dart';

class PetColorDropDown extends StatelessWidget {
  final RxList<PetColor> petColorValue;
  const PetColorDropDown({super.key, required this.petColorValue});

  @override
  Widget build(BuildContext context) {
    late Map<String, bool> isColorSelected;
    late int numberOfColorSelected;

    return FocusScope(
      canRequestFocus: false,
      child: Obx(
        () => DropdownSearch<PetColor>.multiSelection(
          items: (f, cs) => PetColor.values,
          itemAsString: (item) => item.text,
          selectedItems: petColorValue,
          compareFn: (item1, item2) => item1 == item2,
          popupProps: PopupPropsMultiSelection.dialog(
            fit: FlexFit.loose,
            showSearchBox: true,
            showSelectedItems: true,
            searchDelay: const Duration(milliseconds: 500),
            onItemsLoaded: (value) {
              isColorSelected = {
                for (var petColor in PetColor.values)
                  petColor.text: petColorValue.contains(petColor),
              };
              numberOfColorSelected =
                  isColorSelected.values.where((value) => value).length;
            },
            disabledItemFn:
                (item) =>
                    !isColorSelected[item.text]! && numberOfColorSelected >= 3,
            onItemAdded: (selectedItems, addedItem) {
              isColorSelected[addedItem.text] = true;
              numberOfColorSelected = selectedItems.length;
            },
            onItemRemoved: (selectedItems, removedItem) {
              isColorSelected[removedItem.text] = false;
              numberOfColorSelected = selectedItems.length;
            },
            itemBuilder:
                (context, item, isDisabled, isSelected) => Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                    horizontal: 24,
                  ),
                  child: Row(
                    children: [
                      Container(
                        height: 32,
                        width: 32,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Get.theme.colorScheme.secondary,
                          ),
                          color: item.color,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Opacity(
                        opacity: isDisabled ? 0.4 : 1,
                        child: Text(item.text, style: Get.textTheme.bodyLarge),
                      ),
                    ],
                  ),
                ),
            scrollbarProps: ScrollbarProps(
              thickness: 8,
              thumbVisibility: true,
              thumbColor: Get.theme.primaryColor,
            ),
            searchFieldProps: TextFieldProps(
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z ]')),
                LengthLimitingTextInputFormatter(20),
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, size: 24),
                hintText: 'Type Color...',
              ),
            ),
          ),
          dropdownBuilder:
              petColorValue.isEmpty
                  ? null
                  : (context, selectedItems) => Wrap(
                    spacing: 8,
                    runSpacing: 2,
                    children:
                        selectedItems
                            .map(
                              (item) => Chip(
                                avatar: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Get.theme.colorScheme.secondary,
                                    ),
                                    color: item.color,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                label: Text(
                                  item.text,
                                  style: Get.textTheme.bodyMedium,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  side: const BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                elevation: 2,
                                shadowColor: Get.theme.colorScheme.secondary,
                                deleteIcon: const Icon(Icons.clear, size: 18),
                                onDeleted: () {
                                  petColorValue.remove(item);
                                  selectedItems.remove(item);
                                  numberOfColorSelected = selectedItems.length;
                                  petColorValue.refresh();
                                },
                              ),
                            )
                            .toList(),
                  ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Color',
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: petColorValue.isEmpty ? 27.1 : 8,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1.5),
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon:
                  petColorValue.isNotEmpty
                      ? null
                      : const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.color_lens_outlined,
                          size: 24,
                          color: Colors.black54,
                        ),
                      ),
            ),
          ),
          onBeforePopupOpening: (selectedItem) async {
            Get.focusScope!.unfocus();
            return true;
          },
          onChanged: (value) => petColorValue.assignAll(value),
        ),
      ),
    );
  }
}
