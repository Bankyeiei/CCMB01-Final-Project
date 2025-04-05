import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;
  final Widget child;
  const LoginButton({super.key, required this.onPressed, required this.child});

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
