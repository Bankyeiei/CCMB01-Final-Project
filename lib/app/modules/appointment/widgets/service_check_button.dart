import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/models/appointment_model.dart';

class ServiceCheckButton extends StatelessWidget {
  final String label;
  final Rx<Service> serviceValue;
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
          onTap:
              () =>
                  serviceValue.value = Service.values.firstWhere(
                    (service) => service.text == label,
                  ),
          child: Container(
            width: 200,
            height: 50,
            decoration: BoxDecoration(
              color:
                  serviceValue.value.text == label
                      ? selectedColor
                      : defaultColor,
              border:
                  serviceValue.value.text == label
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
                        left: serviceValue.value.text == label ? 16 : 14,
                      ),
                      child: Row(
                        children: [
                          if (serviceValue.value.text == label)
                            Icon(serviceValue.value.icon, size: 28),
                          const SizedBox(width: 8),
                          Text(
                            label,
                            style: Get.textTheme.bodyLarge!.copyWith(
                              color:
                                  serviceValue.value.text == label
                                      ? Get.theme.colorScheme.onPrimary
                                      : Colors.black,
                              fontWeight:
                                  serviceValue.value.text == label
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  if (serviceValue.value.text == label)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: context.height * .04,
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
