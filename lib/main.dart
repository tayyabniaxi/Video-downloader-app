import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:qaisar/Controller/user_controller.dart';
//import 'package:media_store_plus/media_store_plus.dart';
import 'package:qaisar/screens/splash.dart';

import 'Controller/network_connection_controller.dart';
import 'video_downloader_service.dart';

void main() async{
 // await dotenv.load(fileName: ".env");
  await dotenv.load(fileName: ".env");
  Get.put(VideoDownloaderService());
  Get.put(NetworkController());
  //Get.put( UserController());

  //await MediaStore.ensureInitialized();
  //MediaStore.appFolder = "";
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color(0xffF9F9F9)),
      ),
      home: const Splash(),
    );
  }
}