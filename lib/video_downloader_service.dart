import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
//import 'package:video_player/video_player.dart';

class VideoDownloaderService extends GetxController {
  var thumbnail = "".obs;
  var downloadUrl = "".obs;
  var OriginalUrl = "".obs;
  var isLoading = false.obs;
  var isDownloading = false.obs;
  CancelToken? cancelToken;
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

  var originalUrl = ''.obs;
  var medias = <Map<String, dynamic>>[].obs; // hold qualities

  Future<void> videoDownloadApi(String videoLink) async {
    if (cancelToken != null && !cancelToken!.isCancelled) {
      cancelToken!.cancel("API called again — cancelling current download");
    }
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
          originalUrl.value = videoData['originalUrl'] ?? '';
          medias.value = List<Map<String, dynamic>>.from(
            videoData['medias'] ?? [],
          );

          /// Show popup after success
          // showQualityDialog();
        } else {
          Get.snackbar(
            titleText: Text(
              "Error",
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
            "Error",
            "Video not found or Url not correct",
          );
        }
      } else {
        final errorData = jsonDecode(response.body);
        Get.snackbar(
          titleText: Text(
            "Error",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 15,
            ),
          ),
          "Error",
          "Video not found or Url not correct",
        );
      }
    } catch (e) {
      Get.snackbar(
        titleText: Text(
          "Error",
          style: TextStyle(
            color: Colors.red,
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        "Error",
        "Video not found or Url not correct",
      );
    }
  }

  final selectedMedia = Rxn<Map<String, dynamic>>();
  void showQualityDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        backgroundColor: Colors.white,
        child: Obx(
          () => Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Title + Close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select Video Quality",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.close, color: Colors.grey[700]),
                      onPressed: () => Get.back(),
                    ),
                  ],
                ),
                const SizedBox(height: 12),

                // Scrollable list of qualities
                Flexible(
                  child: SizedBox(
                     // Constrain height to make list scrollable
                    child: ListView(
                      shrinkWrap: true,
                      children: medias
                          .map(
                            (m) => Container(
                              margin: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.grey.shade100,
                              ),
                              child: ListTile(
                                onTap: () => selectedMedia.value = m,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                leading: Text(
                                  "MP4",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                trailing: Text(
                                  m['label'] ?? "Unknown",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: selectedMedia.value == m
                                        ? Colors.purple
                                        : Colors.black,
                                  ),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // Download Button
                GestureDetector(
                  onTap: () {
                    if (selectedMedia.value != null) {
                      downloadDirectUrl(
                        selectedMedia.value!['url'],
                        selectedMedia.value!['label'],
                      );
                      Get.back();
                    } else {
                      Get.snackbar(
                        "Error",
                        "Please select a video quality first",
                      );
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      color: Color(0xff726DDE), // purple button
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        "Continue To Download",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
    );
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
      print("Download error:Failed ");
      Get.snackbar("Error", "Download failed ");
    }
  }

  Future<void> downloadDirectUrl(String videoUrl, String title) async {
    // 🧠 Step 1: Validate input first
    if (videoUrl.isEmpty || !videoUrl.startsWith('http')) {
      Get.snackbar("Error", "Video not available or invalid URL");
      return;
    }

    // 🧩 Step 2: Request permissions
    if (!await requestStoragePermission()) {
      Get.snackbar("Permission", "Storage permission denied");
      return;
    }

    try {
      // 🔄 Cancel previous download if running
      if (cancelToken != null && !cancelToken!.isCancelled) {
        cancelToken!.cancel("New download started");
      }

      isDownloading.value = true;
      cancelToken = CancelToken();

      // 📁 Step 3: Choose correct directory
      Directory? downloadsDir;

      if (Platform.isAndroid) {
        downloadsDir = await getExternalStorageDirectory(); // App-specific folder
      } else {
        downloadsDir = await getApplicationDocumentsDirectory();
      }

      if (downloadsDir == null) {
        Get.snackbar("Error", "Unable to access storage directory");
        return;
      }

      String sanitizedTitle = title.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
      String savePath = "${downloadsDir.path}/$sanitizedTitle.mp4";

      Dio dio = Dio();

      // 🧠 Step 4: Check if the URL actually exists (HEAD request)
      final headResponse = await dio.head(videoUrl).catchError((_) => null);
      if (headResponse == null || headResponse.statusCode != 200) {
        Get.snackbar("Error", "Video not available at this URL");
        return;
      }

      // 💾 Step 5: Start download
      await dio.download(
        videoUrl,
        savePath,
        cancelToken: cancelToken,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            progress.value = (received / total) * 100;
            print("Download Progress: ${progress.value.toStringAsFixed(0)}%");
          }
        },
      );

      // 🖼️ Step 6: Save to gallery
      final result = await ImageGallerySaverPlus.saveFile(
        savePath,
        name: sanitizedTitle,
      );

      print("Saved to Gallery: $result");
      Get.snackbar("Success", "Video downloaded successfully");
    } on DioException catch (e) {
      if (CancelToken.isCancel(e)) {
        print("Download cancelled: ${e.message}");
        Get.snackbar("Cancelled", "Download cancelled");
      } else {
        print("Download error: $e");
        Get.snackbar("Error", "Download failed or video not found");
      }
    } catch (e) {
      print("Direct download error: $e");
      Get.snackbar("Error", "Video not available or download failed");
    } finally {
      isDownloading.value = false;
    }
  }

  // Future<void> downloadDirectUrl(String videoUrl, String title) async {
  //   if (videoUrl.isEmpty) {
  //     Get.snackbar("Error", "Video URL not available");
  //     return;
  //   }
  //
  //   // 🔹 Request permissions
  //   if (!await requestStoragePermission()) {
  //     Get.snackbar("Permission", "Storage permission denied");
  //     return;
  //   }
  //
  //   try {
  //     // 🔹 Cancel previous download if any
  //     if (cancelToken != null && !cancelToken!.isCancelled) {
  //       cancelToken!.cancel("New download started");
  //     }
  //
  //     isDownloading.value = true;
  //     cancelToken = CancelToken();
  //
  //     // ✅ Use correct directory for Android 11+
  //     Directory? downloadsDir;
  //
  //     if (Platform.isAndroid) {
  //       downloadsDir = await getExternalStorageDirectory(); // app-specific folder
  //     } else {
  //       downloadsDir = await getApplicationDocumentsDirectory();
  //     }
  //
  //     if (downloadsDir == null) {
  //       Get.snackbar("Error", "Unable to access storage directory");
  //       return;
  //     }
  //
  //     String sanitizedTitle = title.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_');
  //     String savePath = "${downloadsDir.path}/$sanitizedTitle.mp4";
  //
  //     Dio dio = Dio();
  //
  //     await dio.download(
  //       videoUrl,
  //       savePath,
  //       cancelToken: cancelToken,
  //       onReceiveProgress: (received, total) {
  //         if (total != -1) {
  //           progress.value = (received / total) * 100;
  //           print("Download Progress: ${progress.value.toStringAsFixed(0)}%");
  //         }
  //       },
  //     );
  //
  //     // ✅ Make visible in Gallery
  //     final result = await ImageGallerySaverPlus.saveFile(
  //       savePath,
  //       name: sanitizedTitle,
  //     );
  //
  //     print("Saved to Gallery: $result");
  //     Get.snackbar("Success", "Video downloaded successfully");
  //   } on DioException catch (e) {
  //     if (CancelToken.isCancel(e)) {
  //       print("Download cancelled: ${e.message}");
  //       Get.snackbar("Cancelled", "Download cancelled");
  //     } else {
  //       print("Download error: $e");
  //       Get.snackbar("Error", "Download failed");
  //     }
  //   } catch (e) {
  //     print("Direct download error: $e");
  //     Get.snackbar("Error", "Direct download failed");
  //   } finally {
  //     isDownloading.value = false;
  //   }
  // }

  //
  // Future<void> downloadDirectUrl(String videoUrl, String title) async {
  //   if (videoUrl.isEmpty) {
  //     Get.snackbar("Error", "Video URL not available");
  //     return;
  //   }
  //
  //   if (!await requestStoragePermission()) {
  //     Get.snackbar("Permission", "Storage permission denied");
  //     return;
  //   }
  //
  //   try {
  //     // 🔹 Cancel any ongoing download before starting a new one
  //     if (cancelToken != null && !cancelToken!.isCancelled) {
  //       cancelToken!.cancel("New download started");
  //     }
  //
  //     isDownloading.value = true;
  //     cancelToken = CancelToken();
  //
  //     Directory downloadsDir = Directory("/storage/emulated/0/Download");
  //     if (!downloadsDir.existsSync()) {
  //       downloadsDir =
  //           await getExternalStorageDirectory() ??
  //           await getApplicationDocumentsDirectory();
  //     }
  //
  //     String savePath = "${downloadsDir.path}/$title.mp4";
  //
  //     Dio dio = Dio();
  //
  //     await dio.download(
  //       videoUrl,
  //       savePath,
  //       cancelToken: cancelToken, // ✅ attach token here
  //       onReceiveProgress: (received, total) {
  //         if (total != -1) {
  //           progress.value = (received / total) * 100;
  //           print("Download Progress: ${progress.value.toStringAsFixed(0)}%");
  //         }
  //       },
  //     );
  //
  //     final result = await ImageGallerySaverPlus.saveFile(
  //       savePath,
  //       name: title,
  //     );
  //
  //     print("Saved to Gallery: $result");
  //     Get.snackbar("Success", "Video downloaded successfully");
  //   } on DioException catch (e) {
  //     if (CancelToken.isCancel(e)) {
  //       print("Download cancelled: ${e.message}");
  //       Get.snackbar("Cancelled", "Download cancelled");
  //     } else {
  //       print("Download error: $e");
  //       Get.snackbar("Error", "Download failed:");
  //     }
  //   } catch (e) {
  //     print("Direct download error: $e");
  //     Get.snackbar("Error", "Direct download failed ");
  //   } finally {
  //     isDownloading.value = false;
  //   }
  // }

  @override
  void onClose() {
    // videoController.dispose();
    super.onClose();
  }
}
