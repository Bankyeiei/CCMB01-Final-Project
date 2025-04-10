import 'dart:io';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../providers/image_provider.dart';
import '../../../core/constant/image_api.dart';

class ImageRepository {
  final ImageProvider imageProvider;
  ImageRepository({required this.imageProvider});

  Future<File?> pickAndGetImageFile(bool isCamera) async {
    XFile? pickedFile;
    if (isCamera) {
      pickedFile = await imageProvider.takePhoto();
    } else {
      pickedFile = await imageProvider.pickImage();
    }
    if (pickedFile == null) {
      return null;
    }
    return File(pickedFile.path);
  }

  Future<List<String>?> uploadAndGetImageUrlAndId(File file) async {
    final fileName = file.path.split('/').last;
    final formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(file.path, filename: fileName),
      'upload_preset': ImageApi.presetName,
    });
    try {
      final response = await imageProvider.uploadImage(formData);
      if (response.statusCode == 200) {
        return [response.data['secure_url'], response.data['public_id']];
      }
      throw response.statusMessage.toString();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> deleteImage(String imageId) async {
    final timestamp = DateTime.now().microsecondsSinceEpoch ~/ 1000;
    final signatureRaw =
        'public_id=$imageId&timestamp=$timestamp${ImageApi.apiSecret}';
    final signature = sha1.convert(utf8.encode(signatureRaw)).toString();
    final data = {
      'public_id': imageId,
      'api_key': ImageApi.apiKey,
      'timestamp': timestamp.toString(),
      'signature': signature,
    };
    try {
      final response = await imageProvider.deleteImage(data);
      if (response.statusCode == 200) {
        return;
      }
      throw response.statusMessage.toString();
    } catch (error) {
      rethrow;
    }
  }
}
