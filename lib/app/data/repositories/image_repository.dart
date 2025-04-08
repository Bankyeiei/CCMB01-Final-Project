import 'dart:io';

import 'package:dio/dio.dart';

import '../providers/image_provider.dart';
import '../../../core/constant/image_api.dart';

class ImageRepository {
  final ImageProvider imageProvider;
  ImageRepository({required this.imageProvider});

  Future<File?> pickAndGetFileImage() async {
    final pickedFile = await imageProvider.pickImage();
    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  }

  Future<String?> uploadAndGetImageUrl(File file) async {
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
      'upload_preset': ImageApi.presetName,
    });
    try {
      final response = await imageProvider.uploadImage(formData);
      if (response.statusCode == 200) {
        final imageUrl = response.data["secure_url"];
        return imageUrl;
      }
      throw response.statusMessage.toString();
    } catch (error) {
      throw error.toString();
    }
  }
}
