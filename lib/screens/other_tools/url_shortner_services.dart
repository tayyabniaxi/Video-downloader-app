import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

class UrlShortenerController extends GetxController {
  final Dio _dio = Dio();

  var isLoading = false.obs;
  var shortUrl = "".obs;
  final shortUrlController = TextEditingController();

  /// Call API & update frontend state
  Future<void> shortenUrl(String longUrl) async {
    if (longUrl.isEmpty) {
      Get.snackbar("Error", "Please enter a URL");
      return;
    }

    try {
      isLoading.value = true;

      final response = await _dio.get(
        "https://tinyurl.com/api-create.php",
        queryParameters: {"url": longUrl},
      );

      if (response.statusCode == 200) {
        shortUrl.value = response.data.toString();
        shortUrlController.text=shortUrl.value;
      } else {
        Get.snackbar("Error", "Failed: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "Something went wrong: $e");
    } finally {
      isLoading.value = false;
    }
  }

  /// Copy to clipboard
  Future<void> copyUrl() async {
    if (shortUrl.value.isNotEmpty) {
      await Clipboard.setData(ClipboardData(text: shortUrl.value));
      Get.snackbar("Copied", "Short URL copied");
    }
  }
}
