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

  // Future<void> VideoDownloadApi(String videoLink) async {
  //   final url = Uri.parse('$baseUrl/api/video/universal');
  //   final payload = jsonEncode({"url": videoLink});
  //   final header = {"Content-Type": "application/json"};
  //
  //   try {
  //     final response = await http.post(url, body: payload, headers: header);
  //
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //
  //       if (responseData['success'] == true) {
  //         print("data::   $responseData");
  //         final videoData = responseData['data'] ?? {};
  //
  //         thumbnail.value = videoData['thumbnail'] ?? '';
  //         downloadUrl.value = videoData['url'] ?? '';
  //         OriginalUrl.value = videoData['originalUrl'] ?? '';
  //         print("data::   $videoData");
  //       } else {
  //         Get.snackbar(
  //           "Error",
  //           responseData['message'] ?? "Failed to process video",
  //         );
  //       }
  //     } else {
  //       final errorData = jsonDecode(response.body);
  //       Get.snackbar("Error", errorData['message'] ?? "Service unavailable");
  //     }
  //   } catch (e) {
  //     Get.snackbar("Error", "Network error occurred");
  //   }
  // }
  //

  var originalUrl = ''.obs;
  var medias = <Map<String, dynamic>>[].obs; // hold qualities

  Future<void> videoDownloadApi(String videoLink) async {
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
          // Get.snackbar(
          //   "Error",
          //   responseData['message'] ?? "Failed to process video",
          // );
        }
      } else {
        final errorData = jsonDecode(response.body);
       // Get.snackbar("Error", errorData['message'] ?? "Service unavailable");
      }
    } catch (e) {
    //  Get.snackbar("Error", "Network error occurred");
    }
  }
  final selectedMedia = Rxn<Map<String, dynamic>>();
  void showQualityDialog() {
    final selectedMedia = Rxn<Map<String, dynamic>>();

    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 24),
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

                // List of qualities
                ...medias.map(
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
                    //   Get.snackbar(
                    //       "Error", "Please select a video quality first");
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

//   void showQualityDialog() {
//
//     Get.dialog(
//       // Define a reactive variable to hold selected media
//
// // Dialog
//     AlertDialog(
//       backgroundColor: Colors.white,
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(16),
//       ),
//       title: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             "Select Video Quality",
//             style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
//           ),
//           IconButton(
//             icon: Icon(Icons.close, color: Colors.grey[700]),
//             onPressed: () => Get.back(),
//           ),
//         ],
//       ),
//       content: Obx(
//             () => Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             SizedBox(height: 5),
//             ...medias.map(
//                   (m) => Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child: GestureDetector(
//                   onTap: () {
//                     // set selected media
//                     selectedMedia.value = m;
//                   },
//                   child: Container(
//                     height: 50,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: selectedMedia.value == m
//                           ? Color(0xff726DDE).withOpacity(0.2) // highlight selected
//                           : Colors.grey.shade100,
//                     ),
//                     child: ListTile(
//                       title: Text(
//                         m['label'] ?? "Unknown",
//                         style: TextStyle(fontSize: 12),
//                       ),
//                       trailing: Icon(
//                         selectedMedia.value == m
//                             ? Icons.check_circle
//                             : Icons.download,
//                         color: selectedMedia.value == m
//                             ? Color(0xff726DDE)
//                             : Colors.grey,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 15),
//             Padding(
//               padding: const EdgeInsets.all(5.0),
//               child: GestureDetector(
//                 onTap: () {
//                   if (selectedMedia.value != null) {
//                     // download only selected media
//                     downloadDirectUrl(
//                       selectedMedia.value!['url'],
//                       selectedMedia.value!['label'],
//                     );
//                     Get.back();
//                   } else {
//                     Get.snackbar("Error", "Please select a quality first");
//                   }
//                 },
//                 child: Container(
//                   width: double.infinity,
//                   height: 45,
//                   decoration: BoxDecoration(
//                     color: Color(0xff726DDE),
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Center(
//                     child: Text(
//                       "Continue To Download",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     ),
//
//     // barrierDismissible: true,
//       barrierColor: Colors.black.withOpacity(0.4),
//       barrierDismissible: true,
//     );
//   }

  // void downloadDirectUrl(String url, String quality) {
  //   // your download implementation here
  //   Get.snackbar("Download", "Started downloading $quality");
  // }

  ////
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
   //   Get.snackbar("Error", "Direct download failed: $e");
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
