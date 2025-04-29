import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../app/modules/widgets/loading.dart';

class LoadingController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxBool shouldShow = false.obs;

  Widget loadingScreen() {
    if (isLoading.value) {
      return const LoadingScreen();
    }
    return const UnLoadingScreen();
  }

  Widget fadeLoadingScreen(String routes) {
    if (isLoading.value && Get.currentRoute == routes) {
      shouldShow.value = true;
    }

    if (!shouldShow.value) {
      return const UnLoadingScreen();
    }
    return AnimatedOpacity(
      opacity: isLoading.value ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 1600),
      curve: Curves.easeIn,
      onEnd: () {
        if (!isLoading.value) {
          shouldShow.value = false;
        }
      },
      child: const LoadingScreen(isTransparent: false),
    );
  }
}
