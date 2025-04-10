import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final void Function(String) validate;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputAction textInputAction;
  AppTextField({
    super.key,
    required this.icon,
    required this.hintText,
    required this.errorText,
    required this.controller,
    required this.validate,
    this.obscureText,
    this.keyboardType,
    this.inputFormatters,
    this.textInputAction = TextInputAction.next,
  });

  final _obscuredController = _ObscuredController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: Column(
        children: [
          Obx(
            () => TextField(
              controller: controller,
              onChanged: validate,
              obscureText:
                  obscureText ?? false
                      ? _obscuredController.isObscured.value
                      : false.obs.value,
              inputFormatters:
                  (inputFormatters ?? []) +
                  [LengthLimitingTextInputFormatter(30)],
              keyboardType: keyboardType,
              textInputAction: textInputAction,
              decoration: InputDecoration(
                isDense: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(
                    color: Get.theme.colorScheme.secondary,
                  ),
                ),
                filled: true,
                fillColor: Get.theme.colorScheme.secondary,
                prefixIcon: Padding(
                  padding: const EdgeInsets.only(left: 8),
                  child: Icon(icon, size: 24, color: Colors.black26),
                ),
                suffixIcon:
                    obscureText ?? false
                        ? Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: _obscuredController.click,
                              icon: Icon(
                                _obscuredController.isObscured.value
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                size: 24,
                                color: Colors.black26,
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        )
                        : null,
                hintText: hintText,
                hintStyle: Get.theme.textTheme.bodyLarge!.copyWith(
                  color: Colors.black38,
                ),
                errorText: errorText.isEmpty ? null : errorText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ObscuredController extends GetxController {
  RxBool isObscured = true.obs;

  void click() {
    isObscured.value = !isObscured.value;
  }
}
