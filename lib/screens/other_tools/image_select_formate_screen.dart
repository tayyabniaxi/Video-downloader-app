import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart' as p; // 👈 add this import

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:qaisar/image_conversion.dart';

import '../../image_convert_service.dart';

class ImageSelectFormateScreen extends StatefulWidget {
  const ImageSelectFormateScreen({super.key});

  @override
  State<ImageSelectFormateScreen> createState() =>
      _ImageSelectFormateScreenState();
}

class _ImageSelectFormateScreenState extends State<ImageSelectFormateScreen> {
  final ImageService imageService = Get.put(ImageService());
  final ImageConvertService convertService = ImageConvertService();

  String? selectedValue;
  final Map<String, String> formatItems = {
    "Portable Network Graphics (.png)": "png",
    "Icon (.ico)": "ico",
    "Graphics Interchange Format (.gif)": "gif",
    "Tagged Image File Format (.tiff)": "tiff",
    "Bitmap (.bmp)": "bmp",
    "WebP (.webp)": "webp",
    "PDF Document (.pdf)": "pdf",
  };

  Future<void> _uploadAndConvert() async {
    if (imageService.imageFile.value != null) {
      File file = imageService.imageFile.value!;
      final response = await convertService.convertImage(
        imageFile: file,
        format: selectedValue.toString(), // 👈 you can choose from dropdown
        quality: 0.9,
      );

      if (response != null && response.statusCode == 200) {
        print("✅ Converted successfully");
        print(response.data); // could be URL or Base64
      } else {
        print("❌ Failed to convert");
      }
    } else {
      print("⚠️ No image selected");
    }
  }
  // 👇 find uploaded extension (if any)

  @override
  Widget build(BuildContext context) {
    String? uploadedExt;
    if (imageService.imageFile.value != null) {
      uploadedExt = p
          .extension(imageService.imageFile.value!.path)
          .replaceAll(".", "")
          .toLowerCase();
    }

    // 👇 filter out uploaded extension
    final filteredItems = Map.fromEntries(
      formatItems.entries.where((entry) => entry.value != uploadedExt),
    );

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text("Image Convert ")),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Select Formate',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text(
              'Convert your images in different formates...',
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: height * 0.01),

            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(19),
              ),
              width: double.infinity,
              height: MediaQuery.of(context).size.height * 0.29,
              child: Obx(() {
                if (imageService.imageFile.value != null) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(
                      19,
                    ), // 👈 apply same radius
                    child: Image.file(
                      imageService.imageFile.value!,
                      height: 200,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  );
                } else {
                  return const Center(child: Text("No image selected"));
                }
              }),
            ),
            SizedBox(height: height * 0.03),

            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade400),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    height: MediaQuery.of(context).size.height * 0.06,
                    //color: Colors.grey,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownButton<String>(
                        hint: const Text("Select format"),
                        isExpanded: true,
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.grey,
                        ),
                        value: selectedValue,
                        items: filteredItems.entries.map((entry) {
                          return DropdownMenuItem<String>(
                            value: entry.value,
                            child: Text(entry.key),
                          );
                        }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            selectedValue = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 15),

                Expanded(
                  child: GestureDetector(
                    onTap: _uploadAndConvert,
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.06,

                      decoration: BoxDecoration(
                        //color: Colors.grey,
                        color: Color(0xff726DDE),
                        borderRadius: BorderRadius.circular(8),
                      ),

                      child: Center(
                        child: Text(
                          "Convert Size",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Obx(
            //   () => imageService.base64String.value.isNotEmpty
            //       ? Expanded(
            //           child: SingleChildScrollView(
            //             child: Text("", style: const TextStyle(fontSize: 12)),
            //           ),
            //         )
            //       : const SizedBox.shrink(),
            // ),
          ],
        ),
      ),
    );
  }
}
