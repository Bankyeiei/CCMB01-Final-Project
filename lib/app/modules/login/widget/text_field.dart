import 'package:flutter/material.dart';

class LoginTextField extends StatelessWidget {
  final String labelText;
  final String errorText;
  final IconData icon;
  final TextEditingController controller;
  final void Function(String) validate;
  const LoginTextField({
    super.key,
    required this.labelText,
    required this.errorText,
    required this.icon,
    required this.controller,
    required this.validate,
  });

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 80,
      child: Column(
        children: [
          TextField(
            controller: controller,
            onChanged: validate,
            decoration: InputDecoration(
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
              filled: true,
              fillColor: Theme.of(context).colorScheme.secondary,
              prefixIcon: Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Icon(icon),
              ),
              prefixIconColor: Colors.black26,
              hintText: labelText,
              hintStyle: Theme.of(
                context,
              ).textTheme.bodyLarge!.copyWith(color: Colors.black38),
              errorText: errorText.isEmpty ? null : errorText,
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
