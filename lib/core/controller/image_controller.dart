import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../app/data/repositories/image_repository.dart';

class ImageController extends GetxController {
  final ImageRepository imageRepository;
  ImageController({required this.imageRepository});

  final Rx<File?> imageFile = Rx<File?>(null);
  final RxString imageUrl = ''.obs;
  
  String imageId = '';

  Future<void> _pickImage([bool isCamera = false]) async {
    final file = await imageRepository.pickAndGetImageFile(isCamera);
    if (file != null) {
      imageFile.value = file;
    }
  }

  Future<List<String>?> uploadAndGetImageUrlAndId() async {
    try {
      if (imageFile.value != null) {
        if (imageId.isNotEmpty) {
          await imageRepository.deleteImage(imageId);
        }
        return await imageRepository.uploadAndGetImageUrlAndId(
          imageFile.value!,
        );
      } else {
        if (imageUrl.value.isEmpty && imageId.isNotEmpty) {
          await imageRepository.deleteImage(imageId);
          return null;
        }
        return [imageUrl.value, imageId];
      }
    } catch (error) {
      rethrow;
    }
  }

  void pickImageBottomSheet() {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(16),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Choose an option', style: TextStyle(fontSize: 18)),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                await _pickImage();
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera),
              title: const Text('Camera'),
              onTap: () async {
                await _pickImage(true);
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
