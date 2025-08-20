import 'package:flutter/material.dart';
import 'package:qaisar/components/tool_appbar_text.dart';

import '../../components/upload_image.dart';

class ImageEnhancer extends StatefulWidget {
  const ImageEnhancer({super.key});

  @override
  State<ImageEnhancer> createState() => _ImageEnhancerState();
}

class _ImageEnhancerState extends State<ImageEnhancer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ToolAppbarText(text: 'Image Enhancer'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Image Enhancer',style: TextStyle(fontSize: 18,fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
            SizedBox(height: height * 0.01),
            Text('Convert your images in different formates...',style: TextStyle(fontSize: 14)),
            SizedBox(height: height * 0.02),
            UploadImage(width: width, height: height)
          ],
        ),
      ),
    );
  }
}
