import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  const AppButton({super.key, this.onPressed, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45,
      margin: const EdgeInsets.symmetric(horizontal: 14),
      child: ElevatedButton(onPressed: onPressed, child: child),
    );
  }
}
