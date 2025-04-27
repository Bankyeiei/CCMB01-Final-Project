import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/controller/journal_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final JournalController journalController = Get.find<JournalController>();

    return const Center(child: Text('Home'));
  }
}
