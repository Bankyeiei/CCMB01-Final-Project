import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewAppBarActions {
  static List<Widget> petListAction() {
    return [
      IconButton(
        onPressed: () => Get.toNamed('/add_pet'),
        tooltip: 'Add Pet',
        icon: const Icon(Icons.add),
      ),
      const SizedBox(width: 10),
    ];
  }

  static List<Widget> profileAction(void Function() logoutFunction) {
    return [
      IconButton(
        onPressed: logoutFunction,
        tooltip: 'Logout',
        icon: const Icon(Icons.logout),
      ),
      const SizedBox(width: 10),
    ];
  }
}
