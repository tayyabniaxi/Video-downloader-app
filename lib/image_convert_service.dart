import 'dart:io';
import 'package:dio/dio.dart';

class ImageConvertService {
  final Dio _dio = Dio();
  final String baseUrl = "https://api.anyvideodownloader.net/api/image/convert";

  /// Upload image and convert
  Future<Response?> convertImage({
    required File imageFile,
    required String format, // e.g. "ico", "png", "webp"
    double quality = 0.9,
  }) async {
    try {
      String fileName = imageFile.path.split('/').last;

      FormData formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(
          imageFile.path,
          filename: fileName,
        ),
        "format": format,
        "quality": quality,
      });

      Response response = await _dio.post(
        baseUrl,
        data: formData,
        options: Options(
          headers: {"Content-Type": "multipart/form-data"},
        ),
      );
      print(response);
      return response;

    } catch (e) {
      print("❌ Error uploading image: $e");
      return null;
    }
  }
}



