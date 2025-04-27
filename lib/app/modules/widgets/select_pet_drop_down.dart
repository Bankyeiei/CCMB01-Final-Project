import 'package:cached_network_image/cached_network_image.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../data/models/pet_model.dart';
import '../../../core/controller/pet_controller.dart';

class SelectPetDropDown extends StatelessWidget {
  final RxList<Pet> petListValue;
  final RxString errorText;
  const SelectPetDropDown({
    super.key,
    required this.petListValue,
    required this.errorText,
  });

  @override
  Widget build(BuildContext context) {
    final PetController petController = Get.find<PetController>();

    return FocusScope(
      canRequestFocus: false,
      child: Obx(
        () => DropdownSearch<Pet>.multiSelection(
          items: (f, cs) => petController.petMap.values.toList(),
          itemAsString: (item) => item.petName + item.petType + item.breedName,
          selectedItems: petListValue,
          compareFn: (item1, item2) => item1 == item2,
          popupProps: PopupPropsMultiSelection.dialog(
            fit: FlexFit.loose,
            showSearchBox: true,
            showSelectedItems: true,
            searchDelay: const Duration(milliseconds: 500),
            itemBuilder:
                (context, item, isDisabled, isSelected) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  child: Row(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: item.imageUrl,
                          fit: BoxFit.cover,
                          height: 100,
                          width: 100,
                          errorWidget:
                              (context, url, error) => Container(
                                color: Get.theme.colorScheme.secondary,
                                child: Icon(
                                  Icons.pets,
                                  color: Get.theme.colorScheme.onSecondary
                                      .withAlpha(127),
                                  size: 36,
                                ),
                              ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.petName,
                              style: Get.textTheme.bodyLarge,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              item.petType,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              item.breedName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
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
                FilteringTextInputFormatter.allow(RegExp(r'[A-Za-z0-9. ]')),
                LengthLimitingTextInputFormatter(30),
              ],
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search, size: 24),
                hintText: 'Type Pet Name...',
              ),
            ),
          ),
          dropdownBuilder:
              petListValue.isEmpty
                  ? null
                  : (context, selectedItems) => Column(
                    children:
                        selectedItems
                            .map(
                              (item) => Padding(
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  children: [
                                    Container(
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl: item.imageUrl,
                                        fit: BoxFit.cover,
                                        height: 80,
                                        width: 80,
                                        errorWidget:
                                            (context, url, error) => Container(
                                              color:
                                                  Get
                                                      .theme
                                                      .colorScheme
                                                      .secondary,
                                              child: Icon(
                                                Icons.pets,
                                                color: Get
                                                    .theme
                                                    .colorScheme
                                                    .onSecondary
                                                    .withAlpha(127),
                                                size: 30,
                                              ),
                                            ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.petName,
                                            style: Get.textTheme.bodyLarge,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(item.petType),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                  ),
          decoratorProps: DropDownDecoratorProps(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Pet',
              labelStyle: Get.textTheme.bodyLarge!.copyWith(
                color:
                    errorText.isNotEmpty
                        ? Get.theme.colorScheme.error
                        : Colors.black,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16,
                vertical: petListValue.isEmpty ? 27.1 : 10,
              ),
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      errorText.isNotEmpty
                          ? Get.theme.colorScheme.error
                          : Colors.black,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color:
                      errorText.isNotEmpty
                          ? Get.theme.colorScheme.error
                          : Colors.black,
                  width: 1.5,
                ),
                borderRadius: BorderRadius.circular(8),
              ),
              prefixIcon:
                  petListValue.isNotEmpty
                      ? null
                      : const Padding(
                        padding: EdgeInsets.only(left: 8),
                        child: Icon(
                          Icons.pets,
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
          onChanged: (value) => petListValue.assignAll(value),
        ),
      ),
    );
  }
}
