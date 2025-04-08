import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../core/constant/image_api.dart';

class ImageProvider {
  Future<XFile?> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<Response> uploadImage(FormData formData) async {
    final dio = Dio();
    final response = await dio.post(ImageApi.postUrl, data: formData);
    return response;
  }
}
