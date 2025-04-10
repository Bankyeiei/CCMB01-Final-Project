import 'package:flutter/material.dart';

class AppBarActions {
  static List<Widget> profileAction(void Function() logoutFunction) {
    return [
      IconButton(
        onPressed: logoutFunction,
        tooltip: 'Logout',
        icon: const Icon(Icons.logout),
      ),
    ];
  }
}
