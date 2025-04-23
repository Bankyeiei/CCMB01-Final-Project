import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HoldButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final Duration fillDuration;
  final Color startColor;
  final Color endColor;
  const HoldButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.fillDuration,
    required this.startColor,
    required this.endColor,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put<_HoldButtonController>(
      _HoldButtonController(
        fillDuration: fillDuration,
        startColor: startColor,
        endColor: endColor,
      ),
    );

    return GestureDetector(
      onTapDown: (_) => controller.startHold(),
      onTapUp: (_) => controller.reset(),
      onTapCancel: () => controller.cancelHold(),
      child: Obx(() {
        final progress = controller.progress.value;
        final isEnabled = controller.isEnabled.value;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14),
          child: SizedBox(
            height: 45,
            width: double.infinity,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Get.theme.colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.08 + (progress * 0.92),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.lerp(startColor, endColor, progress),
                      ),
                    ),
                  ),
                ),
                SizedBox.expand(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shadowColor: Colors.transparent,
                      backgroundColor: Colors.transparent,
                    ),
                    onPressed: isEnabled ? onPressed : null,
                    child: Text(label),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

class _HoldButtonController extends GetxController
    with GetTickerProviderStateMixin {
  final Duration fillDuration;
  final Color startColor;
  final Color endColor;
  _HoldButtonController({
    required this.fillDuration,
    required this.startColor,
    required this.endColor,
  });

  late AnimationController animationController;
  final RxBool isEnabled = false.obs;
  final RxDouble progress = 0.0.obs;

  @override
  void onInit() {
    super.onInit();
    animationController = AnimationController(
      vsync: this,
      duration: fillDuration,
    );

    animationController.addListener(
      () => progress.value = animationController.value,
    );

    animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        isEnabled.value = true;
      }
    });
  }

  void startHold() {
    if (!isEnabled.value) animationController.forward();
  }

  void cancelHold() {
    if (!isEnabled.value) animationController.reverse();
  }

  void reset() {
    if (!isEnabled.value) animationController.reset();
  }

  @override
  void onClose() {
    animationController.dispose();
    super.onClose();
  }
}
