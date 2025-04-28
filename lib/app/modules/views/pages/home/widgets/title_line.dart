import 'package:flutter/material.dart';

class TitleLine extends StatelessWidget {
  final IconData icon;
  final String text;
  const TitleLine({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 36),
        const SizedBox(width: 8),
        Expanded(
          child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
        ),
      ],
    );
  }
}
