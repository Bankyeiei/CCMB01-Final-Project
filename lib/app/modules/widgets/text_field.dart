import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class AppTextField extends StatelessWidget {
  final IconData? icon;
  final String hintText;
  final String errorText;
  final TextEditingController controller;
  final void Function(String) validate;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onSubmitted;
  final bool obscureText;
  final bool isHintText;
  final int lengthLimiting;
  final bool isShowLength;
  final int maxLines;
  final TextInputAction textInputAction;
  const AppTextField({
    super.key,
    this.icon,
    required this.hintText,
    required this.errorText,
    required this.controller,
    required this.validate,
    this.keyboardType,
    this.inputFormatters,
    this.onSubmitted,
    this.obscureText = false,
    this.isHintText = true,
    this.lengthLimiting = 30,
    this.isShowLength = false,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
  });

  @override
  Widget build(BuildContext context) {
    final obscuredController = _ObscuredController();

    return SizedBox(
      height: 88 + 30 * (maxLines - 1),
      child: Obx(
        () => TextField(
          maxLength: isShowLength ? lengthLimiting : null,
          controller: controller,
          maxLines: maxLines,
          onChanged: (value) {
            validate(value);
            obscuredController.isObscured.value = true;
          },
          onSubmitted: onSubmitted,
          obscureText:
              obscureText
                  ? obscuredController.isObscured.value
                  : false.obs.value,
          inputFormatters:
              (inputFormatters ?? []) +
              (isShowLength
                  ? []
                  : [LengthLimitingTextInputFormatter(lengthLimiting)]),
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          decoration: InputDecoration(
            isDense: true,
            border: OutlineInputBorder(
              borderSide: const BorderSide(width: 2),
              borderRadius: BorderRadius.circular(8),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide(
                width: 1.5,
                color:
                    isHintText ? Get.theme.colorScheme.secondary : Colors.black,
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.5,
                color: Get.theme.colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            filled: true,
            fillColor: isHintText ? Get.theme.colorScheme.secondary : null,
            prefixIcon:
                icon != null
                    ? Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(
                        icon,
                        size: 24,
                        color: isHintText ? Colors.black26 : Colors.black54,
                      ),
                    )
                    : null,
            suffixIcon:
                obscureText
                    ? Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FocusScope(
                          canRequestFocus: false,
                          child: IconButton(
                            onPressed: () => obscuredController.click(),
                            icon: Icon(
                              obscuredController.isObscured.value
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 24,
                              color: Colors.black26,
                            ),
                          ),
                        ),
                        const SizedBox(width: 4),
                      ],
                    )
                    : null,
            labelText: isHintText ? null : hintText,
            hintText: isHintText ? hintText : null,
            hintStyle: Get.textTheme.bodyLarge!.copyWith(color: Colors.black38),
            errorText: errorText.isEmpty ? null : errorText,
          ),
        ),
      ),
    );
  }
}

class _ObscuredController extends GetxController {
  final RxBool isObscured = true.obs;

  void click() {
    isObscured.value = !isObscured.value;
  }
}
