import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

class LoadingScreen extends StatelessWidget {
  final bool isTransparent;
  const LoadingScreen({super.key, this.isTransparent = true});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          dismissible: false,
          color: Get.theme.primaryColor.withAlpha(isTransparent ? 120 : 255),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gif(
                image: const AssetImage('assets/loading/dog.gif'),
                width: 0.5 * Get.size.width,
                autostart: Autostart.loop,
                duration: const Duration(seconds: 2),
              ),
              Gif(
                image: const AssetImage('assets/loading/loading.gif'),
                width: 0.75 * Get.size.width,
                autostart: Autostart.loop,
                duration: const Duration(seconds: 3),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class UnLoadingScreen extends StatelessWidget {
  const UnLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.shrink();
  }
}
