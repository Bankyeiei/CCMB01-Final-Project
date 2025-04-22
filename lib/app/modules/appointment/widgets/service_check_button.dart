import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ServiceCheckButton extends StatelessWidget {
  final String label;
  final RxString serviceValue;
  const ServiceCheckButton({
    super.key,
    required this.label,
    required this.serviceValue,
  });

  @override
  Widget build(BuildContext context) {
    final Color defaultColor = Get.theme.colorScheme.onPrimary;
    final Color selectedColor = Get.theme.primaryColor;

    return Obx(() {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () => serviceValue.value = label,
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color: serviceValue.value == label ? selectedColor : defaultColor,
              border:
                  serviceValue.value == label
                      ? null
                      : Border.all(color: Get.theme.primaryColor, width: 2),
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  offset: const Offset(0, 5),
                  blurRadius: 12,
                  color: Get.theme.colorScheme.secondary,
                  spreadRadius: -5,
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: serviceValue.value == label ? 16 : 14,
                      ),
                      child: Text(
                        label,
                        style: Get.textTheme.bodyLarge!.copyWith(
                          color:
                              serviceValue.value == label
                                  ? Get.theme.colorScheme.onPrimary
                                  : Colors.black,
                          fontWeight:
                              serviceValue.value == label
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                  if (serviceValue.value == label)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: context.height * .05,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topRight: const Radius.circular(8),
                            bottomLeft: Radius.circular(context.height * .014),
                          ),
                          color: Get.theme.colorScheme.onSecondary.withAlpha(
                            100,
                          ),
                        ),
                        child: const Icon(
                          Icons.check,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
