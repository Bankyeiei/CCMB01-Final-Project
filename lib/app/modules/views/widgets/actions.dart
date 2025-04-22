import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../routes/app_routes.dart';

class ViewAppBarActions {
  static List<Widget> petListAction() {
    return [
      IconButton(
        onPressed: () => Get.toNamed(Routes.addPet),
        tooltip: 'Add Pet',
        icon: const Icon(Icons.add),
      ),
    ];
  }

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
