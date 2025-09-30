import 'dart:convert';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:get/get.dart';


class ImageService extends GetxService{
  final ImagePicker _picker = ImagePicker();
  var imageFile = Rx<File?>(null);
  var base64String = RxString('');

  /// Pick image from gallery
  Future<void> pickFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      base64String.value = await fileToBase64(imageFile.value!) ?? '';
    }
  }

  /// Pick image from camera
  Future<void> pickFromCamera() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
      base64String.value = await fileToBase64(imageFile.value!) ?? '';
    }
  }

  /// Convert File to Base64 String
  Future<String?> fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  /// Convert Base64 String back to File
  Future<File?> base64ToFile(String base64Str, String savePath) async {
    try {
      final bytes = base64Decode(base64Str);
      final file = File(savePath);
      await file.writeAsBytes(bytes);
      return file;
    } catch (_) {
      return null;
    }
  }
}