import 'package:flutter/material.dart';
import 'package:qaisar/components/custom_text_field.dart';

import '../../assets/app_assets.dart';
import '../../components/tool_appbar_text.dart';

class WebsiteScreenshot extends StatefulWidget {
  const WebsiteScreenshot({super.key});

  @override
  State<WebsiteScreenshot> createState() => _WebsiteScreenshotState();
}

class _WebsiteScreenshotState extends State<WebsiteScreenshot> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: ToolAppbarText(text: 'Website Screenshot'),
        backgroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              'Website Screenshot',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: height * 0.01),
            Text('Create Website Screenshots', style: TextStyle(fontSize: 14)),
            SizedBox(height: height * 0.02),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Image.asset(AppIcons.iconLink),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child: Container(
                      width: width * 0.15,
                      height: height * 0.01,
                      decoration: BoxDecoration(
                        color: const Color(0xff726DDE),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.all(6),
                      child: Image.asset(AppIcons.arrow),
                    ),
                  ),
                  hintText: 'Enter website url...',
                  hintStyle: TextStyle(
                    color: Color(0xFF000000),
                    fontSize: 16,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w600,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Color(0xff9591E6),
                      width: width * 0.004,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: const Color(0xff2684FF),
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
