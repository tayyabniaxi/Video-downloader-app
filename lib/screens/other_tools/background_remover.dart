import 'package:flutter/material.dart';
import 'package:qaisar/assets/app_assets.dart';
import 'package:qaisar/components/tool_appbar_text.dart';

import '../../components/upload_image.dart';

class BackgroundRemover extends StatelessWidget {
  const BackgroundRemover({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ToolAppbarText(text: 'Background Remover'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset(AppImages.backgroundRemover)),
            SizedBox(height: height * 0.02),
            UploadImage(width: width, height: height),
          ],
        ),
      ),
    );
  }
}