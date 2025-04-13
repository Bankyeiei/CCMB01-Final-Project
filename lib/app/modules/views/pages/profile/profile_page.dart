import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../core/controller/user_controller.dart';

import 'widget/curved_bottom.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final UserController userController = Get.find<UserController>();

    return Column(
      children: [
        ClipPath(
          clipper: CurvedBottomClipper(),
          child: Obx(
            () => CachedNetworkImage(
              imageUrl: userController.user.imageUrl,
              height: 0.75 * Get.mediaQuery.size.width,
              width: Get.mediaQuery.size.width,
              fit: BoxFit.cover,
              errorWidget:
                  (context, url, error) => Container(
                    color: Get.theme.colorScheme.secondary,
                    child: Icon(
                      Icons.person,
                      color: Get.theme.colorScheme.onSecondary.withAlpha(127),
                      size: 256,
                    ),
                  ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        profileSection(userController),
        const SizedBox(height: 16),
        listTileSection(),
      ],
    );
  }

  Container profileSection(UserController userController) {
    return Container(
      height: 0.2 * Get.mediaQuery.size.height,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.secondary,
            blurRadius: 32,
            spreadRadius: -4,
          ),
        ],
        color: Get.theme.colorScheme.onPrimary,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Obx(
            () => Text(
              userController.user.name,
              style: Get.textTheme.headlineMedium,
            ),
          ),
          Row(
            children: [
              const SizedBox(width: 16),
              const Icon(Icons.email_outlined),
              const SizedBox(width: 20),
              Text(userController.user.email, style: Get.textTheme.titleSmall),
            ],
          ),
          Row(
            children: [
              const SizedBox(width: 16),
              const Icon(Icons.phone_outlined),
              const SizedBox(width: 20),
              Obx(
                () => Text(
                  userController.user.phone,
                  style: Get.textTheme.titleSmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Container listTileSection() {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Get.theme.colorScheme.secondary,
            blurRadius: 32,
            spreadRadius: -4,
          ),
        ],
        color: Get.theme.colorScheme.onPrimary,
      ),
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.settings),
            title: Text('Edit Profile', style: Get.textTheme.headlineSmall),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.toNamed('/edit_profile'),
          ),
          ListTile(
            leading: const Icon(Icons.pets_outlined),
            title: Text('App Pet', style: Get.textTheme.headlineSmall),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Get.toNamed('/add_pet'),
          ),
        ],
      ),
    );
  }
}
