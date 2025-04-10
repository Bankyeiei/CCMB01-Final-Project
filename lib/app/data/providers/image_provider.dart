import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constant/image_api.dart';

class ImageProvider {
  final dio = Dio();

  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<XFile?> takePhoto() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    return pickedFile;
  }

  Future<Response> uploadImage(FormData formData) async {
    final response = await dio.post(ImageApi.uploadUrl, data: formData);
    return response;
  }

  Future<Response> deleteImage(Map<String, dynamic> formData) async {
    final response = await dio.post(ImageApi.deleteUrl, data: formData);
    return response;
  }
}
