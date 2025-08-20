import 'package:flutter/material.dart';
import 'package:qaisar/components/tool_appbar_text.dart';
import 'package:qaisar/components/upload_image.dart';

class ImageConverter extends StatelessWidget {
  const ImageConverter({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ToolAppbarText(text: 'Image Converter'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Text('Image Converter',style: TextStyle(fontSize: 18,fontFamily: 'Montserrat',fontWeight: FontWeight.bold)),
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
