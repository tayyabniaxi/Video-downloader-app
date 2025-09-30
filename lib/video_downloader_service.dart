import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:video_player/video_player.dart';

class VideoDownloaderService extends GetxController {
  var thumbnail = "".obs;
  var downloadUrl = "".obs;
  var OriginalUrl = "".obs;
  var isLoading = false.obs;
  var isDownloading = false.obs;
  var progress = 0.0.obs; // 👈 progress store karega

  final baseUrl = dotenv.env['API_BASE_URL'] ?? "";

  Future<bool> requestStoragePermission() async {
    if (Platform.isAndroid) {
      if (await Permission.storage.isGranted) return true;
      if (await Permission.storage.request().isGranted) return true;

      // Android 13+
      if (await Permission.videos.request().isGranted) return true;
      if (await Permission.photos.request().isGranted) return true;
    }
    return false;
  }

  Future<void> VideoDownloadApi(String videoLink) async {
    final url = Uri.parse('$baseUrl/api/video/universal');
    final payload = jsonEncode({"url": videoLink});
    final header = {"Content-Type": "application/json"};

    try {
      final response = await http.post(url, body: payload, headers: header);

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData['success'] == true) {
          final videoData = responseData['data'] ?? {};

          thumbnail.value = videoData['thumbnail'] ?? '';
          downloadUrl.value = videoData['url'] ?? '';
          OriginalUrl.value = videoData['originalUrl'] ?? '';

        } else {
          Get.snackbar(
            "Error",
            responseData['message'] ?? "Failed to process video",
          );
        }
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar("Error", errorData['message'] ?? "Service unavailable");
      }
    } catch (e) {
      Get.snackbar("Error", "Network error occurred");
    }
  }

  Future<void> downloadVideo(String url, String title) async {
    if (!await requestStoragePermission()) {
      Get.snackbar("Permission", "Storage permission denied");
      return;
    }

    try {
      Directory downloadsDir = Directory("/storage/emulated/0/Download");
      if (!downloadsDir.existsSync()) {
        downloadsDir =
            await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
      }

      String savePath = "${downloadsDir.path}/$title.mp4";

      await Dio().download(url, savePath);
      print("Downloaded to: $savePath");

      final result = await ImageGallerySaverPlus.saveFile(
        savePath,
        name: title,
      );
      print("Saved to Gallery: $result");

      Get.snackbar("Success", "Video saved to Gallery");
    } catch (e) {
      print("Download error: $e");
      Get.snackbar("Error", "Download failed: $e");
    }
  }

  Future<void> downloadDirectUrl(String videoUrl, String title) async {
    if (videoUrl.isEmpty) {
      Get.snackbar("Error", "Video URL not available");
      return;
    }

    if (!await requestStoragePermission()) {
      Get.snackbar("Permission", "Storage permission denied");
      return;
    }

    try {
      isDownloading.value = true;

      Directory downloadsDir = Directory("/storage/emulated/0/Download");
      if (!downloadsDir.existsSync()) {
        downloadsDir =
            await getExternalStorageDirectory() ??
            await getApplicationDocumentsDirectory();
      }

      String savePath = "${downloadsDir.path}/$title.mp4";

      Dio dio = Dio();

      await dio.download(
        videoUrl,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            progress.value = (received / total) * 100;
            //double progress = (received / total * 100);
            print("Download Progress: $progress%");
          }
        },
      );

      final result = await ImageGallerySaverPlus.saveFile(
        savePath,
        name: title,
      );
      print("Saved to Gallery: $result");

      Get.snackbar("Success", "Video downloaded successfully");
    } catch (e) {
      print("Direct download error: $e");
      Get.snackbar("Error", "Direct download failed: $e");
    } finally {
      isDownloading.value = false;
    }
  }

  late VideoPlayerController videoController;
  RxBool isVideoInitialized = false.obs;

  void initVideo(String url) {
    videoController = VideoPlayerController.networkUrl(Uri.parse(url))
      ..initialize().then((_) {
        isVideoInitialized.value = true;
        update();
      });
  }

  @override
  void onClose() {
    videoController.dispose();
    super.onClose();
  }
}
