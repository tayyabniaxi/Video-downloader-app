import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class VideoDownloaderService extends GetxController {
  var thumbnail = "".obs;
  var downloadUrl = "".obs;
  var isLoading = false.obs;
  var isDownloading = false.obs;
  final baseUrl = dotenv.env['API_BASE_URL'] ?? "";

  Future<void> VideoDownloadApi(String videoLink) async {
    final url = Uri.parse(baseUrl);
    print(baseUrl);
    final payload = jsonEncode({"url": videoLink});
    final header = {"Content-Type": "application/json"};

    try {
      final response = await http.post(url, body: payload, headers: header);
      if (response.statusCode == 200) {
        print("Succes fully download");
        // Get.snackbar(
        //   "Success",
        //   " Download ready:",
        //   backgroundColor: Colors.green.withOpacity(0.7),
        //   colorText: Colors.white,
        // );

        // final data = jsonDecode(response.body);
        final responseData = jsonDecode(response.body);

        // Nested object "data"
        final videoData = responseData['data'] ?? {};

        final title = videoData['title'] ?? 'Unknown';
        final duration = videoData['duration'] ?? 0;
        thumbnail.value = videoData['thumbnail'] ?? '';
        final uploader = videoData['uploader'] ?? 'Unknown';
        downloadUrl.value = videoData['url'] ?? '';

        print("🎬 Title: $title");
        print("⏱ Duration: $duration");
        print("👤 Uploader: $uploader");
        print("🖼 Thumbnail: $thumbnail");
        print("🔗 Download URL: $downloadUrl");
      } else {
        print("Failed ${response.statusCode}-- ${response.body}");
        // Get.snackbar(
        //   backgroundColor: Colors.red.withOpacity(0.7),
        //   colorText: Colors.white,
        //   "Error",
        //   "⚠️Service temporarily unavailable. Please try again later.",
        // );
      }
    } catch (e) {
      print("⚠️ Error: $e");
    }
  }

  // ye function video download karega

  Future<void> downloadVideo(String url, String title) async {
    try {
      isDownloading.value = true; // start download

      Directory appDocDir = await getApplicationDocumentsDirectory();
      String savePath = "${appDocDir.path}/$title.mp4";

      Dio dio = Dio();

      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            print(
              "Downloading: ${(received / total * 100).toStringAsFixed(0)}%",
            );
          }
        },
      );

      print("✅ Downloaded to: $savePath");
      Get.snackbar("Download Complete", "Saved at $savePath");
    } catch (e) {
      print("⚠️ Download Error: $e");
      Get.snackbar("Error", "Failed to download video");
    } finally {
      isDownloading.value = false; // end download
    }
  }
}
