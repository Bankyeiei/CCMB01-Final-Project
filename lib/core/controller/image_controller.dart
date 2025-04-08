import 'dart:io';

import 'package:get/get.dart';

import '../../app/data/repositories/image_repository.dart';

class ImageController extends GetxController {
  final ImageRepository imageRepository;
  ImageController({required this.imageRepository});

  Rx<File?> imageFile = Rx<File?>(null);

  Future<void> pickImage() async {
    final file = await imageRepository.pickAndGetFileImage();
    if (file != null) {
      imageFile.value = file;
    }
  }

  Future<String?> uploadAndGetImageUrl() async {
    try {
      if (imageFile.value != null) {
        final imageUrl = await imageRepository.uploadAndGetImageUrl(
          imageFile.value!,
        );
        return imageUrl;
      }
      return null;
    } catch (error) {
      throw error.toString();
    }
  }
}
