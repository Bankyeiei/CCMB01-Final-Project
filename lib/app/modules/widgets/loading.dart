import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gif/gif.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ModalBarrier(
          dismissible: false,
          color: Get.theme.colorScheme.onPrimary.withAlpha(160),
        ),
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Gif(
              //   image: const NetworkImage(
              //     'https://media.tenor.com/0Q5IZ6e9pC8AAAAM/cat-cute-cat.gif',
              //   ),
              // ),
              Gif(
                image: const AssetImage('assets/loading/dog.gif'),
                width: 0.5 * Get.mediaQuery.size.width,
                autostart: Autostart.loop,
                duration: const Duration(seconds: 2),
              ),
              Gif(
                image: const AssetImage('assets/loading/loading.gif'),
                width: 0.75 * Get.mediaQuery.size.width,
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
