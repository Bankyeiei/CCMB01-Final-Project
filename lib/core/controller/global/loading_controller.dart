import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../app/modules/widgets/loading.dart';

class LoadingController extends GetxController {
  final RxBool isLoading = false.obs;

  Widget loadingScreen() {
    if (isLoading.value) {
      return const LoadingScreen();
    }
    return const UnLoadingScreen();
  }
}
